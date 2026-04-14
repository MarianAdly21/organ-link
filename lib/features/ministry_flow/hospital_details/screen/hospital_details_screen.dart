import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/_core/widgets/base_stateful_screen_widget.dart';
import 'package:organ_link/apis/_base/dio_api_manager.dart';
import 'package:organ_link/apis/managers/ministry_manager/ministry_api_manager.dart';
import 'package:organ_link/features/hospital_flow/widget/app_base_body_scaffold.dart';
import 'package:organ_link/features/ministry_flow/hospital_details/bloc/hospital_details_bloc.dart';
import 'package:organ_link/features/ministry_flow/hospital_details/bloc/hospital_details_repository.dart';
import 'package:organ_link/features/ministry_flow/hospital_details/models/ministry_hospital_details_ui_model.dart';
import 'package:organ_link/features/ministry_flow/widgets/conut_container.dart';
import 'package:organ_link/features/ministry_flow/widgets/info_tile_with_status_custom_widget.dart';
import 'package:organ_link/features/shared_screens/method/calculate_age.dart';
import 'package:organ_link/features/user_flow/case_follow_up/widget/gradient_progress_bar.dart';
import 'package:organ_link/features/widgets/app_base_progress.dart';
import 'package:organ_link/features/widgets/container_with_shadow.dart';
import 'package:organ_link/features/widgets/custom_divider_widget.dart';
import 'package:organ_link/features/widgets/internet_error_widget.dart';
import 'package:organ_link/res/app_asset_paths.dart';
import 'package:organ_link/res/app_colors.dart';
import 'package:organ_link/utils/empty/empty_widgets.dart';
import 'package:organ_link/utils/feedback/feedback_message.dart';
import 'package:organ_link/utils/locale/app_localization_keys.dart';

class HospitalDetailsScreen extends StatelessWidget {
  const HospitalDetailsScreen({super.key, required this.id});
  static const routeName = "/hospital-details-screen";
  final int id;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HospitalDetailsBloc(
        HospitalDetailsRepository(
          ministryApiManager: MinistryApiManager(
            dioApiManager: GetIt.I<DioApiManager>(),
          ),
        ),
      ),
      child: HospitalDetailsScreenWithBloc(id: id),
    );
  }
}

class HospitalDetailsScreenWithBloc extends BaseStatefulScreenWidget {
  const HospitalDetailsScreenWithBloc({super.key, required this.id});
  final int id;

  @override
  BaseScreenState<BaseStatefulScreenWidget> baseScreenCreateState() =>
      _HospitalDetailsScreenState();
}

class _HospitalDetailsScreenState
    extends BaseScreenState<HospitalDetailsScreenWithBloc> {
  late MinistryHospitalDetailsUiModel ministryHospitalDetailsUiModel;
  @override
  void initState() {
    _currentBloc.add(GetHospitalDetailsDataEvent(id: widget.id));
    super.initState();
  }

  HospitalDetailsBloc get _currentBloc => context.read<HospitalDetailsBloc>();

  @override
  Widget baseScreenBuild(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: AppBaseBodyScaffold(
        titleOfScreen: context.translate(LocalizationKeys.hospitalDetails),
        backTap: () {
          Navigator.pop(context);
        },
        body: BlocConsumer<HospitalDetailsBloc, HospitalDetailsState>(
          listener: (context, state) {
            if (state is HospitalDetailsLoadingState) {
              showLoading();
            } else {
              hideLoading();
            }
            if (state is HospitalDetailsDataLoadedSuccessfullyState) {
              ministryHospitalDetailsUiModel =
                  state.ministryHospitalDetailsUiModel;
            } else if (state is HospitalDetailsErrorState &&
                state.codeError != 1016) {
              showFeedbackMessage(
                context: context,
                feedbackStyle: FeedbackStyle.snackBar,
                state.errorMessage,
              );
            }
          },
          buildWhen: (previous, current) =>
              current is HospitalDetailsDataLoadedSuccessfullyState ||
              current is HospitalDetailsErrorState,

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

  Widget _buildBody(HospitalDetailsState state) {
    if (state is HospitalDetailsDataLoadedSuccessfullyState) {
      return SingleChildScrollView(
        child: Column(
          children: [
            _infoHospitalSection(),
            _countRow(),
            _progressCard(),
            _hospitalNeedSection(),
            _lastOperationsSection(),
            _devicesAndEquipmentSection(),
          ],
        ),
      );
    } else if (state is HospitalDetailsErrorState && state.codeError == 1016) {
      return InternetErrorWidget();
    } else {
      return EmptyWidget();
    }
  }

  Widget _hospitalNeedSection() {
    return ContainerWithShadow(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 2.w),
      contentPadding: EdgeInsets.only(
        top: 24.h,
        left: 16.w,
        right: 16.w,
        bottom: 16.h,
      ),
      sectionTitle: context.translate(LocalizationKeys.hospitalNeeds),
      titleColor: AppColors.textColor,
      child: Column(
        children: [
          _hospitalNeedRow(
            organName: ministryHospitalDetailsUiModel.organNeeds[0].organName,
            needCount: ministryHospitalDetailsUiModel.organNeeds[0].organCount
                .toString(),
          ),
          _hospitalNeedRow(
            organName: ministryHospitalDetailsUiModel.organNeeds[1].organName,
            needCount: ministryHospitalDetailsUiModel.organNeeds[1].organCount
                .toString(),
          ),
          _hospitalNeedRow(
            organName: ministryHospitalDetailsUiModel.organNeeds[2].organName,
            needCount: ministryHospitalDetailsUiModel.organNeeds[2].organCount
                .toString(),
          ),
        ],
      ),
    );
  }

  Widget _lastOperationsSection() {
    return ministryHospitalDetailsUiModel.lastSurgeries.isEmpty
        ? SizedBox.shrink()
        : ContainerWithShadow(
            padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 2.w),
            contentPadding: EdgeInsets.only(
              top: 24.h,
              left: 16.w,
              right: 16.w,
              bottom: 16.h,
            ),
            sectionTitle: context.translate(LocalizationKeys.lastSurgeries),
            titleColor: AppColors.textColor,
            child: ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: ministryHospitalDetailsUiModel.lastSurgeries.length,
              itemBuilder: (context, index) {
                return _lastOperationsRow(
                  title:
                      ministryHospitalDetailsUiModel.lastSurgeries[index].organ,
                  subtitle:
                      "${context.translate(LocalizationKeys.patientAge)}:${calculateAge(ministryHospitalDetailsUiModel.lastSurgeries[index].age)} ${context.translate(LocalizationKeys.year)} | ${DateFormat('yyyy-MM-dd').format(ministryHospitalDetailsUiModel.lastSurgeries[index].date)}",
                  status: ministryHospitalDetailsUiModel
                      .lastSurgeries[index]
                      .surgeryStatus,
                );
              },
            ),
          );
  }

  Widget _devicesAndEquipmentSection() {
    return ContainerWithShadow(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 2.w),
      contentPadding: EdgeInsets.only(
        top: 24.h,
        left: 16.w,
        right: 16.w,
        bottom: 16.h,
      ),
      sectionTitle: "الأجهزة والمعدات",
      titleColor: AppColors.textColor,
      child: Column(
        children: [
          _lastOperationsRow(
            title: "MRI جهاز",
            subtitle: "العدد: 2",
            status: "متاح",
          ),
          _lastOperationsRow(
            title: "مختبر تحليل دم",
            subtitle: "العدد: 5",
            status: "متاح",
          ),
        ],
      ),
    );
  }

  Widget _hospitalNeedRow({
    required String organName,
    required String needCount,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  organName,
                  style: context.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  "$needCount ${context.translate(LocalizationKeys.caseText)}",
                  style: context.textTheme.labelMedium!.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: 13,
                    color: AppColors.textColor,
                  ),
                ),
              ],
            ),
            GradientProgressBar(width: 139.w, value: 1 / 5),
          ],
        ),
        CustomDividerWidget(),
      ],
    );
  }

  Widget _lastOperationsRow({
    required String title,
    required String subtitle,
    required String status,
  }) {
    return Column(
      children: [
        InfoTileWithStatusCustomWidget(
          title: title,
          status: status,
          subtitle: subtitle,
        ),
        CustomDividerWidget(),
      ],
    );
  }

  Widget _progressCard() {
    return Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: AppBaseProgress(
        radius: 16,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      AppAssetPaths.inProgressIcon,
                      width: 28.w,
                      height: 28.w,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      context.translate(LocalizationKeys.successRate),
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Text(
                  "${ministryHospitalDetailsUiModel.successPercentage.toInt()}%",
                  style: context.textTheme.labelMedium!.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            GradientProgressBar(
              value: ministryHospitalDetailsUiModel.successPercentage,
            ),
          ],
        ),
      ),
    );
  }

  Widget _countRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        CountContainer(
          padding: EdgeInsetsDirectional.only(end: 16, start: 2.w),
          title: context.translate(LocalizationKeys.surgeries),
          count: ministryHospitalDetailsUiModel.totalSurgeries.toString(),
        ),
        CountContainer(
          padding: EdgeInsetsDirectional.only(end: 16),
          title: context.translate(LocalizationKeys.donors),
          count: ministryHospitalDetailsUiModel.totalDonors.toString(),
        ),
        CountContainer(
          padding: EdgeInsetsDirectional.only(end: 2.w),
          title: context.translate(LocalizationKeys.patients),
          count: ministryHospitalDetailsUiModel.totalPatients.toString(),
        ),
      ],
    );
  }

  Widget _infoHospitalSection() {
    return ContainerWithShadow(
      contentPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InfoTileWithStatusCustomWidget(
            title: ministryHospitalDetailsUiModel.hospitalName,
            status: ministryHospitalDetailsUiModel.hospitalStatus,
            subtitle: ministryHospitalDetailsUiModel.hospitalLocation,
          ),
          CustomDividerWidget(),
          FittedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _infoColumn(
                  text1: ministryHospitalDetailsUiModel.hospitalType,
                  icon1: AppAssetPaths.hospitalTypeIcon,
                  text2: ministryHospitalDetailsUiModel.phone,
                  icon2: AppAssetPaths.callIcon,
                ),
                SizedBox(width: 46.w),
                _infoColumn(
                  text1: ministryHospitalDetailsUiModel.email,
                  icon1: AppAssetPaths.emailIcon,
                  text2: ministryHospitalDetailsUiModel.hospitalLocation,
                  icon2: AppAssetPaths.locationIcon,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoColumn({
    required String text1,
    required String icon1,
    required String text2,
    required String icon2,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _infoRow(padding: EdgeInsets.only(bottom: 9), icon: icon1, text: text1),
        _infoRow(icon: icon2, text: text2),
      ],
    );
  }

  Widget _infoRow({
    required String text,
    required String icon,
    EdgeInsetsGeometry? padding,
  }) {
    return Padding(
      padding: padding ?? EdgeInsets.all(0),
      child: Row(
        children: [
          SvgPicture.asset(icon),
          SizedBox(width: 8),
          Text(
            text,
            style: context.textTheme.labelMedium!.copyWith(
              color: AppColors.blackText,
              fontWeight: FontWeight.w400,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
