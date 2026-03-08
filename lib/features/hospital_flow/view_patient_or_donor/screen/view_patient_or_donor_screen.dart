import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/_core/widgets/base_stateful_screen_widget.dart';
import 'package:organ_link/apis/_base/dio_api_manager.dart';
import 'package:organ_link/apis/managers/hospital_manager/hospital_api_manager.dart';
import 'package:organ_link/features/hospital_flow/enum/nav_type.dart';
import 'package:organ_link/features/hospital_flow/patient_or_donor_details/screen/patient_or_donor_details_screen.dart';
import 'package:organ_link/features/hospital_flow/view_patient_or_donor/bloc/view_patient_or_donor_bloc.dart';
import 'package:organ_link/features/hospital_flow/view_patient_or_donor/bloc/view_patient_or_donor_repository.dart';
import 'package:organ_link/features/hospital_flow/view_patient_or_donor/models/patient_or_donor_ui_model.dart';
import 'package:organ_link/features/hospital_flow/widget/container_with_background.dart';
import 'package:organ_link/features/hospital_flow/widget/app_base_body_scaffold.dart';
import 'package:organ_link/features/hospital_flow/widget/app_search_custom_widget.dart';
import 'package:organ_link/features/hospital_flow/widget/status_row_widget.dart';
import 'package:organ_link/features/ministry_flow/widgets/title_and_subtitle_custom_widget.dart';
import 'package:organ_link/features/shared_screens/method/calculate_age.dart';
import 'package:organ_link/features/widgets/app_buttons/app_button_with_gradient_colors.dart';
import 'package:organ_link/features/widgets/container_with_shadow.dart';
import 'package:organ_link/features/widgets/internet_error_widget.dart';
import 'package:organ_link/features/widgets/text_field/custom_drop_down_form_filed_widget.dart';
import 'package:organ_link/preferences/preferences_manager.dart';
import 'package:organ_link/res/app_colors.dart';
import 'package:organ_link/utils/empty/empty_widgets.dart';
import 'package:organ_link/utils/feedback/feedback_message.dart';
import 'package:organ_link/utils/locale/app_localization_keys.dart';

class ViewPatientOrDonorScreen extends StatelessWidget {
  const ViewPatientOrDonorScreen({super.key, required this.type});
  final NavType type;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ViewPatientOrDonorBloc(
        ViewPatientOrDonorRepository(
          hospitalApiManager: HospitalApiManager(
            dioApiManager: GetIt.I<DioApiManager>(),
          ),
          preferencesManager: GetIt.I<PreferencesManager>(),
        ),
      ),
      child: ViewPatientOrDonorScreenWithBloc(type: type),
    );
  }
}

class ViewPatientOrDonorScreenWithBloc extends BaseStatefulScreenWidget {
  const ViewPatientOrDonorScreenWithBloc({super.key, required this.type});
  final NavType type;

  @override
  BaseScreenState<BaseStatefulScreenWidget> baseScreenCreateState() =>
      _ViewPatientOrDonorScreenWithBlocState();
}

class _ViewPatientOrDonorScreenWithBlocState
    extends BaseScreenState<ViewPatientOrDonorScreenWithBloc> {
  late List<PatientOrDonorUiModel> modelList;
  //late List<PatientOrDonorUiModel> modelListSearch;
  late bool isDonor;
  @override
  void initState() {
    isDonor = (widget.type == NavType.donor);
    _getViewPatientOrDonorDataEvent();
    super.initState();
  }

  @override
  Widget baseScreenBuild(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: BlocConsumer<ViewPatientOrDonorBloc, ViewPatientOrDonorState>(
        listener: (context, state) {
          if (state is ViewPatientOrDonorLoadingState) {
            showLoading();
          } else {
            hideLoading();
          }
          if (state is ViewPatientOrDonorDataLoadedSuccessfullyState) {
            modelList = state.donorOrPatientList;
            // modelListSearch=state.donorOrPatientList;
          } else if (state is NavToDetailsScreenState) {
            _navToDetailsScreen(state.id);
          } else if (state is ViewPatientOrDonorErrorState &&
              state.codeError != 1016) {
            showFeedbackMessage(state.errorMessage);
          }
        },
        buildWhen: (previous, current) =>
            current is ViewPatientOrDonorDataLoadedSuccessfullyState ||
            current is ViewPatientOrDonorErrorState,
        builder: (context, state) {
          return AppBaseBodyScaffold(
            titleOfScreen: isDonor
                ? LocalizationKeys.donorTitle
                : LocalizationKeys.patientTitle,
            backTap: () {
              Navigator.pop(context);
            },
            body: _buildBody(state),
          );
        },
      ),
    );
  }

  ///////////////////////////////////////////////////////////
  /////////////////// Helper widget ////////////////////////
  ///////////////////////////////////////////////////////////

  Widget _buildBody(ViewPatientOrDonorState state) {
    if (state is ViewPatientOrDonorDataLoadedSuccessfullyState) {
      return Column(
        children: [
          _searchSection(),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Text(
                    "${isDonor ? context.translate(LocalizationKeys.donors) : context.translate(LocalizationKeys.patients)} (${modelList.length})",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.blackText,
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: modelList.length,
                    (context, index) {
                      return _cardItem(index);
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      );
    } else if (state is ViewPatientOrDonorErrorState &&
        state.codeError == 1016) {
      return InternetErrorWidget();
    } else {
      return EmptyWidget();
    }
  }

  Widget _cardItem(int index) {
    return ContainerWithShadow(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 2),
      contentPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _nameAndId(
            name: modelList[index].fullName,
            id: modelList[index].medicalRecordNumber,
          ),
          _infoRow(
            age: "${calculateAge(modelList[index].age)}",
            bloodType: modelList[index].bloodType,
            organ: modelList[index].organ,
          ),
          StatusRowWidget(
            priority: modelList[index].priority,
            status: modelList[index].status,
          ),
          SizedBox(height: 16.h),
          AppButtonWithGradientColors(
            text: context.translate(LocalizationKeys.details),
            onTap: () {
              _navToDetailsScreenEvent(modelList[index].id);
            },
          ),
        ],
      ),
    );
  }

  Widget _infoRow({
    required String age,
    required String bloodType,
    required String organ,
  }) {
    return Padding(
      padding: EdgeInsets.only(top: 8.h, bottom: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _infoRowText(
            text:
                "${context.translate(LocalizationKeys.age)}: $age ${context.translate(LocalizationKeys.year)}",
          ),
          _infoRowText(
            text:
                "${context.translate(LocalizationKeys.bloodType)}: $bloodType",
          ),
          _infoRowText(
            text: "${context.translate(LocalizationKeys.organ)}: $organ",
          ),
        ],
      ),
    );
  }

  Widget _infoRowText({required String text}) {
    return Text(
      text,
      style: context.textTheme.labelMedium!.copyWith(color: AppColors.grayText),
    );
  }

  Widget _nameAndId({required String name, required String id}) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          name,
          style: context.bodyMedium!.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(width: 16.w),
        ContainerWithBackground(
          backgroundColor: AppColors.idContainerBG,
          text: id,
        ),
      ],
    );
  }

  Widget _searchSection() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TitleAndSubtitleCustomWidget(
          title: isDonor
              ? context.translate(LocalizationKeys.donorsList)
              : context.translate(LocalizationKeys.patientsList),
          subTitle: context.translate(
            LocalizationKeys.transplantPatientsManagement,
          ),
        ),
        SizedBox(height: 16.h),
        AppSearchCustomWidget(
          hintText: LocalizationKeys.searchByNameOrMRN,
          onChanged: (value) {
            // _search(value);
            _currentBloc.add(SearchByNamePatientOrDonorEvent(query: value));
          },
        ),
        _searchByOrganOrCaseSection(),
      ],
    );
  }

  Widget _searchByOrganOrCaseSection() {
    return Padding(
      padding: EdgeInsets.only(top: 16.h, bottom: 24.h),
      child: Row(
        children: [
          _shadowContainer(
            child: CustomDropDownFormFiledWidget(
              hintText: context.translate(LocalizationKeys.allOrgans),
              itemTextStyle: context.textTheme.labelMedium!.copyWith(
                color: AppColors.blackText,
              ),
              items: [
                CustomDropDownItem(value: "كلي يمنى", key: ""),
                CustomDropDownItem(value: "كلي يسرى", key: ""),
                CustomDropDownItem(value: "كبد", key: ""),
              ],
              onChanged: (value) {
                _currentBloc.add(
                  SearchByOrganOrStatusPatientOrDonorEvent(organ: value!.value),
                );
              },
            ),
          ),
          SizedBox(width: 16.w),
          _shadowContainer(
            child: CustomDropDownFormFiledWidget(
              hintText: context.translate(LocalizationKeys.allCases),
              itemTextStyle: context.textTheme.labelMedium!.copyWith(
                color: AppColors.blackText,
              ),
              items: [
                CustomDropDownItem(value: "قيد المراجعه", key: ""),
                CustomDropDownItem(value: "جاهز", key: ""),
                CustomDropDownItem(value: "تمت المطابقة", key: ""),
              ],
              onChanged: (value) {
                _currentBloc.add(
                  SearchByOrganOrStatusPatientOrDonorEvent(
                    status: value!.value,
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _shadowContainer({required Widget child}) {
    return Expanded(
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: child,
      ),
    );
  }

  ///////////////////////////////////////////////////////////
  /////////////////// Helper method ////////////////////////
  ///////////////////////////////////////////////////////////
  ViewPatientOrDonorBloc get _currentBloc =>
      context.read<ViewPatientOrDonorBloc>();
  void _navToDetailsScreenEvent(int id) {
    _currentBloc.add(NavToDetailsScreenEvent(id: id));
  }

  void _navToDetailsScreen(int id) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => PatientOrDonorDetailsScreen(id: id, type: widget.type),
      ),
    );
  }

  void _getViewPatientOrDonorDataEvent() {
    _currentBloc.add(GetViewPatientOrDonorDataEvent(type: widget.type));
  }

  //   void _search(String query) {
  //   if (query.isEmpty) {
  //     setState(() {
  //       modelListSearch = modelList;
  //     });
  //     return;
  //   }
  //   final searchLower = query.toLowerCase();
  //   final filtered =
  //       modelList.where((item) {
  //         return item.fullName.toLowerCase().contains(searchLower) ||
  //             item.medicalRecordNumber.toLowerCase().contains(searchLower);
  //       }).toList();
  //   setState(() {
  //     modelListSearch = filtered;
  //   });
  // }
}
