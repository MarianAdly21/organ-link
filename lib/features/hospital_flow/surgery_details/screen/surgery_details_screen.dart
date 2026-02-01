import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/_core/widgets/base_stateful_screen_widget.dart';
import 'package:organ_link/features/hospital_flow/widget/container_with_background.dart';
import 'package:organ_link/features/hospital_flow/widget/app_base_body_scaffold.dart';
import 'package:organ_link/features/widgets/app_buttons/app_button_with_gradient_colors.dart';
import 'package:organ_link/features/widgets/container_with_shadow.dart';
import 'package:organ_link/features/widgets/data_row_with_divider.dart';
import 'package:organ_link/features/widgets/data_row_with_status_container_widget.dart';
import 'package:organ_link/res/app_colors.dart';
import 'package:organ_link/utils/locale/app_localization_keys.dart';

class SurgeryDetailsScreen extends BaseStatefulScreenWidget {
  const SurgeryDetailsScreen({super.key});
  static const String routeName = "/surgery-details-screen";

  @override
  BaseScreenState<BaseStatefulScreenWidget> baseScreenCreateState() =>
      _SurgeryDetailsScreenState();
}

class _SurgeryDetailsScreenState extends BaseScreenState<SurgeryDetailsScreen> {
  @override
  Widget baseScreenBuild(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    return AppBaseBodyScaffold(
      titleOfScreen: LocalizationKeys.surgeryDetails,
      backTap: () {},
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "${context.translate(LocalizationKeys.surgeryNumber)} OP001",
              style: context.textTheme.bodyLarge,
            ),
            ContainerWithShadow(
              borderSideColor: Colors.amber,
              padding: EdgeInsets.symmetric(vertical: 12.h),
              contentPadding: EdgeInsets.symmetric(
                vertical: 24.h,
                horizontal: 16.w,
              ),
              sectionTitle: context.translate(
                LocalizationKeys.surgeryInformation,
              ),
              child: Column(
                children: [
                  DataRowWithDivider(
                    divider: true,
                    title: context.translate(LocalizationKeys.organ),
                    subTitle: "كلي",
                  ),
                  DataRowWithDivider(
                    divider: true,
                    title: context.translate(
                      LocalizationKeys.responsibleSurgeon,
                    ),
                    subTitle: "د. عبدالله خالد",
                  ),
                  DataRowWithDivider(
                    divider: true,
                    title: context.translate(LocalizationKeys.department),
                    subTitle: "الجراحة - عيادة الكلي",
                  ),
                  DataRowWithDivider(
                    divider: true,
                    title: context.translate(LocalizationKeys.date),
                    subTitle: "15-02-2025",
                  ),
                  DataRowWithStatusContianerWidget(
                    title: LocalizationKeys.surgeryStatus,
                    subTitle: "مجدولة",
                    backgroundColor: AppColors.medicalTestDoneBG,
                  ),
                ],
              ),
            ),
            ContainerWithShadow(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              contentPadding: EdgeInsets.symmetric(
                vertical: 24.h,
                horizontal: 16.w,
              ),
              sectionTitle: context.translate(
                LocalizationKeys.patientInformation,
              ),
              child: Column(
                children: [
                  DataRowWithDivider(
                    divider: true,
                    title: context.translate(LocalizationKeys.patientName),
                    subTitle: "كلي",
                  ),
                  DataRowWithDivider(
                    title: context.translate(
                      LocalizationKeys.fileNumberWithoutColumn,
                    ),
                    subTitle: "كلي",
                  ),
                  SizedBox(height: 24.h),
                  AppButtonWithGradientColors(
                    text: context.translate(LocalizationKeys.goToPatientFile),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            ContainerWithShadow(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              contentPadding: EdgeInsets.symmetric(
                vertical: 24.h,
                horizontal: 16.w,
              ),
              sectionTitle: context.translate(
                LocalizationKeys.donorInformation,
              ),
              child: Column(
                children: [
                  DataRowWithDivider(
                    divider: true,
                    title: context.translate(LocalizationKeys.donorName),
                    subTitle: "كلي",
                  ),
                  DataRowWithDivider(
                    title: context.translate(
                      LocalizationKeys.fileNumberWithoutColumn,
                    ),
                    subTitle: "12345",
                  ),
                  SizedBox(height: 24.h),
                  AppButtonWithGradientColors(
                    text: context.translate(LocalizationKeys.goToPatientFile),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            _infoNoticeCard(),

            /// هتضهر لو العمليه اتحدد ليها معاد
          ],
        ),
      ),
    );
  }

  Widget _infoNoticeCard() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 4, vertical: 24.h),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(color: AppColors.notCardBorder),
          color: AppColors.notCardBG,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.translate("ملاحظات"),
                style: context.textTheme.bodyMedium,
              ),
              Text(
                context.translate("العملية محددة في الساعة 08:00 صباحا"),
                style: context.textTheme.labelMedium!.copyWith(
                  color: AppColors.seconderColor,
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
