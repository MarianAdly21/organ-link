import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/_core/widgets/base_stateful_screen_widget.dart';
import 'package:organ_link/features/hospital_flow/enum/operation_status.dart';
import 'package:organ_link/features/hospital_flow/extension/operation_status_ui.dart';
import 'package:organ_link/features/hospital_flow/surgery_details/models/surgery_details_ui_model.dart';
import 'package:organ_link/features/hospital_flow/widget/app_base_body_scaffold.dart';
import 'package:organ_link/features/widgets/app_buttons/app_button_with_gradient_colors.dart';
import 'package:organ_link/features/widgets/container_with_shadow.dart';
import 'package:organ_link/features/widgets/data_row_with_divider.dart';
import 'package:organ_link/features/widgets/data_row_with_status_container_widget.dart';
import 'package:organ_link/res/app_colors.dart';
import 'package:organ_link/utils/locale/app_localization_keys.dart';

class SurgeryDetailsScreen extends BaseStatefulScreenWidget {
  const SurgeryDetailsScreen({super.key, required this.id});
  static const String routeName = "/surgery-details-screen";
  final int id;

  @override
  BaseScreenState<BaseStatefulScreenWidget> baseScreenCreateState() =>
      _SurgeryDetailsScreenState();
}

class _SurgeryDetailsScreenState extends BaseScreenState<SurgeryDetailsScreen> {
  final SurgeryDetailsUiModel surgeryDetailsUiModel = SurgeryDetailsUiModel(
    surgeryNumber: "Op001",
    organType: "كلى",
    responsibleSurgeon: "د. عبدالله خالد",
    department: "الجراحة - عيادة الكلي",
    date: "15-02-2025",
    surgeryStatus: "جارية",
    patientName: "أحمد محمد العلي",
    patientFileNumber: "P001",
    donorName: "سارة أحمد",
    donorNameFileNumber: "D001",
  );
  @override
  Widget baseScreenBuild(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: _buildBody(),
    );
  }
  ///////////////////////////////////////////////////////////
  /////////////////// Helper widget ////////////////////////
  ///////////////////////////////////////////////////////////

  Widget _buildBody() {
    return AppBaseBodyScaffold(
      titleOfScreen: LocalizationKeys.surgeryDetails,
      backTap: () {
        Navigator.pop(context);
      },
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "${context.translate(LocalizationKeys.surgeryNumber)}:${surgeryDetailsUiModel.surgeryNumber}",
              style: context.textTheme.bodyLarge,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: _surgeryInfoSection(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: _patientInfoSection(),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 2),
              child: _donorInfoSection(),
            ),
            if (surgeryDetailsUiModel.date != null) ...[_infoNoticeCard()],
          ],
        ),
      ),
    );
  }

  Widget _surgeryInfoSection() {
    return ContainerWithShadow(
      borderSideColor: mapOperationStatus(
        surgeryDetailsUiModel.surgeryStatus,
      ).sideColor,
      padding: EdgeInsets.symmetric(vertical: 12.h),
      contentPadding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
      sectionTitle: context.translate(LocalizationKeys.surgeryInformation),
      child: Column(
        children: [
          DataRowWithDivider(
            divider: true,
            title: context.translate(LocalizationKeys.organ),
            subTitle: surgeryDetailsUiModel.organType,
          ),
          DataRowWithDivider(
            divider: true,
            title: context.translate(LocalizationKeys.responsibleSurgeon),
            subTitle: surgeryDetailsUiModel.responsibleSurgeon,
          ),
          DataRowWithDivider(
            divider: true,
            title: context.translate(LocalizationKeys.department),
            subTitle: surgeryDetailsUiModel.department,
          ),
          DataRowWithDivider(
            divider: true,
            title: context.translate(LocalizationKeys.date),
            subTitle: surgeryDetailsUiModel.date ?? "",
          ),
          DataRowWithStatusContianerWidget(
            title: LocalizationKeys.surgeryStatus,
            subTitle: surgeryDetailsUiModel.surgeryStatus,
            backgroundColor: mapOperationStatus(
              surgeryDetailsUiModel.surgeryStatus,
            ).badgeBackground,
            subTitleColor: mapOperationStatus(
              surgeryDetailsUiModel.surgeryStatus,
            ).sideColor,
          ),
        ],
      ),
    );
  }

  Widget _donorInfoSection() {
    return ContainerWithShadow(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      contentPadding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
      sectionTitle: context.translate(LocalizationKeys.donorInformation),
      child: Column(
        children: [
          DataRowWithDivider(
            divider: true,
            title: context.translate(LocalizationKeys.donorName),
            subTitle: surgeryDetailsUiModel.donorName,
          ),
          DataRowWithDivider(
            title: context.translate(LocalizationKeys.fileNumberWithoutColumn),
            subTitle: surgeryDetailsUiModel.donorNameFileNumber,
          ),
          SizedBox(height: 24.h),
          AppButtonWithGradientColors(
            text: context.translate(LocalizationKeys.goToPatientFile),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _patientInfoSection() {
    return ContainerWithShadow(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      contentPadding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
      sectionTitle: context.translate(LocalizationKeys.patientInformation),
      child: Column(
        children: [
          DataRowWithDivider(
            divider: true,
            title: context.translate(LocalizationKeys.patientName),
            subTitle: surgeryDetailsUiModel.patientName,
          ),
          DataRowWithDivider(
            title: context.translate(LocalizationKeys.fileNumberWithoutColumn),
            subTitle: surgeryDetailsUiModel.patientFileNumber,
          ),
          SizedBox(height: 24.h),
          AppButtonWithGradientColors(
            text: context.translate(LocalizationKeys.goToPatientFile),
            onTap: () {},
          ),
        ],
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
