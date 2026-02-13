import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/_core/widgets/base_stateful_screen_widget.dart';
import 'package:organ_link/features/user_flow/case_follow_up/models/step_ui_model.dart';
import 'package:organ_link/features/user_flow/case_follow_up/widget/gradient_progress_bar.dart';
import 'package:organ_link/features/user_flow/procedure_scheduling/screen/procedure_scheduling_screen.dart';
import 'package:organ_link/features/user_flow/widget/base_body_scaffold.dart';
import 'package:organ_link/features/widgets/notice_container.dart';
import 'package:organ_link/features/widgets/app_base_progress.dart';
import 'package:organ_link/features/widgets/app_buttons/app_button_with_gradient_colors.dart';
import 'package:organ_link/features/widgets/container_with_shadow.dart';
import 'package:organ_link/res/app_asset_paths.dart';
import 'package:organ_link/res/app_colors.dart';
import 'package:organ_link/utils/locale/app_localization_keys.dart';

class CaseFollowUpScreen extends BaseStatefulScreenWidget {
  const CaseFollowUpScreen({super.key});
  static const routeName = "/case-follow-up-screen";
  @override
  BaseScreenState<BaseStatefulScreenWidget> baseScreenCreateState() =>
      _CaseFollowUpScreenState();
}

class _CaseFollowUpScreenState extends BaseScreenState<CaseFollowUpScreen> {
  final List<StepUiModel> steps = [
    StepUiModel(
      stepTitle: LocalizationKeys.dataRegistration,
      stepDescription: LocalizationKeys.dataRRegistrationSuccessfully,
      isDone: true,
    ),
    StepUiModel(
      stepTitle: LocalizationKeys.initialTests,
      stepDescription: LocalizationKeys.initialTestsDescription,
      isDone: true,
    ),
    StepUiModel(
      stepTitle: LocalizationKeys.donorSearch,
      stepDescription: LocalizationKeys.initialTestsDescription,
      isDone: true,
    ),
    StepUiModel(
      stepTitle: LocalizationKeys.tissueCompatibilityTest,
      stepDescription: LocalizationKeys.tissueCompatibilityDescription,
      isDone: true,
    ),
    StepUiModel(
      stepTitle: LocalizationKeys.procedureScheduling,
      stepDescription: LocalizationKeys.procedureSchedulingDescription,
      isDone: true,
    ),
    StepUiModel(
      stepTitle: LocalizationKeys.transplantProcedure,
      stepDescription: LocalizationKeys.transplantProcedureDescription,
      isDone: false,
    ),
  ];
  bool isScheduling = true;
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
    return BaseBodyScaffold(
      title: context.translate(LocalizationKeys.caseFollowUp),
      onBackTap: () {
        Navigator.pop(context);
      },
      body: Column(
        children: [
          ListView.builder(
            itemCount: steps.length,
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return _stepCard(
                title: context.translate(steps[index].stepTitle),
                subTitle: context.translate(steps[index].stepDescription),
                doneHistory: " 1 سبتمبر 2025",
                isDone: steps[index].isDone,
              );
            },
          ),
          _progressSummaryCard(),
          isScheduling
              ? AppButtonWithGradientColors(
                  text: context.translate(LocalizationKeys.procedureScheduling),
                  onTap: () {
                    Navigator.of(
                      context,
                    ).pushNamed(ProcedureSchedulingScreen.routeName);
                  },
                )
              : SizedBox.shrink(),
          SizedBox(height: 32.h),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: NoticeContainer(
              height: 95.h,
              notice: LocalizationKeys.caseUpdateNote,
            ),
          ),
        ],
      ),
    );
  }

  Widget _progressSummaryCard() {
    return AppBaseProgress(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
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
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      context.translate(LocalizationKeys.progressSummary),
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      context.translate(LocalizationKeys.completedSteps),
                      style: context.textTheme.labelMedium!.copyWith(
                        color: AppColors.grayText,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          GradientProgressBar(value: 3 / 6),
          SizedBox(height: 8.h),
          Text(
            '3 from 6',
            style: context.textTheme.labelMedium!.copyWith(
              color: AppColors.grayText,
              fontWeight: FontWeight.w400,
              fontSize: 12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _stepCard({
    required String title,
    required String subTitle,
    required bool isDone,
    required String doneHistory,
  }) {
    return ContainerWithShadow(
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 2.w),
      child: Padding(
        padding: const EdgeInsetsDirectional.only(
          top: 16,
          bottom: 16,
          start: 16,
          end: 52,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            isDone
                ? SvgPicture.asset(AppAssetPaths.cloudDoneIcon)
                : SvgPicture.asset(AppAssetPaths.hourglassIcon),
            SizedBox(width: 16.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    context.translate(title),
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 13.h),
                  Text(
                    softWrap: true,
                    overflow: TextOverflow.visible,
                    context.translate(subTitle),
                    style: context.textTheme.labelMedium!.copyWith(
                      color: AppColors.grayText,
                    ),
                  ),
                  SizedBox(height: 24.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        doneHistory,
                        style: context.textTheme.labelMedium!.copyWith(
                          color: AppColors.grayText,
                          fontWeight: FontWeight.w400,
                          fontSize: 13,
                        ),
                      ),

                      isDone ? SizedBox.shrink() : _containerInProgress(),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _containerInProgress() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(41),
        gradient: LinearGradient(
          begin: AlignmentGeometry.centerLeft,
          end: AlignmentGeometry.centerRight,
          colors: [Color(0xff1F99F1), Color(0xff00D0F3)],
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
        child: Text(
          context.translate(LocalizationKeys.inProgress),
          style: context.textTheme.labelMedium!.copyWith(
            color: AppColors.textColor,
            fontWeight: FontWeight.w500,
            fontSize: 11,
          ),
        ),
      ),
    );
  }
}
