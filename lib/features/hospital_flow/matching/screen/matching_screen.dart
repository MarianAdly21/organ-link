import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/_core/widgets/base_stateful_screen_widget.dart';
import 'package:organ_link/features/hospital_flow/matching_details/screen/matching_details_screen.dart';
import 'package:organ_link/features/hospital_flow/widget/container_with_background.dart';
import 'package:organ_link/features/hospital_flow/widget/app_base_body_scaffold.dart';
import 'package:organ_link/features/widgets/app_buttons/app_button_with_gradient_colors.dart';
import 'package:organ_link/features/widgets/container_with_shadow.dart';
import 'package:organ_link/features/widgets/custom_divider_widget.dart';
import 'package:organ_link/features/widgets/custom_over_view_container.dart';
import 'package:organ_link/features/widgets/data_row_with_divider.dart';
import 'package:organ_link/res/app_colors.dart';
import 'package:organ_link/utils/locale/app_localization_keys.dart';

class MatchingScreen extends BaseStatefulScreenWidget {
  const MatchingScreen({super.key});
  static const routeName = "/matching-screen";
  @override
  BaseScreenState<BaseStatefulScreenWidget> baseScreenCreateState() =>
      _MatchingScreenState();
}

class _MatchingScreenState extends BaseScreenState<MatchingScreen> {
  @override
  Widget baseScreenBuild(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: AppBaseBodyScaffold(
        titleOfScreen: "Matching",
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
        children: [_headerWidget(), _requestList()],
      ),
    );
  }

  Widget _headerWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text("طلبات المطابقة", style: context.textTheme.bodyMedium),
        Text(
          "متابعة طلبات المطابقة من نظام الذكاء الاصطناعي",
          style: context.textTheme.labelMedium,
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 24.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomOverViewContainer(
                isGradient: true,
                text: "إجمالي الطلبات",
                count: "1000",
              ),
              CustomOverViewContainer(text: "تحت المطابقة", count: "5"),
              CustomOverViewContainer(text: "قيد التحليل", count: "100"),
              CustomOverViewContainer(text: "تحت المراجعة", count: "100"),
            ],
          ),
        ),
      ],
    );
  }

  Widget _requestList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          "قائمة الطلبات",
          style: context.textTheme.bodyMedium!.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.blackText,
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: 5,
          itemBuilder: (context, index) {
            return ContainerWithShadow(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              contentPadding: EdgeInsets.symmetric(
                vertical: 24.h,
                horizontal: 16.w,
              ),
              child: Column(
                children: [
                  _nameAndIdAndStatusRow(),
                  CustomDividerWidget(),
                  DataRowWithDivider(
                    divider: true,
                    title: context.translate("العضو"),
                    subTitle: "كلى",
                  ),
                  DataRowWithDivider(
                    divider: true,
                    title: context.translate("تاريخ الطلب"),
                    subTitle: "2025-10-15",
                  ),
                  DataRowWithDivider(
                    title: context.translate("نسبة التطابق"),
                    subTitle: "%95",
                  ),

                  /// notes: the divider and container appears based on condition
                  CustomDividerWidget(indent: 24.w, endIndent: 24.w),
                  _resultMatching(),
                  SizedBox(height: 16.h),
                  AppButtonWithGradientColors(
                    text: "التفاصيل",
                    onTap: () {
                      Navigator.of(
                        context,
                      ).pushNamed(MatchingDetailsScreen.routeName);
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

  Widget _resultMatching() {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.readyTextBG,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "تم العثور علي متبرع متطابق",

            ///message from back
            style: context.textTheme.bodyMedium!.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.readyText,
            ),
          ),

          Text(
            "المتبرع: سارة أحمد",
            style: context.textTheme.labelMedium!.copyWith(
              color: AppColors.readyText,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "فصيلة الدم: +A",
                style: context.textTheme.labelMedium!.copyWith(
                  color: AppColors.readyText,
                ),
              ),
              ContainerWithBackground(
                backgroundColor: AppColors.importantInfContainerBG,
                text: "تمت المطابقة",
                textColor: AppColors.textColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _nameAndIdAndStatusRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "أحمد محمد العلي",
              style: context.textTheme.bodyMedium!.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.blackText,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Text(
                "${context.translate(LocalizationKeys.fileNumber)} 12345",
                style: context.textTheme.labelMedium!.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        ContainerWithBackground(
          backgroundColor: AppColors.readyTextBG,
          text: "جاهز",
        ),
      ],
    );
  }
}
