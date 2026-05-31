import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/_core/widgets/base_stateful_screen_widget.dart';
import 'package:organ_link/apis/_base/dio_api_manager.dart';
import 'package:organ_link/apis/managers/ministry_manager/ministry_api_manager.dart';
import 'package:organ_link/features/hospital_flow/enum/ministry_notification_type.dart';
import 'package:organ_link/features/hospital_flow/extension/ministry_notification_type_ui.dart';
import 'package:organ_link/features/hospital_flow/widget/app_base_body_scaffold.dart';
import 'package:organ_link/features/ministry_flow/ministry_notification/bloc/ministry_notification_bloc.dart';
import 'package:organ_link/features/ministry_flow/ministry_notification/bloc/ministry_notification_repository.dart';
import 'package:organ_link/features/ministry_flow/ministry_notification/methods/get_gradient_by_status.dart';
import 'package:organ_link/features/ministry_flow/ministry_notification/models/ministry_notification_ui_model.dart';
import 'package:organ_link/features/ministry_flow/ministry_notification_details/screens/ministry_notification_details_screen.dart';
import 'package:organ_link/features/ministry_flow/model/dashboard_ministry_ui_model.dart';
import 'package:organ_link/features/ministry_flow/widgets/dashboard_ministry_widget.dart';
import 'package:organ_link/features/ministry_flow/widgets/info_tile_with_status_custom_widget.dart';
import 'package:organ_link/features/ministry_flow/widgets/title_and_subtitle_custom_widget.dart';
import 'package:organ_link/features/widgets/app_buttons/app_button_with_gradient_colors.dart';
import 'package:organ_link/features/widgets/container_with_black_shadow.dart';
import 'package:organ_link/features/widgets/custom_divider_widget.dart';
import 'package:organ_link/features/widgets/internet_error_widget.dart';
import 'package:organ_link/res/app_asset_paths.dart';
import 'package:organ_link/res/app_colors.dart';
import 'package:organ_link/utils/empty/empty_widgets.dart';
import 'package:organ_link/utils/feedback/feedback_message.dart';
import 'package:organ_link/utils/locale/app_localization_keys.dart';

class MinistryNotificationScreen extends StatelessWidget {
  const MinistryNotificationScreen({super.key});
  static const routeName = "ministry-notification-screen";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MinistryNotificationBloc(
        MinistryNotificationRepository(
          ministryApiManager: MinistryApiManager(
            dioApiManager: GetIt.I<DioApiManager>(),
          ),
        ),
      ),
      child: MinistryNotificationScreenWithBloc(),
    );
  }
}

class MinistryNotificationScreenWithBloc extends BaseStatefulScreenWidget {
  const MinistryNotificationScreenWithBloc({super.key});
  @override
  BaseScreenState<BaseStatefulScreenWidget> baseScreenCreateState() =>
      _MinistryNotificationScreenState();
}

class _MinistryNotificationScreenState
    extends BaseScreenState<MinistryNotificationScreenWithBloc> {
  late MinistryNotificationUiModel ministryNotificationUiModel;

  @override
  void initState() {
    super.initState();
    _currentBloc.add(GetMinistryNotificationDataEvent());
  }

  @override
  Widget baseScreenBuild(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: AppBaseBodyScaffold(
        titleOfScreen: LocalizationKeys.alerts,
        backTap: () {
          Navigator.pop(context);
        },
        body: BlocConsumer<MinistryNotificationBloc, MinistryNotificationState>(
          listener: (context, state) {
            if (state is MinistryNotificationLoadingState) {
              showLoading();
            } else {
              hideLoading();
            }
            if (state is MinistryNotificationDataLoadedSuccessfullyState) {
              ministryNotificationUiModel = state.ministryNotificationUiModel;
            } else if (state is NavToNotificationDetailsScreenState) {
              _navToDetailsScreen(state.id);
            } else if (state is MinistryNotificationErrorState &&
                state.codeError != 1016) {
              showFeedbackMessage(
                context: context,
                feedbackStyle: FeedbackStyle.snackBar,
                state.errorMessage,
              );
            }
          },
          buildWhen: (previous, current) =>
              current is MinistryNotificationDataLoadedSuccessfullyState ||
              current is MinistryNotificationErrorState,
          builder: (context, state) {
            return _buildBody(state);
          },
        ),
      ),
    );
  }

  ///////////////////////////////////////////////////////////
  /////////////////// Helper widget ////////////////////////
  ///////////////////////////////////////////////////////////

  Widget _buildBody(MinistryNotificationState state) {
    if (state is MinistryNotificationDataLoadedSuccessfullyState) {
      return SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TitleAndSubtitleCustomWidget(
                title: LocalizationKeys.alertsNotifications,
                subTitle: LocalizationKeys.allImportantAlerts,
              ),
              DashboardMinistryWidget(
                dashboardList: [
                  DashboardMinistryUiModel(
                    icon: AppAssetPaths.newNotificationIcon,
                    title: LocalizationKeys.newAlerts,
                    count: ministryNotificationUiModel.unreadAlerts.toString(),
                  ),
                  DashboardMinistryUiModel(
                    icon: AppAssetPaths.folderNotificationIcon,
                    title: LocalizationKeys.totalAlerts,
                    count: ministryNotificationUiModel.totalAlerts.toString(),
                  ),
                  DashboardMinistryUiModel(
                    icon: AppAssetPaths.hospitalsIcon,
                    title: LocalizationKeys.resolved,
                    count: ministryNotificationUiModel.resolvedAlerts
                        .toString(),
                  ),
                  DashboardMinistryUiModel(
                    icon: AppAssetPaths.hourglassIcon,
                    title: LocalizationKeys.underInvestigation,
                    count: ministryNotificationUiModel.underInvestigation
                        .toString(),
                  ),
                ],
              ),
              ListView.builder(
                itemCount: ministryNotificationUiModel.alertList.isEmpty
                    ? 1
                    : ministryNotificationUiModel.alertList.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, index) {
                  return ministryNotificationUiModel.alertList.isNotEmpty
                      ? ContainerWithBlackShadow(
                          gradientBackgroundColor: getGradientByStatus(
                            mapMinistryNotificationStatus(
                              ministryNotificationUiModel
                                  .alertList[index]
                                  .alertType,
                            ),
                          ),
                          padding: EdgeInsets.only(bottom: 16.h),
                          contentPadding: EdgeInsets.symmetric(
                            vertical: 16.h,
                            horizontal: 16.w,
                          ),
                          body: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              InfoTileWithStatusCustomWidget(
                                textColor: AppColors.textColor,
                                textStatusColor:
                                    AppColors.statusTextInMinistryAlert,
                                statusBGColor: mapMinistryNotificationStatus(
                                  ministryNotificationUiModel
                                      .alertList[index]
                                      .alertType,
                                ).backgroundColor,
                                title: ministryNotificationUiModel
                                    .alertList[index]
                                    .messageTitle,
                                subtitle: ministryNotificationUiModel
                                    .alertList[index]
                                    .messageTitle,
                                status: ministryNotificationUiModel
                                    .alertList[index]
                                    .alertType,
                              ),
                              CustomDividerWidget(),
                              _hospitalNameAndDate(
                                hospitalName: ministryNotificationUiModel
                                    .alertList[index]
                                    .hospitalName,
                                date: ministryNotificationUiModel
                                    .alertList[index]
                                    .createdAt,
                              ),
                              Padding(
                                padding: EdgeInsets.only(top: 16.h),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: AppButtonWithGradientColors(
                                        onTap: () {
                                          _currentBloc.add(
                                            NavToNotificationDetailsScreenEvent(
                                              id: ministryNotificationUiModel
                                                  .alertList[index]
                                                  .id,
                                            ),
                                          );
                                        },
                                        text: context.translate(
                                          LocalizationKeys.viewDetails,
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 16),
                                    Expanded(
                                      child: AppButtonWithGradientColors(
                                        onTap: () {},
                                        text: context.translate(
                                          LocalizationKeys
                                              .investigationFollowUp,
                                        ),
                                        textColor: AppColors.blackText,
                                        border: BoxBorder.all(
                                          color: AppColors.backButtonBorder,
                                        ),
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
                        )
                      : Center(
                        child: Text(
                            context.translate(
                              LocalizationKeys.noNotificationsAtTheMoment,
                            ),
                            style: context.textTheme.bodyMedium,
                          ),
                      );
                },
              ),
            ],
          ),
        ),
      );
    } else if (state is MinistryNotificationErrorState &&
        state.codeError == 1016) {
      return InternetErrorWidget();
    } else {
      return EmptyWidget();
    }
  }

  Widget _hospitalNameAndDate({
    required String hospitalName,
    required String date,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Flexible(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              hospitalName,
              style: context.textTheme.labelMedium!.copyWith(
                fontWeight: FontWeight.w400,
                fontSize: 13,
              ),
            ),
          ),
        ),
        SizedBox(width: 16),
        Flexible(
          child: Text(
            date,
            style: context.textTheme.labelMedium!.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }

  ///////////////////////////////////////////////////////////
  /////////////////// Helper method ////////////////////////
  ///////////////////////////////////////////////////////////
  MinistryNotificationBloc get _currentBloc =>
      context.read<MinistryNotificationBloc>();
  void _navToDetailsScreen(int id) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => MinistryNotificationDetailsScreen(id: id),
      ),
    );
  }
}
