import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:intl/intl.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/_core/extensions/screen_sizer_extension.dart';
import 'package:organ_link/_core/widgets/base_stateful_screen_widget.dart';
import 'package:organ_link/apis/_base/dio_api_manager.dart';
import 'package:organ_link/apis/managers/hospital_manager/hospital_api_manager.dart';
import 'package:organ_link/features/hospital_flow/enum/matching_status.dart';
import 'package:organ_link/features/hospital_flow/extension/matching_status_ui.dart';
import 'package:organ_link/features/hospital_flow/matching/bloc/matching_bloc.dart';
import 'package:organ_link/features/hospital_flow/matching/bloc/matching_repository.dart';
import 'package:organ_link/features/hospital_flow/matching/models/match_ui_model.dart';
import 'package:organ_link/features/hospital_flow/matching_details/screen/matching_details_screen.dart';
import 'package:organ_link/features/hospital_flow/widget/container_with_background.dart';
import 'package:organ_link/features/hospital_flow/widget/app_base_body_scaffold.dart';
import 'package:organ_link/features/ministry_flow/widgets/title_and_subtitle_custom_widget.dart';
import 'package:organ_link/features/widgets/app_buttons/app_button_with_gradient_colors.dart';
import 'package:organ_link/features/widgets/container_with_shadow.dart';
import 'package:organ_link/features/widgets/custom_divider_widget.dart';
import 'package:organ_link/features/widgets/custom_over_view_container.dart';
import 'package:organ_link/features/widgets/data_row_with_divider.dart';
import 'package:organ_link/features/widgets/internet_error_widget.dart';
import 'package:organ_link/preferences/preferences_manager.dart';
import 'package:organ_link/res/app_colors.dart';
import 'package:organ_link/utils/empty/empty_widgets.dart';
import 'package:organ_link/utils/feedback/feedback_message.dart';
import 'package:organ_link/utils/locale/app_localization_keys.dart';

class MatchingScreen extends StatelessWidget {
  const MatchingScreen({super.key});
  static const routeName = "/matching-screen";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MatchingBloc(
        MatchingRepository(
          hospitalApiManager: HospitalApiManager(
            dioApiManager: GetIt.I<DioApiManager>(),
          ),
          preferencesManager: GetIt.I<PreferencesManager>(),
        ),
      ),
      child: MatchingScreenWithBloc(),
    );
  }
}

class MatchingScreenWithBloc extends BaseStatefulScreenWidget {
  const MatchingScreenWithBloc({super.key});
  @override
  BaseScreenState<BaseStatefulScreenWidget> baseScreenCreateState() =>
      _MatchingScreenWithBlocState();
}

class _MatchingScreenWithBlocState
    extends BaseScreenState<MatchingScreenWithBloc> {
  late MatchUiModel matchUiModel;
  @override
  void initState() {
    super.initState();
    _currentBloc.add(GetMatchingDataEvent());
  }

  MatchingBloc get _currentBloc => context.read<MatchingBloc>();
  @override
  Widget baseScreenBuild(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: AppBaseBodyScaffold(
        titleOfScreen: context.translate(LocalizationKeys.matching),
        backTap: () {
          Navigator.pop(context);
        },
        body: BlocConsumer<MatchingBloc, MatchingState>(
          listener: (context, state) {
            if (state is MatchingLoadingState) {
              showLoading();
            } else {
              hideLoading();
            }
            if (state is MatchingDataLoadedSuccessfullyState) {
              matchUiModel = state.matchUiModel;
            } else if (state is NavToMatchingDetailsScreenState) {
              _navToMatchingDetailsScreen(state);
            } else if (state is MatchingErrorState && state.codeError != 1016) {
              showFeedbackMessage(state.errorMessage);
            }
          },
          buildWhen: (previous, current) =>
              current is MatchingDataLoadedSuccessfullyState ||
              current is MatchingErrorState,

          builder: (context, state) {
            return _buildBody(state);
          },
        ),
      ),
    );
  }

  Widget _buildBody(MatchingState state) {
    if (state is MatchingDataLoadedSuccessfullyState) {
      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _headerWidget(),
            matchUiModel.matchList.isNotEmpty
                ? _requestList()
                : Center(
                    child: Text(
                      context.translate(
                        LocalizationKeys.noMatchingSurgeriesAtTheMoment,
                      ),
                      style: context.textTheme.bodyMedium,
                    ),
                  ),
          ],
        ),
      );
    } else if (state is MatchingErrorState && state.codeError == 1016) {
      return InternetErrorWidget();
    } else {
      return EmptyWidget();
    }
  }

  ///////////////////////////////////////////////////////////
  /////////////////// Helper widget ////////////////////////
  ///////////////////////////////////////////////////////////

  Widget _headerWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TitleAndSubtitleCustomWidget(
          title: context.translate(LocalizationKeys.matchingRequests),
          subTitle: context.translate(
            LocalizationKeys.followUponAIMatchingRequests,
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
                count: "${matchUiModel.totalMatchesCount}",
              ),
              CustomOverViewContainer(
                text: context.translate(LocalizationKeys.underMatching),
                count: "${matchUiModel.underMatchingCount}",
              ),
              CustomOverViewContainer(
                text: context.translate(LocalizationKeys.underAnalysis),
                count: "${matchUiModel.underAnalysisMatchesCount}",
              ),
              CustomOverViewContainer(
                text: context.translate(LocalizationKeys.underReview),
                count: "${matchUiModel.underReviewMatchesCount}",
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
          itemCount: matchUiModel.matchList.length,
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
                    subTitle: matchUiModel.matchList[index].patientOrgan,
                  ),
                  DataRowWithDivider(
                    divider: true,
                    title: context.translate(LocalizationKeys.requestDate),
                    subTitle: DateFormat(
                      "dd/MM/yyyy",
                    ).format(matchUiModel.matchList[index].requestMatchingDate),
                  ),
                  if (matchUiModel.matchList[index].matchPercentage != null)
                    DataRowWithDivider(
                      title: context.translate(
                        LocalizationKeys.matchPercentage,
                      ),
                      subTitle:
                          "${matchUiModel.matchList[index].matchPercentage!}%",
                    ),

                  /// notes: the divider and container appears based on condition
                  if (matchUiModel.matchList[index].matchPercentage !=
                      null) ...[
                    CustomDividerWidget(indent: 24.w, endIndent: 24.w),
                    _resultMatching(index),
                    if (matchUiModel.matchList[index].status ==
                        "لم يتم العثور") ...[
                      ContainerWithBackground(
                        isCentered: true,
                        width: context.width,
                        contentPadding: EdgeInsets.symmetric(vertical: 28.h),
                        backgroundColor: AppColors.notFoundBG,
                        text: "لم يتم العثور علي متبرع متطابق",
                        textStyle: context.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                          color: AppColors.notFoundText,
                        ),
                      ),
                    ],
                  ],
                  SizedBox(height: 16.h),
                  AppButtonWithGradientColors(
                    text: context.translate(LocalizationKeys.details),
                    onTap: () {
                      _currentBloc.add(
                        NavToMatchingDetailsScreenEvent(
                          matchId: matchUiModel.matchList[index].matchId,
                        ),
                      );
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
            matchUiModel.matchList[index].aiResult,
            style: context.textTheme.bodyMedium!.copyWith(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.readyText,
            ),
          ),

          Text(
            "${context.translate(LocalizationKeys.donor)}: ${matchUiModel.matchList[index].donorName}",
            style: context.textTheme.labelMedium!.copyWith(
              color: AppColors.readyText,
            ),
          ),
          SizedBox(height: 16.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${context.translate(LocalizationKeys.bloodType)}: ${matchUiModel.matchList[index].donorBloodType} ",
                style: context.textTheme.labelMedium!.copyWith(
                  color: AppColors.readyText,
                ),
              ),
              ContainerWithBackground(
                backgroundColor: mapMatchingStatus(
                  matchUiModel.matchList[index].aiStatus,
                ).backgroundColor,
                text: matchUiModel.matchList[index].aiStatus,
                textColor: mapMatchingStatus(
                  matchUiModel.matchList[index].aiStatus,
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
              matchUiModel.matchList[index].patientName,
              style: context.textTheme.bodyMedium!.copyWith(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: AppColors.blackText,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.h),
              child: Text(
                "${context.translate(LocalizationKeys.requestId)}: ${matchUiModel.matchList[index].matchingNumber}",
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
            matchUiModel.matchList[index].status,
          ).backgroundColor,
          text: matchUiModel.matchList[index].status,
          textColor: mapMatchingStatus(
            matchUiModel.matchList[index].status,
          ).textColor,
        ),
      ],
    );
  }

  void _navToMatchingDetailsScreen(NavToMatchingDetailsScreenState state) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MatchingDetailsScreen(matchId: state.matchId),
      ),
    );
  }
}
