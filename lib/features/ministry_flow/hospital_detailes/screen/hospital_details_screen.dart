import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/_core/widgets/base_stateful_screen_widget.dart';
import 'package:organ_link/features/hospital_flow/widget/app_base_body_scaffold.dart';
import 'package:organ_link/features/ministry_flow/widgets/conut_container.dart';
import 'package:organ_link/features/ministry_flow/widgets/info_tile_with_status_custom_widget.dart';
import 'package:organ_link/features/user_flow/case_follow_up/widget/gradient_progress_bar.dart';
import 'package:organ_link/features/widgets/app_base_progress.dart';
import 'package:organ_link/features/widgets/container_with_shadow.dart';
import 'package:organ_link/features/widgets/custom_divider_widget.dart';
import 'package:organ_link/res/app_asset_paths.dart';
import 'package:organ_link/res/app_colors.dart';
import 'package:organ_link/utils/locale/app_localization_keys.dart';

class HospitalDetailsScreen extends BaseStatefulScreenWidget {
  const HospitalDetailsScreen({super.key});
  static const routeName = "/hospital-details-screen";
  @override
  BaseScreenState<BaseStatefulScreenWidget> baseScreenCreateState() =>
      _HospitalDetailsScreenState();
}

class _HospitalDetailsScreenState
    extends BaseScreenState<HospitalDetailsScreen> {
  @override
  Widget baseScreenBuild(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: AppBaseBodyScaffold(
        titleOfScreen: "Hospital Details",
        backTap: () {
          Navigator.pop(context);
        },
        body: SingleChildScrollView(
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
        ),
      ),
    );
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
      sectionTitle: "احتياجات المستشفى",
      titleColor: AppColors.textColor,
      child: Column(
        children: [
          _hospitalNeedRow(organName: "كلي", needCount: "15"),
          _hospitalNeedRow(organName: "كلي", needCount: "15"),
          _hospitalNeedRow(organName: "كلي", needCount: "15"),
        ],
      ),
    );
  }

  Widget _lastOperationsSection() {
    return ContainerWithShadow(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 2.w),
      contentPadding: EdgeInsets.only(
        top: 24.h,
        left: 16.w,
        right: 16.w,
        bottom: 16.h,
      ),
      sectionTitle: "العمليات الأخيرة",
      titleColor: AppColors.textColor,
      child: Column(
        children: [
          _lastOpertionsRow(
            title: "كلي",
            subtitle: "2025/1/28 | عمر المريض: سنة 45",
            status: "ناجحة",
          ),
        ],
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
          _lastOpertionsRow(
            title: "MRI جهاز",
            subtitle: "العدد: 2",
            status: "متاح",
          ),
          _lastOpertionsRow(
            title: "MRI جهاز",
            subtitle: "العدد: 2",
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
                  "$needCount حالة",
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

  Widget _lastOpertionsRow({
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
                      "نسبة النجاح",
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                Text(
                  "55%",
                  style: context.textTheme.labelMedium!.copyWith(
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            GradientProgressBar(value: 3 / 6),
          ],
        ),
      ),
    );
  }

  Widget _countRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ConutContainer(
          padding: EdgeInsetsDirectional.only(end: 16, start: 2.w),
          title: context.translate(LocalizationKeys.surgeries),
          count: "8758",
        ),
        ConutContainer(
          padding: EdgeInsetsDirectional.only(end: 16),
          title: context.translate(LocalizationKeys.donors),
          count: "567",
        ),
        ConutContainer(
          padding: EdgeInsetsDirectional.only(end: 2.w),
          title: context.translate(LocalizationKeys.patients),
          count: "123",
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
            title: "hospitalName",
            status: "State",
            subtitle: "city",
          ),
          CustomDividerWidget(),
          FittedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                _infoColumn(
                  text1: "مستشفي حكومي",
                  icon1: AppAssetPaths.hospitalTypeIcon,
                  text2: "01137498h907",
                  icon2: AppAssetPaths.callIcon,
                ),
                SizedBox(width: 46.w),
                _infoColumn(
                  text1: "Mdjh@gmailhdddhh.com",
                  icon1: AppAssetPaths.emailIcon,
                  text2: "Cario",
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
