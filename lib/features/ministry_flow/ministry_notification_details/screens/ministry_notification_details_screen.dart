import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/_core/widgets/base_stateful_screen_widget.dart';
import 'package:organ_link/features/hospital_flow/widget/app_base_body_scaffold.dart';
import 'package:organ_link/features/hospital_flow/widget/container_with_background.dart';
import 'package:organ_link/features/ministry_flow/widgets/title_and_subtitle_custom_widget.dart';
import 'package:organ_link/features/widgets/app_buttons/app_button_with_gradient_colors.dart';
import 'package:organ_link/features/widgets/container_with_black_shadow.dart';
import 'package:organ_link/features/widgets/custom_divider_widget.dart';
import 'package:organ_link/features/widgets/data_row_with_divider.dart';
import 'package:organ_link/features/widgets/data_row_with_status_container_widget.dart';
import 'package:organ_link/features/widgets/notice_container.dart';
import 'package:organ_link/features/widgets/text_field/app_text_form_filed_widget.dart';
import 'package:organ_link/res/app_colors.dart';

class MinistryNotificationDetailsScreen extends BaseStatefulScreenWidget {
  const MinistryNotificationDetailsScreen({super.key});
  static const routeName = "ministry-notification-details";
  @override
  BaseScreenState<BaseStatefulScreenWidget> baseScreenCreateState() =>
      _MinistryNotificationDetailsScreenState();
}

class _MinistryNotificationDetailsScreenState
    extends BaseScreenState<MinistryNotificationDetailsScreen> {
  @override
  Widget baseScreenBuild(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: AppBaseBodyScaffold(
        titleOfScreen: "Alart Details",
        backTap: () {
          Navigator.pop(context);
        },
        body: _buildBody(),
      ),
    );
  }

  ///////////////////////////////////////////////////////////
  /////////////////// Helper widget ////////////////////////
  ///////////////////////////////////////////////////////////

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w, vertical: 2.h),
        child: Column(
          children: [
            _headerContainer(),
            _descriptionSection(),
            _recordSupportSection(),
            NoticeContainer(
              padding: EdgeInsetsDirectional.only(
                end: 6,
                bottom: 24.h,
                top: 24.h,
              ),
              notice:
                  "سيتم إرسال إشعار للمستشفى عند اتخاذ أي إجراء بخصوص هذا التنبيه",
            ),
          ],
        ),
      ),
    );
  }

  Widget _recordSupportSection() {
    return ContainerWithBlackShadow(
      backgroundColor: AppColors.generalContainerBGMinistry,
      body: Column(
        children: [
          TitleAndSubtitleCustomWidget(
            title: "تسجيل الدعم",
            subTitle: "للدعم الفني والمساعدة",
          ),
          CustomDividerWidget(),
          _textField(
            padding: EdgeInsets.only(top: 16.h),
            title: "البريد الالكتروني",
            hintText: "giza.hospital@moh.gov.eg",
          ),
          _textField(title: " رقم الهاتف", hintText: "+201024567890"),
          _textField(
            padding: EdgeInsets.all(0),
            title: "المسؤول",
            hintText: "د. أحمد محمود - مسؤول النظام",
          ),
          Padding(
            padding: EdgeInsets.only(top: 16.h),
            child: Row(
              children: [
                Expanded(
                  child: AppButtonWithGradientColors(
                    colors: [Color(0xffCC0C10), Color(0xffCC0C10)],
                    onTap: () {},
                    text: context.translate("اتخاذ إجراء"),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: AppButtonWithGradientColors(
                    onTap: () {},
                    text: context.translate("تجاهل"),
                    textColor: AppColors.blackText,
                    border: BoxBorder.all(color: AppColors.backButtonBorder),
                    colors: [
                      AppColors.followUpInvestigation,
                      AppColors.followUpInvestigation,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget _infoNoticeCard({required String noteText ,EdgeInsetsGeometry? padding,}) {
  //   return Padding(
  //     padding:
  //         padding ??
  //         EdgeInsetsDirectional.only(end: 6, top: 24.h, bottom: 24.h),
  //     child: Container(
  //       padding: EdgeInsets.symmetric(vertical: 16, horizontal: 26),
  //       // height: 75.h,
  //       // width: 311.w,
  //       decoration: BoxDecoration(
  //         color: AppColors.medicalTestContainerBG,
  //         gradient: LinearGradient(
  //           begin: Alignment.centerLeft,
  //           end: Alignment.centerRight,
  //           colors: [
  //             AppColors.hospitalInfoColorBG2,
  //             AppColors.hospitalInfoColorBG1,
  //           ],
  //         ),
  //         borderRadius: BorderRadius.circular(16),
  //         boxShadow: [
  //           BoxShadow(
  //             color: AppColors.hospitalInfoShadow,
  //             offset: Offset(4, 0),
  //           ),
  //         ],
  //       ),
  //       child: Text(
  //         textAlign: TextAlign.center,
  //         context.translate(
  //         noteText
  //         ),
  //         style: context.textTheme.displayMedium!.copyWith(
  //           fontSize: 16,
  //           color: AppColors.hospitalInfoText,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  Widget _textField({
    required String title,
    required String hintText,
    EdgeInsetsGeometry? padding,
  }) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(vertical: 24.h),
      child: AppTextFormField(
        enable: false,
        title: title,
        hintText: hintText,
        hintTextStyle: context.textTheme.labelMedium!.copyWith(
          color: AppColors.blackText,
        ),
      ),
    );
  }

  Widget _descriptionSection() {
    return ContainerWithBlackShadow(
      padding: EdgeInsets.symmetric(vertical: 24.h),
      contentPadding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
      backgroundColor: AppColors.generalContainerBGMinistry,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            "Description",
            style: context.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.blackText,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "  تم تسجيل عملية زراعة دون توثيق كامل للإجراءات المطلوبة. يجب الالتزام بتقديم hhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhhh الوثائق المطلوبة قبل إتمام العملية.",
            style: context.textTheme.labelMedium!.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
          CustomDividerWidget(verticalPadding: 24),
          DataRowWithStatusContianerWidget(
            title: "الحالة",
            subTitle: "متابعة التحقيق",
            backgroundColor: AppColors.medicalTestDoneBG,
            divider: true,
          ),
          DataRowWithDivider(
            divider: true,
            title: "نوع الإشعار",
            subTitle: "حرج",
          ),
          DataRowWithDivider(
            divider: true,
            title: "تاريخ الإنشاء",
            subTitle: "1/11/2025",
          ),
          DataRowWithDivider(title: "الأولوية", subTitle: "عالية"),
        ],
      ),
    );
  }

  Widget _headerContainer() {
    return ContainerWithBlackShadow(
      gradientBackgroundColor: [
        /// change based on its status
        /// status==> تم الحل
        AppColors.resolveStatusContainerBGMinistryAlart,
        AppColors.resolveStatusContainerBGMinistryAlart,

        /// status==> خطر
        //  AppColors.dangerStatusContainerBGMinistryAlart1,
        //  AppColors.dangerStatusContainerBGMinistryAlart2,

        /// status==> تحذير
        // AppColors.warningStatusContainerBGMinistryAlart1,
        // AppColors.warningStatusContainerBGMinistryAlart2,
      ],
      contentPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      body: Column(
        children: [
          ContainerWithBackground(
            backgroundColor: AppColors.resolveStatusBGMinistryAlart,
            text: "text",
            textColor: AppColors.statusTextInMinistryAlart,
          ),
          SizedBox(height: 16.h),
          Text(
            "لا يوجد تقارير عملية زراعة",
            style: context.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          CustomDividerWidget(endIndent: 36, indent: 36),
          Text(
            "1/11/2025 - 11:49:32 م",
            style: context.textTheme.labelMedium!.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 13,
            ),
          ),
        ],
      ),
    );
  }
}
