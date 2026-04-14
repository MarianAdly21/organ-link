import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/_core/widgets/base_stateful_screen_widget.dart';
import 'package:organ_link/apis/_base/dio_api_manager.dart';
import 'package:organ_link/apis/managers/ministry_manager/ministry_api_manager.dart';
import 'package:organ_link/features/hospital_flow/widget/hospital_app_bar_base.dart';
import 'package:organ_link/features/ministry_flow/hospitals/screen/hospitals_screen.dart';
import 'package:organ_link/features/ministry_flow/ministry_home/bloc/ministry_dashboard_bloc.dart';
import 'package:organ_link/features/ministry_flow/ministry_home/bloc/ministry_dashboard_repository.dart';
import 'package:organ_link/features/ministry_flow/ministry_home/models/ministry_dashboard_ui_model.dart';
import 'package:organ_link/features/ministry_flow/ministry_home/models/quick_action_item.dart';
import 'package:organ_link/features/ministry_flow/ministry_home/widget/monthly_operations_chart.dart';
import 'package:organ_link/features/ministry_flow/ministry_home/widget/organ_distribution_chart.dart';
import 'package:organ_link/features/ministry_flow/ministry_home/widget/quick_action_button.dart';
import 'package:organ_link/features/ministry_flow/ministry_notification/screen/ministry_notification_screen.dart';
import 'package:organ_link/features/ministry_flow/ministry_setting/screens/ministry_settings_screen.dart';
import 'package:organ_link/features/ministry_flow/model/dashboard_ministry_ui_model.dart';
import 'package:organ_link/features/ministry_flow/widgets/dashboard_ministry_widget.dart';
import 'package:organ_link/features/ministry_flow/widgets/title_and_subtitle_custom_widget.dart';
import 'package:organ_link/features/widgets/container_with_black_shadow.dart';
import 'package:organ_link/features/widgets/custom_notification_icon.dart';
import 'package:organ_link/features/widgets/internet_error_widget.dart';
import 'package:organ_link/res/app_asset_paths.dart';
import 'package:organ_link/res/app_colors.dart';
import 'package:organ_link/utils/empty/empty_widgets.dart';
import 'package:organ_link/utils/feedback/feedback_message.dart';
import 'package:organ_link/utils/locale/app_localization_keys.dart';

class MinistryHomeScreen extends StatelessWidget {
  const MinistryHomeScreen({super.key});
  static const routeName = "/ministry-home-screen";
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MinistryDashboardBloc(
        MinistryDashboardRepository(
          ministryApiManager: MinistryApiManager(
            dioApiManager: GetIt.I<DioApiManager>(),
          ),
        ),
      ),
      child: const MinistryHomeScreenWithBloc(),
    );
  }
}

class MinistryHomeScreenWithBloc extends BaseStatefulScreenWidget {
  const MinistryHomeScreenWithBloc({super.key});

  @override
  BaseScreenState<BaseStatefulScreenWidget> baseScreenCreateState() =>
      _MinistryHomeState();
}

class _MinistryHomeState extends BaseScreenState<MinistryHomeScreenWithBloc> {
  List<QuickActionItem> buildQuickActions(BuildContext context) {
    return [
      QuickActionItem(
        text: LocalizationKeys.notifications,
        backgroundColor: AppColors.grayText,
        onTap: () {
          _navToNotificationScreenEvent();
        },
      ),
      QuickActionItem(
        text: LocalizationKeys.hospitals,
        backgroundColor: AppColors.mainColor,
        onTap: () {
          _navToHospitalsScreenEvent();
        },
      ),
      QuickActionItem(
        text: LocalizationKeys.settings,
        backgroundColor: const Color(0xffFF0004),
        onTap: () {
          _navToSettingScreenEvent();
        },
      ),
    ];
  }

  late MinistryDashboardUiModel ministryDashboardUiModel;

  @override
  void initState() {
    _currentBloc.add(GetMinistryDashboardDataEvent());
    super.initState();
  }

  @override
  Widget baseScreenBuild(BuildContext context) {
    final quickActions = buildQuickActions(context);
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: BlocConsumer<MinistryDashboardBloc, MinistryDashboardState>(
        listener: (context, state) {
          if (state is MinistryDashboardLoadingState) {
            showLoading();
          } else {
            hideLoading();
          }
          if (state is MinistryDashboardDataLoadedSuccessfullyState) {
            ministryDashboardUiModel = state.ministryDashboardUiModel;
          } else if (state is NavigationToHospitalsScreenState) {
            Navigator.of(context).pushNamed(HospitalsScreen.routeName);
          } else if (state is NavigationToNotificationScreenState) {
            Navigator.of(
              context,
            ).pushNamed(MinistryNotificationScreen.routeName);
          } else if (state is NavigationToSettingScreenState) {
            Navigator.of(context).pushNamed(MinistrySettingsScreen.routeName);
          } else if (state is MinistryDashboardErrorState &&
              state.codeError != 1016) {
            showFeedbackMessage(
              context: context,
              feedbackStyle: FeedbackStyle.snackBar,
              state.errorMessage,
            );
          }
        },
        buildWhen: (previous, current) =>
            current is MinistryDashboardDataLoadedSuccessfullyState ||
            current is MinistryDashboardLoadingState,
        builder: (context, state) {
          return _buildBody(state, quickActions: quickActions);
        },
      ),
    );
  }
  ///////////////////////////////////////////////////////////
  /////////////////// Helper widget ////////////////////////
  ///////////////////////////////////////////////////////////

  Widget _buildBody(
    MinistryDashboardState state, {
    required List<QuickActionItem> quickActions,
  }) {
    if (state is MinistryDashboardDataLoadedSuccessfullyState) {
      return SafeArea(
        child: Column(children: [_appBar(), _bodyContent(quickActions)]),
      );
    } else if (state is MinistryDashboardErrorState &&
        state.codeError == 1016) {
      return InternetErrorWidget();
    } else {
      return EmptyWidget();
    }
  }

  ///////////////////////////////////////////////////////////
  /////////////////// Helper widget ////////////////////////
  ///////////////////////////////////////////////////////////
  Widget _appBar() {
    return HospitalAppBarBase(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                context.translate(LocalizationKeys.dashboard),
                style: context.textTheme.bodyLarge!.copyWith(
                  color: AppColors.blackText,
                ),
              ),
              SizedBox(height: 9.h),
              Text(
                context.translate(LocalizationKeys.appName),
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  foreground: Paint()
                    ..shader = LinearGradient(
                      colors: [AppColors.seconderColor, AppColors.mainColor],
                    ).createShader(Rect.fromLTWH(0, 0, 100, 70)),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 24),
            child: CustomNotificationIcon(
              onTap: () {
                _navToNotificationScreenEvent();
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _bodyContent(List<QuickActionItem> quickActions) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TitleAndSubtitleCustomWidget(
                title: context.translate(
                  LocalizationKeys.welcomeToOrganManagement,
                ),
                subTitle: context.translate(
                  LocalizationKeys.organTransplantOverview,
                ),
              ),
              DashboardMinistryWidget(
                dashboardList: [
                  DashboardMinistryUiModel(
                    icon: AppAssetPaths.patientIcon,
                    title: LocalizationKeys.patientsInNeed,
                    count: ministryDashboardUiModel.totalPatient.toString(),
                  ),
                  DashboardMinistryUiModel(
                    icon: AppAssetPaths.hospitalsIcon,
                    title: LocalizationKeys.participatingHospitals,
                    count: ministryDashboardUiModel.totalHospitals.toString(),
                  ),
                  DashboardMinistryUiModel(
                    icon: AppAssetPaths.operationsDoneIcon,
                    title: LocalizationKeys.successfulOperations,
                    count: ministryDashboardUiModel.totalSurgeries.toString(),
                  ),
                  DashboardMinistryUiModel(
                    icon: AppAssetPaths.donorsIcon,
                    title: LocalizationKeys.donors,
                    count: ministryDashboardUiModel.totalDonor.toString(),
                  ),
                ],
              ),
              // _dashboardSection(),
              _organDistributionSection(),
              _monthlyOperationSection(),
              _quickActionsSection(quickActions),
            ],
          ),
        ),
      ),
    );
  }

  Widget _baseChartContainer({
    required String title,
    required String subTitle,
    required Widget body,
    EdgeInsetsGeometry? padding,
  }) {
    return ContainerWithBlackShadow(
      padding: padding,
      body: Column(
        children: [
          TitleAndSubtitleCustomWidget(title: title, subTitle: subTitle),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 16.h),
            child: body,
          ),
        ],
      ),
    );
  }

  Widget _monthlyOperationSection() {
    return _baseChartContainer(
      padding: EdgeInsets.symmetric(vertical: 24.h),
      title: context.translate(LocalizationKeys.monthlyOperations),
      subTitle: context.translate(LocalizationKeys.operationsLastSixMonths),
      body: MonthlyOperationsChart(
       monthlySurgeriesList: ministryDashboardUiModel.monthlySurgery,
      ),
    );
  }

  Widget _organDistributionSection() {
    return _baseChartContainer(
      title: context.translate(LocalizationKeys.organDistribution),
      subTitle: context.translate(LocalizationKeys.organTransplantDistribution),
      body: OrganDistributionChart(
        organDistributionList: ministryDashboardUiModel.organDistribution,
      ),
    );
  }

  Widget _quickActionsSection(List<QuickActionItem> quickActions) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          context.translate(LocalizationKeys.quickActions),
          style: context.bodyMedium!.copyWith(color: AppColors.textColor),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h),
          child: Row(
            children: [
              Expanded(
                child: QuickActionButton(item: quickActions[0]),
                //  _quickActionsBtn(
                //   onTap: () {},
                //   text: "التنبيهات",
                //   backgroundColor: AppColors.grayText,
                // ),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: QuickActionButton(item: quickActions[1]),
                // _quickActionsBtn(
                //   onTap: () {
                //     Navigator.of(context).pushNamed(HospitalsScreen.routeName);
                //   },
                //   text: "المستشفيات",
                //   backgroundColor: AppColors.mainColor,
                // ),
              ),
            ],
          ),
        ),
        QuickActionButton(item: quickActions[2]),
        // _quickActionsBtn(
        //   onTap: () {},
        //   text: "الاعدادات",
        //   backgroundColor: Color(0xffFF0004),
        // ),
      ],
    );
  }

  ///////////////////////////////////////////////////////////
  /////////////////// Helper method ////////////////////////
  ///////////////////////////////////////////////////////////
  MinistryDashboardBloc get _currentBloc =>
      context.read<MinistryDashboardBloc>();

  void _navToSettingScreenEvent() {
    _currentBloc.add(NavigationToSettingScreenEvent());
  }

  void _navToHospitalsScreenEvent() {
    _currentBloc.add(NavigationToHospitalsScreenEvent());
  }

  void _navToNotificationScreenEvent() {
    _currentBloc.add(NavigationToNotificationScreenEvent());
  }
}
