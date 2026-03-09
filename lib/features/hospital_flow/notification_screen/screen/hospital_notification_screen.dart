import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get_it/get_it.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/_core/widgets/base_stateful_screen_widget.dart';
import 'package:organ_link/apis/_base/dio_api_manager.dart';
import 'package:organ_link/apis/managers/hospital_manager/hospital_api_manager.dart';
import 'package:organ_link/features/hospital_flow/notification_screen/bloc/hospital_notification_bloc.dart';
import 'package:organ_link/features/hospital_flow/notification_screen/bloc/hospital_notification_repository.dart';
import 'package:organ_link/features/hospital_flow/notification_screen/model/hospital_notification_ui_model.dart';
import 'package:organ_link/features/hospital_flow/notification_screen/widget/notification_filter_bar.dart';
import 'package:organ_link/features/hospital_flow/widget/container_with_background.dart';
import 'package:organ_link/features/hospital_flow/widget/app_base_body_scaffold.dart';
import 'package:organ_link/features/shared_screens/screens/empty_notification_widget.dart';
import 'package:organ_link/features/widgets/container_with_shadow.dart';
import 'package:organ_link/features/widgets/custom_divider_widget.dart';
import 'package:organ_link/features/widgets/custom_over_view_container.dart';
import 'package:organ_link/features/widgets/internet_error_widget.dart';
import 'package:organ_link/preferences/preferences_manager.dart';
import 'package:organ_link/res/app_asset_paths.dart';
import 'package:organ_link/res/app_colors.dart';
import 'package:organ_link/utils/empty/empty_widgets.dart';
import 'package:organ_link/utils/feedback/feedback_message.dart';
import 'package:organ_link/utils/locale/app_localization_keys.dart';

class HospitalNotificationScreen extends StatelessWidget {
  const HospitalNotificationScreen({super.key});
  static const routeName = "/hospital-notification-screen";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HospitalNotificationBloc(
        HospitalNotificationRepository(
          preferencesManager: GetIt.I<PreferencesManager>(),
          hospitalApiManager: HospitalApiManager(
            dioApiManager: GetIt.I<DioApiManager>(),
          ),
        ),
      ),
      child: const HospitalNotificationScreenWithBloc(),
    );
  }
}

class HospitalNotificationScreenWithBloc extends BaseStatefulScreenWidget {
  const HospitalNotificationScreenWithBloc({super.key});
  @override
  BaseScreenState<BaseStatefulScreenWidget> baseScreenCreateState() =>
      _HospitalNotificationScreenWithBlocState();
}

class _HospitalNotificationScreenWithBlocState
    extends BaseScreenState<HospitalNotificationScreenWithBloc> {
  late HospitalNotificationUiModel hospitalNotificationUiModel;
  @override
  void initState() {
    _currentBloc.add(GetHospitalNotificationDataEvent());
    super.initState();
  }

  @override
  Widget baseScreenBuild(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: AppBaseBodyScaffold(
        titleOfScreen: context.translate(LocalizationKeys.notificationScreen),
        backTap: () {
          Navigator.pop(context);
        },
        padding: EdgeInsets.symmetric(vertical: 24.h),
        body: BlocConsumer<HospitalNotificationBloc, HospitalNotificationState>(
          listener: (context, state) {
            if (state is HospitalNotificationLoadingState) {
              showLoading();
            } else {
              hideLoading();
            }
            if (state is HospitalNotificationDataLoadedSuccessfullyState) {
              hospitalNotificationUiModel = state.hospitalNotificationUiModel;
            } else if (state is HospitalNotificationErrorState &&
                state.codeError != 1016) {
              showFeedbackMessage(state.errorMessage);
            }
          },
          buildWhen: (previous, current) =>
              current is HospitalNotificationDataLoadedSuccessfullyState ||
              current is HospitalNotificationErrorState,
          builder: (context, state) {
            if (state is HospitalNotificationDataLoadedSuccessfullyState) {
              return Column(
                children: [
                  _headerWidget(),
                  Expanded(child: _buildBody()),
                ],
              );
            } else if (state is HospitalNotificationErrorState &&
                state.codeError == 1016) {
              return InternetErrorWidget();
            } else {
              return EmptyWidget();
            }
          },
        ),
      ),
    );
  }

  ///////////////////////////////////////////////////////////
  /////////////////// Helper widget ////////////////////////
  ///////////////////////////////////////////////////////////

  Widget _headerWidget() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                context.translate(LocalizationKeys.allAlerts),
                style: context.textTheme.bodyMedium,
              ),
              Text(
                context.translate(LocalizationKeys.organTransplantTracking),
                style: context.textTheme.labelMedium,
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 24.h),
          child: Container(
            color: Colors.white,
            width: MediaQuery.of(context).size.width,
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomOverViewContainer(
                  backgroundColor: Color(0xffFFF2DC),
                  width: 100.w,
                  text: context.translate(LocalizationKeys.urgent),
                  count: "${hospitalNotificationUiModel.criticalNotification}",
                ),
                CustomOverViewContainer(
                  backgroundColor: Color(0xffDEFFDF),
                  width: 100.w,
                  text: context.translate(LocalizationKeys.unread),
                  count: "${hospitalNotificationUiModel.unreadNotification}",
                ),
                CustomOverViewContainer(
                  backgroundColor: Color(0xffE6F4FF),
                  width: 100.w,
                  text: context.translate(LocalizationKeys.totalNotification),
                  count: "${hospitalNotificationUiModel.totalNotification}",
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildBody() {
    if (hospitalNotificationUiModel.notificationList.isNotEmpty) {
      return Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            NotificationFilterBar(),
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(vertical: 24.h),
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Text(
                        context.translate(LocalizationKeys.notificationList),
                        style: context.textTheme.bodyMedium!.copyWith(
                          color: AppColors.blackText,
                        ),
                      ),
                    ),
                    SliverList(
                      delegate: SliverChildBuilderDelegate(
                        childCount:
                            hospitalNotificationUiModel.notificationList.length,
                        (context, index) {
                          return _notificationItem(
                            title: hospitalNotificationUiModel
                                .notificationList[index]
                                .title,
                            subTitle: hospitalNotificationUiModel
                                .notificationList[index]
                                .content,
                            isUrgent: hospitalNotificationUiModel
                                .notificationList[index]
                                .isUrgent,
                            time: getTime(
                              hospitalNotificationUiModel
                                  .notificationList[index]
                                  .notificationTime,
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      return EmptyNotificationScreen();
    }
  }

  Widget _notificationItem({
    required String title,
    required String subTitle,
    required String time,
    required bool isUrgent,
  }) {
    return ContainerWithShadow(
      padding: EdgeInsets.symmetric(vertical: 12.h),
      contentPadding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: context.textTheme.bodyMedium!.copyWith(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      subTitle,
                      style: TextStyle(
                        color: AppColors.grayText,
                        fontSize: 13,
                        fontWeight: FontWeight.w400,
                      ),
                      textAlign: TextAlign.start,
                      maxLines: 2,
                      overflow: TextOverflow.visible,
                    ),
                  ],
                ),
              ),
              if (isUrgent) ...[
                const SizedBox(width: 34),
                ContainerWithBackground(
                  backgroundColor: Color(0xffFFDADE),
                  text: "عاجل",
                  textColor: Color(0xffAD0000),
                ),
              ],
            ],
          ),
          CustomDividerWidget(),
          Row(
            children: [
              Text(
                time,
                style: TextStyle(
                  color: AppColors.grayText,
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
              Spacer(),
              GestureDetector(
                onTap: () {},
                child: SvgPicture.asset(AppAssetPaths.deleteIcon),
              ),
              const SizedBox(width: 16),
              GestureDetector(
                onTap: () {},
                child: SvgPicture.asset(AppAssetPaths.doneIcon),
              ),
            ],
          ),
        ],
      ),
    );
  }

  ///////////////////////////////////////////////////////////
  /////////////////// Helper method ////////////////////////
  ///////////////////////////////////////////////////////////
  HospitalNotificationBloc get _currentBloc =>
      context.read<HospitalNotificationBloc>();

  String getTime(DateTime time) {
    final difference = DateTime.now().difference(time);
    if (difference.inMinutes < 60) {
      return "${context.translate(LocalizationKeys.since)} "
          "${difference.inMinutes} "
          "${context.translate(LocalizationKeys.minute)}";
    } else if (difference.inHours < 24) {
      return "${context.translate(LocalizationKeys.since)} "
          "${difference.inHours} "
          "${context.translate(LocalizationKeys.hour)}";
    } else {
      return "${context.translate(LocalizationKeys.since)} "
          "${difference.inDays} "
          "${context.translate(LocalizationKeys.day)}";
    }
  }
}
