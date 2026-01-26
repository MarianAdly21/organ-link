import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/_core/widgets/base_stateful_screen_widget.dart';
import 'package:organ_link/features/hospital_flow/surgeries/extension/opertion_status_ui.dart';
import 'package:organ_link/features/hospital_flow/surgeries/models/surgeries_ui_model.dart';
import 'package:organ_link/features/hospital_flow/widget/container_with_background.dart';
import 'package:organ_link/features/hospital_flow/widget/hospital_base_body_scaffold.dart';
import 'package:organ_link/features/widgets/app_buttons/app_button_with_gradient_colors.dart';
import 'package:organ_link/features/widgets/container_with_shadow.dart';
import 'package:organ_link/features/widgets/custom_divider_widget.dart';
import 'package:organ_link/features/widgets/custom_over_view_container.dart';
import 'package:organ_link/features/widgets/data_row_with_divider.dart';
import 'package:organ_link/res/app_colors.dart';

class SurgeriesScreen extends BaseStatefulScreenWidget {
  const SurgeriesScreen({super.key});
  static const routeName = "/surgeries-screen";

  @override
  BaseScreenState<BaseStatefulScreenWidget> baseScreenCreateState() =>
      _SurgeriesScreenState();
}

class _SurgeriesScreenState extends BaseScreenState<SurgeriesScreen> {
  /// demo data
  List<SurgeryUiModel> surgeriesList = [
    SurgeryUiModel(
      surgeryName: "عملية زراعة كلي",
      surgeryNumber: "OP002",
      surgeryState: OperationStatus.completed,
      patientName: "عمر الزهراني",
      donorName: "سارة أحمد",
      hospitalName: "الجراحة - عيادة الكلي",
      date: "15-02-2025",
    ),
  ];
  @override
  Widget baseScreenBuild(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: HospitalBaseBodyScaffold(
        titleOfScreen: "Surgeries",
        backTap: () {},
        body: _buildBody(),
      ),
    );
  }

  ///////////////////////////////////////////////////////////
  /////////////////// Helper widget ////////////////////////
  ///////////////////////////////////////////////////////////

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [_headerWidget(), _surgeriesList()],
      ),
    );
  }

  Widget _headerWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text("سجل العمليات", style: context.textTheme.bodyMedium),
        Text(
          "متابعة عمليات زراعة الأعضاء",
          style: context.textTheme.labelMedium,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 24.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomOverViewContainer(
                backgroundColor: Color(0xffFFF2DC),
                text: "تحت المتابعة",
                count: "10",
              ),
              CustomOverViewContainer(
                backgroundColor: Color(0xffDEFFDF),
                text: "مكتملة",
                count: "5",
              ),
              CustomOverViewContainer(
                backgroundColor: Color(0xffE6F4FF),
                text: "جارية",
                count: "1",
              ),
              CustomOverViewContainer(
                backgroundColor: Color(0xffFCE4FF),
                text: "مدجولة",
                count: "5",
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _surgeriesList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "قائمة العمليات",
          style: context.textTheme.bodyMedium!.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.blackText,
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: surgeriesList.length,
          itemBuilder: (context, index) {
            return ContainerWithShadow(
              borderSideColor: surgeriesList[index].surgeryState.sideColor,
              padding: EdgeInsets.symmetric(vertical: 12.h),
              contentPadding: EdgeInsets.symmetric(
                vertical: 24.h,
                horizontal: 16.w,
              ),
              child: Column(
                children: [
                  _surgeryNameAndIdAndStatusRow(index),
                  CustomDividerWidget(),
                  DataRowWithDivider(
                    divider: true,
                    title: context.translate("المريض"),
                    subTitle: surgeriesList[index].patientName,
                  ),
                  DataRowWithDivider(
                    divider: true,
                    title: context.translate("المتبرع"),
                    subTitle: surgeriesList[index].donorName,
                  ),
                  DataRowWithDivider(
                    divider: true,
                    title: context.translate("القسم"),
                    subTitle: surgeriesList[index].hospitalName,
                  ),
                  DataRowWithDivider(
                    title: context.translate("التاريخ"),
                    subTitle: surgeriesList[index].date,
                  ),
                  CustomDividerWidget(indent: 24.w, endIndent: 24.w),
                  SizedBox(height: 16.h),
                  AppButtonWithGradientColors(text: "التفاصيل", onTap: () {}),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _surgeryNameAndIdAndStatusRow(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              surgeriesList[index].surgeryName,
              style: context.textTheme.bodyMedium!.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.blackText,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Text(
                "رقم العملية:${surgeriesList[index].surgeryNumber}",
                style: context.textTheme.labelMedium!.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        ContainerWithBackground(
          backgroundColor: surgeriesList[index].surgeryState.badgeBackground,
          text: surgeriesList[index].surgeryState.label,
        ),
      ],
    );
  }
}
