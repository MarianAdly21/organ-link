import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/_core/extensions/screen_sizer_extension.dart';
import 'package:organ_link/_core/widgets/base_stateful_screen_widget.dart';
import 'package:organ_link/features/hospital_flow/enum/matching_status.dart';
import 'package:organ_link/features/hospital_flow/extension/matching_status_ui.dart';
import 'package:organ_link/features/hospital_flow/matching/models/matching_ui_model.dart';
import 'package:organ_link/features/hospital_flow/matching_details/screen/matching_details_screen.dart';
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

class MatchingScreen extends BaseStatefulScreenWidget {
  const MatchingScreen({super.key});
  static const routeName = "/matching-screen";
  @override
  BaseScreenState<BaseStatefulScreenWidget> baseScreenCreateState() =>
      _MatchingScreenState();
}

class _MatchingScreenState extends BaseScreenState<MatchingScreen> {
  ///demo data
  List<MatchingUiModel> matchingList = [
    MatchingUiModel(
      patientName: "أحمد محمد العلي",
      requestStatus: "تمت المطابقة",
      status: "جاهز",
      requestDate: "2025-10-15",
      donorName: "سارة أحمد",
      requestId: "12354",
      organType: "كلى",
      matchPercentage: "%95",
      donorBloodType: "A+",
      aiMessage: "تم العثور علي متبرع متطابق",
    ),
    MatchingUiModel(
      patientName: "خالد سعيد",
      requestStatus: "تحت المراجعة",
      status: "انتظار",
      requestDate: "2025-10-15",
      requestId: "12354",
      organType: "كلى",
      donorName: "أحمد محمود",
      matchPercentage: "%78",
      donorBloodType: "A+",
      aiMessage: "تم العثور علي متبرع متطابق",
    ),
  ];
  @override
  Widget baseScreenBuild(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: AppBaseBodyScaffold(
        titleOfScreen: context.translate(LocalizationKeys.matching),
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
        children: [_headerWidget(), _requestList()],
      ),
    );
  }

  Widget _headerWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TitleAndSubtitleCustomWidget(
          title: context.translate(LocalizationKeys.matchingRequests),
          subTitle: context.translate(
            LocalizationKeys.followuponAIMatchingRequests,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 24.h),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CustomOverViewContainer(
                isGradient: true,
                text: context.translate(LocalizationKeys.totalRequests),
                count: "1000",
              ),
              CustomOverViewContainer(
                text: context.translate(LocalizationKeys.underMatching),
                count: "5",
              ),
              CustomOverViewContainer(
                text: context.translate(LocalizationKeys.underAnalysis),
                count: "100",
              ),
              CustomOverViewContainer(
                text: context.translate(LocalizationKeys.underReview),
                count: "100",
              ),
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
          context.translate(LocalizationKeys.requestsList),
          style: context.textTheme.bodyMedium!.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.blackText,
          ),
        ),
        ListView.builder(
          shrinkWrap: true,
          physics: NeverScrollableScrollPhysics(),
          itemCount: matchingList.length,
          itemBuilder: (context, index) {
            return ContainerWithShadow(
              padding: EdgeInsets.symmetric(vertical: 12.h),
              contentPadding: EdgeInsets.symmetric(
                vertical: 24.h,
                horizontal: 16.w,
              ),
              child: Column(
                children: [
                  _nameAndIdAndStatusRow(index),
                  CustomDividerWidget(),
                  DataRowWithDivider(
                    divider: true,
                    title: context.translate(LocalizationKeys.organ),
                    subTitle: matchingList[index].organType,
                  ),
                  DataRowWithDivider(
                    divider: true,
                    title: context.translate(LocalizationKeys.requestDate),
                    subTitle: matchingList[index].requestDate,
                  ),
                  DataRowWithDivider(
                    title: context.translate(LocalizationKeys.matchPercentage),
                    subTitle: matchingList[index].matchPercentage,
                  ),

                  /// notes: the divider and container appears based on condition
                  if (matchingList[index].requestStatus != null) ...[
                    CustomDividerWidget(indent: 24.w, endIndent: 24.w),
                    _resultMatching(index),
                    if (matchingList[index].requestStatus ==
                        "لم يتم العثور") ...[
                      ContainerWithBackground(
                        isCentered: true,
                        width: context.width,
                        contentPadding: EdgeInsets.symmetric(vertical: 28.h),
                        backgroundColor: AppColors.notFoundBG,
                        text: "لم يتم العثور علي متبرع متطابق",
                        textStyle: context.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.notFoundtext,
                        ),
                      ),
                    ],
                  ],
                  SizedBox(height: 16.h),
                  AppButtonWithGradientColors(
                    text: context.translate(LocalizationKeys.details),
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

  Widget _resultMatching(int index) {
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
            matchingList[index].aiMessage,

            ///message from back
            style: context.textTheme.bodyMedium!.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.readyText,
            ),
          ),

          Text(
            "${context.translate(LocalizationKeys.donor)}: ${matchingList[index].donorName}",
            style: context.textTheme.labelMedium!.copyWith(
              color: AppColors.readyText,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${context.translate(LocalizationKeys.bloodType)}: ${matchingList[index].donorBloodType} ",
                style: context.textTheme.labelMedium!.copyWith(
                  color: AppColors.readyText,
                ),
              ),
              ContainerWithBackground(
                backgroundColor: mapMatchingStatus(
                  matchingList[index].requestStatus!,
                ).backgroundColor,
                text: matchingList[index].requestStatus!,
                textColor: mapMatchingStatus(
                  matchingList[index].requestStatus!,
                ).textColor,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _nameAndIdAndStatusRow(int index) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              matchingList[index].patientName,
              style: context.textTheme.bodyMedium!.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.blackText,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Text(
                "${context.translate(LocalizationKeys.requestId)}: ${matchingList[index].requestId}",
                style: context.textTheme.labelMedium!.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ],
        ),
        ContainerWithBackground(
          backgroundColor: mapMatchingStatus(
            matchingList[index].status,
          ).backgroundColor,
          text: matchingList[index].status,
          textColor: mapMatchingStatus(matchingList[index].status).textColor,
        ),
      ],
    );
  }
}
