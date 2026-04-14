import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/_core/widgets/base_stateful_screen_widget.dart';
import 'package:organ_link/apis/_base/dio_api_manager.dart';
import 'package:organ_link/apis/managers/ministry_manager/ministry_api_manager.dart';
import 'package:organ_link/features/hospital_flow/enum/hospital_status.dart';
import 'package:organ_link/features/hospital_flow/extension/hospital_status_ui.dart';
import 'package:organ_link/features/hospital_flow/widget/app_base_body_scaffold.dart';
import 'package:organ_link/features/hospital_flow/widget/app_search_custom_widget.dart';
import 'package:organ_link/features/hospital_flow/widget/container_with_background.dart';
import 'package:organ_link/features/ministry_flow/hospital_detailes/screen/hospital_details_screen.dart';
import 'package:organ_link/features/ministry_flow/hospitals/bloc/hospital_list_bloc.dart';
import 'package:organ_link/features/ministry_flow/hospitals/bloc/hospital_list_repository.dart';
import 'package:organ_link/features/ministry_flow/hospitals/models/hospital_ui_model.dart';
import 'package:organ_link/features/ministry_flow/hospitals/models/hospitals_list_ui_model.dart';
import 'package:organ_link/features/ministry_flow/hospitals/models/organ_needs_ui_model.dart';
import 'package:organ_link/features/ministry_flow/widgets/conut_container.dart';
import 'package:organ_link/features/ministry_flow/widgets/info_tile_with_status_custom_widget.dart';
import 'package:organ_link/features/ministry_flow/widgets/title_and_subtitle_custom_widget.dart';
import 'package:organ_link/features/widgets/app_buttons/app_button_with_gradient_colors.dart';
import 'package:organ_link/features/widgets/container_with_shadow.dart';
import 'package:organ_link/features/widgets/internet_error_widget.dart';
import 'package:organ_link/res/app_colors.dart';
import 'package:organ_link/utils/empty/empty_widgets.dart';
import 'package:organ_link/utils/feedback/feedback_message.dart';
import 'package:organ_link/utils/locale/app_localization_keys.dart';

class HospitalsScreen extends StatelessWidget {
  const HospitalsScreen({super.key});
  static const routeName = "/hospitals-screen";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HospitalListBloc(
        HospitalListRepository(
          ministryApiManager: MinistryApiManager(
            dioApiManager: GetIt.I<DioApiManager>(),
          ),
        ),
      ),
      child: const HospitalsScreenWithBloc(),
    );
  }
}

class HospitalsScreenWithBloc extends BaseStatefulScreenWidget {
  const HospitalsScreenWithBloc({super.key});

  @override
  BaseScreenState<BaseStatefulScreenWidget> baseScreenCreateState() =>
      _HospitalsScreenState();
}

class _HospitalsScreenState extends BaseScreenState<HospitalsScreenWithBloc> {
  // final List<HospitalUiModel> demoData = [
  //   HospitalUiModel(
  //     hospitalName: "مستشفى القاهرة التخصصي",
  //     hospitalState: "نشط",
  //     city: "القاهرة",
  //     patientsCount: 775,
  //     donorsCount: 168,
  //     operationsCount: 1934,
  //     organNeeds: [
  //       OrganNeedModel(organName: "كلي", count: 5),
  //       OrganNeedModel(organName: "كبد", count: 5),
  //       OrganNeedModel(organName: "رئة", count: 5),
  //       OrganNeedModel(organName: "كلي", count: 5),
  //     ],
  //   ),
  //   HospitalUiModel(
  //     hospitalName: "مستشفى القاهرة التخصصي",
  //     hospitalState: "نشط",
  //     city: "القاهرة",
  //     patientsCount: 775,
  //     donorsCount: 168,
  //     operationsCount: 1934,
  //     organNeeds: [
  //       OrganNeedModel(organName: "كلي", count: 5),
  //       OrganNeedModel(organName: "كبد", count: 5),
  //       OrganNeedModel(organName: "رئة", count: 5),
  //       OrganNeedModel(organName: "كلي", count: 5),
  //     ],
  //   ),
  // ];

  late HospitalsListUiModel hospitalsListUiModel;
  @override
  void initState() {
    _currentBloc.add(GetHospitalListDataEvent());
    super.initState();
  }

  @override
  Widget baseScreenBuild(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: AppBaseBodyScaffold(
        titleOfScreen: context.translate(LocalizationKeys.hospitals),
        backTap: () {
          Navigator.pop(context);
        },
        body: BlocConsumer<HospitalListBloc, HospitalListState>(
          listener: (context, state) {
            if (state is HospitalListLoadingState) {
              showLoading();
            } else {
              hideLoading();
            }
            if (state is HospitalListDataLoadedSuccessfullyState) {
              hospitalsListUiModel = state.hospitals;
            } else if (state is NavToHospitalDetailsScreenState) {
              _navToDetailsScreen(state.id);
            } else if (state is HospitalListErrorState &&
                state.codeError != 1016) {
              showFeedbackMessage(
                context: context,
                feedbackStyle: FeedbackStyle.snackBar,
                state.errorMessage,
              );
            }
          },
          builder: (context, state) {
            return _buildBody(state);
          },
        ),
      ),
    );
  }

  ///////////////////////////////////////////////////////////
  /////////////////// Helper widget ////////////////////////
  ///////////////////////////////////////////////////////////

  Widget _buildBody(HospitalListState state) {
    if (state is HospitalListDataLoadedSuccessfullyState) {
      return Column(children: [_searchSection(), _buildHospitalList()]);
    } else if (state is HospitalListErrorState && state.codeError == 1016) {
      return InternetErrorWidget();
    } else {
      return EmptyWidget();
    }
  }

  Widget _searchSection() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TitleAndSubtitleCustomWidget(
          title: context.translate(LocalizationKeys.participatingHospitalsList),
          subTitle:
              "${context.translate(LocalizationKeys.hospitalRegisteredInSystem)} 6 ",
        ),
        SizedBox(height: 16.h),
        AppSearchCustomWidget(
          hintText: context.translate(LocalizationKeys.searchForHospital),
          onChanged: (value) {},
        ),
      ],
    );
  }

  Widget _buildHospitalList() {
    return Expanded(
      child: ListView.builder(
        itemCount: hospitalsListUiModel.hospitalsList.length,
        itemBuilder: (context, index) {
          return ContainerWithShadow(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            contentPadding: EdgeInsets.symmetric(
              vertical: 16.h,
              horizontal: 16.w,
            ),
            child: Column(
              children: [
                InfoTileWithStatusCustomWidget(
                  textStatusColor: mapHospitalStatus(
                    hospitalsListUiModel.hospitalsList[index].hospitalStatus,
                  ).textColor,
                  statusBGColor: mapHospitalStatus(
                    hospitalsListUiModel.hospitalsList[index].hospitalStatus,
                  ).backgroundColor,
                  title: hospitalsListUiModel.hospitalsList[index].hospitalName,
                  status:
                      hospitalsListUiModel.hospitalsList[index].hospitalStatus,
                  subtitle: hospitalsListUiModel
                      .hospitalsList[index]
                      .hospitalLocation,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CountContainer(
                        padding: EdgeInsetsDirectional.only(end: 16),
                        title: context.translate(LocalizationKeys.surgeries),
                        count: hospitalsListUiModel
                            .hospitalsList[index]
                            .surgeriesCount
                            .toString(),
                      ),
                      CountContainer(
                        padding: EdgeInsetsDirectional.only(end: 16),
                        title: context.translate(LocalizationKeys.donors),
                        count: hospitalsListUiModel
                            .hospitalsList[index]
                            .donorsCount
                            .toString(),
                      ),
                      CountContainer(
                        title: context.translate(LocalizationKeys.patients),
                        count: hospitalsListUiModel
                            .hospitalsList[index]
                            .patientsCount
                            .toString(),
                      ),
                    ],
                  ),
                ),
                _needsSection(
                  organNeedModelList:
                      hospitalsListUiModel.hospitalsList[index].organNeeds,
                ),
                AppButtonWithGradientColors(
                  text: context.translate(LocalizationKeys.details),
                  onTap: () {
                    _currentBloc.add(
                      NavToHospitalDetailsScreenEvent(
                        id: hospitalsListUiModel
                            .hospitalsList[index]
                            .hospitalId,
                      ),
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _needsSection({required List<OrganNeedsUiModel> organNeedModelList}) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            context.translate(LocalizationKeys.needs),
            style: context.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Expanded(
                child: _organNeedCount(
                  organNameAndCount:
                      " ${organNeedModelList[0].organName}: ${organNeedModelList[0].organCount}",
                  backgroundColor: Color(0xff8DBAFF),
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _organNeedCount(
                  organNameAndCount:
                      " ${organNeedModelList[1].organName}: ${organNeedModelList[1].organCount}",
                  backgroundColor: Color(0xff89FFB9),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          _organNeedCount(
            organNameAndCount:
                " ${organNeedModelList[2].organName}: ${organNeedModelList[2].organCount}",
            backgroundColor: Color(0xffFF7A7D),
          ),
          // _organNeedCountRow(
          //   organNeedModel1: organNeedModelList[2],
          //   color1: Color(0xff89FFB9),
          //   organNeedModel2: organNeedModelList[3],
          //   color2: Color(0xffFF7A7D),
          // ),
        ],
      ),
    );
  }

  // Widget _organNeedCountRow({
  //   required OrganNeedsUiModel organNeedModel1,
  //   required OrganNeedsUiModel organNeedModel2,
  //   required Color color1,
  //   required Color color2,
  // }) {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(vertical: 8.h),
  //     child: Row(
  //       children: [
  //         _organNeedCount(
  //           organNameAndCount:
  //               " ${organNeedModel1.organName}: ${organNeedModel1.count}",
  //           backgroundColor: color1,
  //         ),
  //         SizedBox(width: 16),
  //         _organNeedCount(
  //           organNameAndCount:
  //               " ${organNeedModel2.organName}: ${organNeedModel2.count}",
  //           backgroundColor: color2,
  //         ),
  //       ],
  //     ),
  //   );
  // }

  Widget _organNeedCount({
    required String organNameAndCount,
    required Color backgroundColor,
  }) {
    return ContainerWithBackground(
      contentPadding: EdgeInsets.symmetric(vertical: 8.h),
      isCentered: true,
      backgroundColor: backgroundColor,
      text: organNameAndCount,
      textStyle: context.textTheme.titleMedium!.copyWith(
        fontSize: 14,
        color: AppColors.blackText,
      ),
    );
  }

  ///////////////////////////////////////////////////////////
  /////////////////// Helper method ////////////////////////
  ///////////////////////////////////////////////////////////
  HospitalListBloc get _currentBloc => context.read<HospitalListBloc>();
  void _navToDetailsScreen(int id) {
    Navigator.of(
      context,
    ).push(MaterialPageRoute(builder: (_) => HospitalDetailsScreen(id: id)));
  }
}
