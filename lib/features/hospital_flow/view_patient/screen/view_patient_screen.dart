import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/_core/widgets/base_stateful_screen_widget.dart';
import 'package:organ_link/features/hospital_flow/view_patient/helper_method/get_priority.dart';
import 'package:organ_link/features/hospital_flow/view_patient/helper_method/get_status.dart';
import 'package:organ_link/features/hospital_flow/widget/container_with_background.dart';
import 'package:organ_link/features/hospital_flow/widget/hospital_base_body_scaffold.dart';
import 'package:organ_link/features/hospital_flow/widget/app_search_custom_widget.dart';
import 'package:organ_link/features/hospital_flow/widget/status_row_widget.dart';
import 'package:organ_link/features/widgets/app_buttons/app_button_with_gradient_colors.dart';
import 'package:organ_link/features/widgets/container_with_shadow.dart';
import 'package:organ_link/features/widgets/text_field/custom_drop_down_form_filed_widget.dart';
import 'package:organ_link/res/app_colors.dart';
import 'package:organ_link/utils/locale/app_localization_keys.dart';

class ViewPatientScreen extends BaseStatefulScreenWidget {
  const ViewPatientScreen({super.key});
  static const routeName = "/view-patient-screen";

  @override
  BaseScreenState<BaseStatefulScreenWidget> baseScreenCreateState() =>
      _ViewPatientScreenState();
}

class _ViewPatientScreenState extends BaseScreenState<ViewPatientScreen> {
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
    return HospitalBaseBodyScaffold(
      titleOfScreen: LocalizationKeys.patientTitle,
      backTap: () {
        Navigator.pop(context);
      },
      body: Column(
        children: [
          _searchSection(),
          Expanded(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Text(
                    "المرضي (5)",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: AppColors.blackText,
                    ),
                  ),
                ),
                SliverList(
                  delegate: SliverChildBuilderDelegate(childCount: 5, (
                    context,
                    index,
                  ) {
                    return ContainerWithShadow(
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 16.h,
                        horizontal: 16.w,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _nameAndId(),
                          _infoRow(),
                          // _statusRow(),
                          StatusRowWidget(
                            priority: "أولوية عالية",
                            status: "جاهز",
                          ),
                          SizedBox(height: 16.h),
                          AppButtonWithGradientColors(
                            text: "التفاصيل",
                            onTap: () {},
                          ),
                        ],
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Widget _statusRow() {
  //   return Row(
  //     mainAxisSize: MainAxisSize.min,
  //     children: [
  //       _containerWithBG(
  //         backgroundColor: getPriority("أولوية عالية").backgroundColor,
  //         textColor: getPriority("أولوية عالية").textColor,
  //         text: getPriority("أولوية عالية").priority,
  //       ),
  //       SizedBox(width: 16.w),
  //       _containerWithBG(
  //         backgroundColor: getStatus("جاهز").backgroundColor,
  //         textColor: getStatus("جاهز").textColor,
  //         text: getStatus("جاهز").status,
  //       ),
  //     ],
  //   );
  // }

  Widget _infoRow() {
    return Padding(
      padding: EdgeInsets.only(top: 8.h, bottom: 16.h),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _infoRowText(text: "age: 12 years"),
          _infoRowText(text: "Blood Type: A+"),
          _infoRowText(text: "organ:hhhhhh "),
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

  Widget _nameAndId() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          "أحمد محمد العلي",
          style: context.bodyMedium!.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(width: 16.w),
        ContainerWithBackground(
          backgroundColor: AppColors.idContainerBG,
          text: "100p",
        ),
      ],
    );
  }

  // Widget _containerWithBG({
  //   Color? textColor,
  //   required Color backgroundColor,
  //   required String text,
  // }) {
  //   return Container(
  //     padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
  //     decoration: BoxDecoration(
  //       borderRadius: BorderRadius.circular(12),
  //       color: backgroundColor,
  //     ),
  //     child: Text(
  //       text,
  //       style: context.textTheme.labelMedium!.copyWith(
  //         color: textColor ?? AppColors.grayText,
  //         fontSize: 13,
  //         fontWeight: FontWeight.w400,
  //       ),
  //     ),
  //   );
  // }

  Widget _searchSection() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          context.translate(LocalizationKeys.patientList),
          style: context.textTheme.bodyLarge!.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          context.translate(LocalizationKeys.transplantPatientsManagement),
          style: context.textTheme.labelMedium!.copyWith(
            color: AppColors.grayText,
          ),
        ),
        SizedBox(height: 16.h),
        AppSearchCustomWidget(hintText: LocalizationKeys.searchByNameOrMRN),
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
                CustomDropDownItem(value: "كلي", key: "كلي"),
                CustomDropDownItem(value: "كبد", key: "كبد"),
                CustomDropDownItem(value: "رئه", key: "رئه"),
                CustomDropDownItem(value: "قلب", key: "قلب"),
              ],
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
                CustomDropDownItem(value: "قيد المراجعه", key: "كلي"),
                CustomDropDownItem(value: "جاهز", key: "كبد"),
                CustomDropDownItem(value: "تمت المطابقة", key: "رئه"),
              ],
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
}
