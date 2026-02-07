import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/_core/widgets/base_stateful_screen_widget.dart';
import 'package:organ_link/features/hospital_flow/widget/hospital_app_bar_base.dart';
import 'package:organ_link/features/ministry_flow/hospitals/screen/hospitals_screen.dart';
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
import 'package:organ_link/res/app_asset_paths.dart';
import 'package:organ_link/res/app_colors.dart';
import 'package:organ_link/utils/locale/app_localization_keys.dart';

class MinistryHomeScreen extends BaseStatefulScreenWidget {
  const MinistryHomeScreen({super.key});
  static const routeName = "/ministry-home-screen";

  @override
  BaseScreenState<BaseStatefulScreenWidget> baseScreenCreateState() =>
      _MinistryHomeState();
}

class _MinistryHomeState extends BaseScreenState<MinistryHomeScreen> {
  List<QuickActionItem> buildQuickActions(BuildContext context) {
    return [
      QuickActionItem(
        text: LocalizationKeys.notifications,
        backgroundColor: AppColors.grayText,
        onTap: () {
          Navigator.of(context).pushNamed(MinistryNotificationScreen.routeName);
        },
      ),
      QuickActionItem(
        text: LocalizationKeys.hospitals,
        backgroundColor: AppColors.mainColor,
        onTap: () {
          Navigator.of(context).pushNamed(HospitalsScreen.routeName);
        },
      ),
      QuickActionItem(
        text: LocalizationKeys.settings,
        backgroundColor: const Color(0xffFF0004),
        onTap: () {
          Navigator.of(context).pushNamed(MinistrySettingsScreen.routeName);
        },
      ),
    ];
  }

  final List<DashboardMinistryUiModel> dashboardList = [
    DashboardMinistryUiModel(
      icon: AppAssetPaths.patientIcon,
      title: LocalizationKeys.patientsInNeed,
      conut: "24",
    ),
    DashboardMinistryUiModel(
      icon: AppAssetPaths.hospitalsIcon,
      title: LocalizationKeys.participatingHospitals,
      conut: "24",
    ),
    DashboardMinistryUiModel(
      icon: AppAssetPaths.opertionsDoneIcon,
      title: LocalizationKeys.successfulOperations,
      conut: "12",
    ),
    DashboardMinistryUiModel(
      icon: AppAssetPaths.donorsIcon,
      title: LocalizationKeys.donors,
      conut: "7",
    ),
  ];

  @override
  Widget baseScreenBuild(BuildContext context) {
    final quickActions = buildQuickActions(context);
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: _buildBody(quickActions),
    );
  }
  ///////////////////////////////////////////////////////////
  /////////////////// Helper widget ////////////////////////
  ///////////////////////////////////////////////////////////

  Widget _buildBody(List<QuickActionItem> quickActions) {
    return SafeArea(
      child: Column(children: [_appBar(), _bodyContent(quickActions)]),
    );
  }

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
            child: CustomNotificationIcon(onTap: () {}),
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
              DashboardMinistryWidget(dashboardList: dashboardList),
              // _dashboardSection(),
              _organDistributionSection(),
              _monthlyOpertionsSection(),
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

  Widget _monthlyOpertionsSection() {
    return _baseChartContainer(
      padding: EdgeInsets.symmetric(vertical: 24.h),
      title: context.translate(LocalizationKeys.monthlyOperations),
      subTitle: context.translate(LocalizationKeys.operationsLastSixMonths),
      body: MonthlyOperationsChart(),
    );
  }

  Widget _organDistributionSection() {
    return _baseChartContainer(
      title: context.translate(LocalizationKeys.organDistribution),
      subTitle: context.translate(LocalizationKeys.organTransplantDistribution),
      body: OrganDistributionChart(),
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

  // Widget _quickActionsBtn({
  //   required String text,
  //   Color? textColor,
  //   required Color? backgroundColor,
  //   required void Function() onTap,
  // }) {
  //   return AppElevatedButton(
  //     onPressed: onTap,
  //     color: backgroundColor,
  //     shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
  //     padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
  //     label: FittedBox(
  //       fit: BoxFit.scaleDown,
  //       child: Text(
  //         context.translate(text),
  //         style: context.textTheme.bodyMedium!.copyWith(
  //           color: textColor ?? AppColors.hospitalBtnText,
  //         ),
  //       ),
  //     ),
  //   );
  // }

  // Widget _dashboardSection() {
  //   return Padding(
  //     padding: EdgeInsets.symmetric(vertical: 24.h),
  //     child: Column(
  //       crossAxisAlignment: CrossAxisAlignment.stretch,
  //       children: [
  //         Row(
  //           children: [
  //             Expanded(
  //               child: _mainCard(
  //                 icon: AppAssetPaths.patientIcon,
  //                 title: "المرضى المحتاجون",
  //                 value: "24",
  //               ),
  //             ),
  //             SizedBox(width: 16),
  //             Expanded(
  //               child: _mainCard(
  //                 icon: AppAssetPaths.hospitalsIcon,
  //                 title: "المستشفيات المشاركة",
  //                 value: "24",
  //               ),
  //             ),
  //           ],
  //         ),
  //         SizedBox(height: 16),
  //         Row(
  //           children: [
  //             Expanded(
  //               child: _mainCard(
  //                 icon: AppAssetPaths.opertionsDoneIcon,
  //                 title: "العمليات الناجحة",
  //                 value: "12",
  //               ),
  //             ),
  //             SizedBox(width: 16),
  //             Expanded(
  //               child: _mainCard(
  //                 icon: AppAssetPaths.donorsIcon,
  //                 title: "المتبرعون",
  //                 value: "7", //from back
  //               ),
  //             ),
  //           ],
  //         ),
  //       ],
  //     ),
  //   );
  // }

  // Widget _mainCard({
  //   required String icon,
  //   required String title,
  //   required String value,
  // }) {
  //   return GestureDetector(
  //     child: ContainerWithBlackShadow(
  //       body: FittedBox(
  //         fit: BoxFit.scaleDown,
  //         child: Column(
  //           mainAxisAlignment: MainAxisAlignment.center,
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             SvgPicture.asset(width: 32.w, height: 32.h, icon),
  //             SizedBox(height: 16.h),
  //             Text(
  //               context.translate(title),
  //               style: context.textTheme.labelMedium!.copyWith(
  //                 color: AppColors.grayText,
  //               ),
  //             ),
  //             Padding(
  //               padding: EdgeInsets.symmetric(vertical: 7.h),
  //               child: Text(
  //                 textAlign: TextAlign.center,
  //                 value,
  //                 style: context.textTheme.bodyLarge!.copyWith(
  //                   color: AppColors.blackText,
  //                 ),
  //               ),
  //             ),
  //           ],
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
