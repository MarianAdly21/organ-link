import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/_core/widgets/base_stateful_screen_widget.dart';
import 'package:organ_link/features/hospital_flow/enum/operation_status.dart';
import 'package:organ_link/features/hospital_flow/extension/operation_status_ui.dart';
import 'package:organ_link/features/hospital_flow/surgeries/models/counter_ui_model.dart';
import 'package:organ_link/features/hospital_flow/surgeries/models/surgeries_ui_model.dart';
import 'package:organ_link/features/hospital_flow/surgery_details/screen/surgery_details_screen.dart';
import 'package:organ_link/features/hospital_flow/widget/container_with_background.dart';
import 'package:organ_link/features/hospital_flow/widget/app_base_body_scaffold.dart';
import 'package:organ_link/features/ministry_flow/widgets/title_and_subtitle_custom_widget.dart';
import 'package:organ_link/features/widgets/app_buttons/app_button_with_gradient_colors.dart';
import 'package:organ_link/features/widgets/container_with_shadow.dart';
import 'package:organ_link/features/widgets/custom_divider_widget.dart';
import 'package:organ_link/features/widgets/custom_over_view_container.dart';
import 'package:organ_link/features/widgets/data_row_with_divider.dart';
import 'package:organ_link/res/app_colors.dart';
import 'package:organ_link/utils/locale/app_localization_keys.dart';

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
      surgeryState: "جارية",
      patientName: "عمر الزهراني",
      donorName: "سارة أحمد",
      hospitalName: "الجراحة - عيادة الكلي",
      date: "15-02-2025",
    ),
  ];
  List<CounterUiModel> counters = [
    CounterUiModel(
      counterName: LocalizationKeys.underReview,
      count: 22,
      color: Color(0xffFFF2DC),
    ),
    CounterUiModel(
      counterName: LocalizationKeys.completed,
      count: 22,
      color: Color(0xffDEFFDF),
    ),
    CounterUiModel(
      counterName: LocalizationKeys.underReview,
      count: 22,
      color: Color(0xffE6F4FF),
    ),
    CounterUiModel(
      counterName: LocalizationKeys.scheduled,
      count: 376,
      color: Color(0xffFCE4FF),
    ),
  ];
  @override
  Widget baseScreenBuild(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: AppBaseBodyScaffold(
        titleOfScreen: context.translate(LocalizationKeys.surgeries),
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
        TitleAndSubtitleCustomWidget(
          title: context.translate(LocalizationKeys.surgeryRecord),
          subTitle: context.translate(LocalizationKeys.organTransplantFollowUp),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 24.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ...List.generate(
                counters.length,
                (index) => CustomOverViewContainer(
                  backgroundColor: counters[index].color,
                  text: context.translate(counters[index].counterName),
                  count: counters[index].count.toString(),
                ),
              ),
            ],
          ),

          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     CustomOverViewContainer(
          //       backgroundColor: Color(0xffFFF2DC),
          //       text: context.translate(LocalizationKeys.underReview),
          //       count: "10",
          //     ),
          //     CustomOverViewContainer(
          //       backgroundColor: Color(0xffDEFFDF),
          //       text: context.translate(LocalizationKeys.completed),
          //       count: "5",
          //     ),
          //     CustomOverViewContainer(
          //       backgroundColor: Color(0xffE6F4FF),
          //       text: context.translate(LocalizationKeys.ongoing),
          //       count: "1",
          //     ),
          //     CustomOverViewContainer(
          //       backgroundColor: Color(0xffFCE4FF),
          //       text: context.translate(LocalizationKeys.scheduled),
          //       count: "5",
          //     ),
          //   ],
          // ),
        ),
      ],
    );
  }

  Widget _surgeriesList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          context.translate(LocalizationKeys.surgeriesList),
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
              borderSideColor: mapOperationStatus(
                surgeriesList[index].surgeryState,
              ).sideColor,
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
                    title: context.translate(LocalizationKeys.patient),
                    subTitle: surgeriesList[index].patientName,
                  ),
                  DataRowWithDivider(
                    divider: true,
                    title: context.translate(LocalizationKeys.donor),
                    subTitle: surgeriesList[index].donorName,
                  ),
                  DataRowWithDivider(
                    divider: true,
                    title: context.translate(LocalizationKeys.department),
                    subTitle: surgeriesList[index].hospitalName,
                  ),
                  DataRowWithDivider(
                    title: context.translate(LocalizationKeys.date),
                    subTitle: surgeriesList[index].date,
                  ),
                  CustomDividerWidget(indent: 24.w, endIndent: 24.w),
                  SizedBox(height: 16.h),
                  AppButtonWithGradientColors(
                    text: context.translate(LocalizationKeys.details),
                    onTap: () {
                      Navigator.of(
                        context,
                      ).pushNamed(SurgeryDetailsScreen.routeName);
                    },
                  ),
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
                "${context.translate(LocalizationKeys.surgeryNumber)}:${surgeriesList[index].surgeryNumber}",
                style: context.textTheme.labelMedium!.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        ContainerWithBackground(
          backgroundColor: mapOperationStatus(
            surgeriesList[index].surgeryState,
          ).badgeBackground,
          text: surgeriesList[index].surgeryState,
        ),
      ],
    );
  }
}
