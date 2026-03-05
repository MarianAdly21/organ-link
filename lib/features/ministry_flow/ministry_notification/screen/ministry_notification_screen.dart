import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/_core/widgets/base_stateful_screen_widget.dart';
import 'package:organ_link/features/hospital_flow/widget/app_base_body_scaffold.dart';
import 'package:organ_link/features/ministry_flow/ministry_notification_details/screens/ministry_notification_details_screen.dart';
import 'package:organ_link/features/ministry_flow/model/dashboard_ministry_ui_model.dart';
import 'package:organ_link/features/ministry_flow/model/ministry_alart_ui_model.dart';
import 'package:organ_link/features/ministry_flow/widgets/dashboard_ministry_widget.dart';
import 'package:organ_link/features/ministry_flow/widgets/info_tile_with_status_custom_widget.dart';
import 'package:organ_link/features/ministry_flow/widgets/title_and_subtitle_custom_widget.dart';
import 'package:organ_link/features/widgets/app_buttons/app_button_with_gradient_colors.dart';
import 'package:organ_link/features/widgets/container_with_black_shadow.dart';
import 'package:organ_link/features/widgets/custom_divider_widget.dart';
import 'package:organ_link/res/app_asset_paths.dart';
import 'package:organ_link/res/app_colors.dart';
import 'package:organ_link/utils/locale/app_localization_keys.dart';

class MinistryNotificationScreen extends BaseStatefulScreenWidget {
  const MinistryNotificationScreen({super.key});
  static const routeName = "ministry-notification-screen";
  @override
  BaseScreenState<BaseStatefulScreenWidget> baseScreenCreateState() =>
      _MinistryNotificationScreenState();
}

class _MinistryNotificationScreenState
    extends BaseScreenState<MinistryNotificationScreen> {
  final List<DashboardMinistryUiModel> dashboardList = [
    DashboardMinistryUiModel(
      icon: AppAssetPaths.newNotificationIcon,
      title: LocalizationKeys.newAlerts,
      count: "24",
    ),
    DashboardMinistryUiModel(
      icon: AppAssetPaths.folderNotificationIcon,
      title: LocalizationKeys.totalAlerts,
      count: "24",
    ),
    DashboardMinistryUiModel(
      icon: AppAssetPaths.hospitalsIcon,
      title: LocalizationKeys.resolved,
      count: "12",
    ),
    DashboardMinistryUiModel(
      icon: AppAssetPaths.hourglassIcon,
      title: LocalizationKeys.underInvestigation,
      count: "7",
    ),
  ];
  final List<MinistryAlartUiModel> alarts = [
    MinistryAlartUiModel(
      alartTitel: "لا يوجد تقارير عملية زراعة",
      alartContent: "تم تسجيل عملية زراعة دون توثيق كامل للإجراءات المطلوبة",
      alartStatus: "alartStatus",
      hospitalName: "hospitalName",
    ),
  ];
  @override
  Widget baseScreenBuild(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: AppBaseBodyScaffold(
        titleOfScreen: LocalizationKeys.alerts,
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
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 3.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TitleAndSubtitleCustomWidget(
              title: LocalizationKeys.alertsNotifications,
              subTitle: LocalizationKeys.allImportantAlerts,
            ),
            DashboardMinistryWidget(dashboardList: dashboardList),
            ListView.builder(
              itemCount: alarts.length,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, index) {
                return ContainerWithBlackShadow(
                  gradientBackgroundColor: [
                    /// change based on its status
                    /// status==> تم الحل
                    AppColors.resolveStatusContainerBGMinistryAlert,
                    AppColors.resolveStatusContainerBGMinistryAlert,

                    /// status==> خطر
                    //  AppColors.dangerStatusContainerBGMinistryAlart1,
                    //  AppColors.dangerStatusContainerBGMinistryAlart2,

                    /// status==> تحذير
                    // AppColors.warningStatusContainerBGMinistryAlart1,
                    // AppColors.warningStatusContainerBGMinistryAlart2,
                  ],
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
                        textStatusColor: AppColors.statusTextInMinistryAlert,
                        statusBGColor: AppColors.resolveStatusBGMinistryAlert,

                        /// change the color based on its status
                        title: alarts[index].alartTitel,
                        subtitle: alarts[index].alartContent,
                        status: alarts[index].alartStatus,
                      ),
                      CustomDividerWidget(),
                      _hospitalNameAndDate(
                        hospitalName: alarts[index].hospitalName,
                      ),
                      Padding(
                        padding: EdgeInsets.only(top: 16.h),
                        child: Row(
                          children: [
                            Expanded(
                              child: AppButtonWithGradientColors(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                    MinistryNotificationDetailsScreen.routeName,
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
                                  LocalizationKeys.investigationFollowUp,
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
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _hospitalNameAndDate({required String hospitalName}) {
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
            "1/11/2025 - 11:49:32 م",
            style: context.textTheme.labelMedium!.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 13,
            ),
          ),
        ),
      ],
    );
  }

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

  //   Widget _dashboardSection() {
  //     return Padding(
  //       padding: EdgeInsets.symmetric(vertical: 24.h),
  //       child: Column(
  //         crossAxisAlignment: CrossAxisAlignment.stretch,
  //         children: [
  //           Row(
  //             children: [
  //               Expanded(
  //                 child: _mainCard(
  //                   icon: AppAssetPaths.patientIcon,
  //                   title: "المرضى المحتاجون",
  //                   value: "24",
  //                 ),
  //               ),
  //               SizedBox(width: 16),
  //               Expanded(
  //                 child: _mainCard(
  //                   icon: AppAssetPaths.hospitalsIcon,
  //                   title: "المستشفيات المشاركة",
  //                   value: "24",
  //                 ),
  //               ),
  //             ],
  //           ),
  //           SizedBox(height: 16),
  //           Row(
  //             children: [
  //               Expanded(
  //                 child: _mainCard(
  //                   icon: AppAssetPaths.opertionsDoneIcon,
  //                   title: "العمليات الناجحة",
  //                   value: "12",
  //                 ),
  //               ),
  //               SizedBox(width: 16),
  //               Expanded(
  //                 child: _mainCard(
  //                   icon: AppAssetPaths.donorsIcon,
  //                   title: "المتبرعون",
  //                   value: "7", //from back
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ],
  //       ),
  //     );
  //   }
}
