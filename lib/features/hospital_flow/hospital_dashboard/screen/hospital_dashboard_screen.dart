import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/_core/widgets/base_stateful_screen_widget.dart';
import 'package:organ_link/features/hospital_flow/widget/hospital_app_bar_base.dart';
import 'package:organ_link/features/widgets/app_buttons/app_elevated_button.dart';
import 'package:organ_link/res/app_asset_paths.dart';
import 'package:organ_link/res/app_colors.dart';
import 'package:organ_link/utils/locale/app_localization_keys.dart';

class HospitalDashboardScreen extends BaseStatefulScreenWidget {
  const HospitalDashboardScreen({super.key});
  static const routeName = "/hospital-dashboard-screen";

  @override
  BaseScreenState<BaseStatefulScreenWidget> baseScreenCreateState() =>
      _HospitalDashboardScreenState();
}

class _HospitalDashboardScreenState
    extends BaseScreenState<HospitalDashboardScreen> {
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
    return SafeArea(child: Column(children: [_appBar(), _bodyContent()]));
  }

  Widget _appBar() {
    return HospitalAppBarBase(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  child: Text(
                    "مستشفى القصر العيني",
                    style: context.textTheme.bodyLarge!.copyWith(
                      color: AppColors.blackText,
                    ),
                  ),
                ),
                SizedBox(height: 9.h),
                Text(
                  "القاهرة",
                  style: context.textTheme.labelMedium!.copyWith(
                    color: AppColors.blackText,
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsetsDirectional.only(start: 24),
            child: SvgPicture.asset(AppAssetPaths.notificationIcon),
          ),
        ],
      ),
    );
  }

  Widget _bodyContent() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _welcomeMessage(),
          _dashboardSection(),
          _quickActionsSection(),
        ],
      ),
    );
  }

  Widget _quickActionsSection() {
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
              _quickActionsBtn(
                onTap: () {},
                text: LocalizationKeys.viewDonors,
                backgroundColor: AppColors.seconderColor,
              ),
              SizedBox(width: 16.w),
              _quickActionsBtn(
                onTap: () {},
                text: LocalizationKeys.viewPatients,
                backgroundColor: AppColors.mainColor,
              ),
            ],
          ),
        ),
        Row(
          children: [
            _quickActionsBtn(
              onTap: () {},
              text: LocalizationKeys.operations,
              backgroundColor: Color(0xffFF0004),
            ),
            SizedBox(width: 16.w),
            _quickActionsBtn(
              onTap: () {},
              text: LocalizationKeys.compatibilityRequests,
              backgroundColor: AppColors.grayText,
            ),
          ],
        ),
        _settingBtn(),
      ],
    );
  }

  Widget _settingBtn() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: Container(
        height: 48.h,
        //padding: EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          color: Color(0xffD9D9D9),
          borderRadius: BorderRadius.circular(8.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.15),
              blurRadius: 2,
            ),
          ],
        ),
        child: Center(
          child: FittedBox(
            child: Text(
              context.translate(LocalizationKeys.settings),
              style: context.textTheme.bodyMedium!.copyWith(
                color: Color(0xff4F4F4F),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _quickActionsBtn({
    required String text,
    Color? textColor,
    required Color? backgroundColor,
    required void Function() onTap,
  }) {
    return Expanded(
      child: AppElevatedButton(
        onPressed: onTap,
        color: backgroundColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),

        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 8),
        label: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            context.translate(text),
            style: context.textTheme.bodyMedium!.copyWith(
              color: textColor ?? AppColors.hospitalBtnText,
            ),
          ),
        ),
      ),
    );
  }

  Widget _dashboardSection() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: _mainCard(
                  icon: AppAssetPaths.heartIcon,
                  title: LocalizationKeys.registeredDonor,
                  subTitle1: "24",
                  subTitle2:
                      "+3${context.translate(LocalizationKeys.thisMonthCount)}",
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _mainCard(
                  icon: AppAssetPaths.peopleIcon,
                  title: LocalizationKeys.patientWaitingForTransplant,
                  subTitle1: "24",
                  subTitle2:
                      "+3${context.translate(LocalizationKeys.thisMonthCount)}",
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _mainCard(
                  icon: AppAssetPaths.notesBookIcon,
                  title: LocalizationKeys.matchingRequests,
                  subTitle1: "12",
                  subTitle2:
                      "3${context.translate(LocalizationKeys.underAnalysisCount)}",
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _mainCard(
                  icon: AppAssetPaths.voltageIcon,
                  title: LocalizationKeys.ongoingOperations,
                  subTitle1: "7", //from back
                  subTitle2:
                      "3${context.translate(LocalizationKeys.ongoingOperationsCount)}",
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _mainCard({
    required String icon,
    required String title,
    required String subTitle1,
    required String subTitle2,
  }) {
    return GestureDetector(
      child: Container(
        height: 132.h,
        // width: 164.w,
        padding: EdgeInsets.symmetric(vertical: 18, horizontal: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              blurStyle: BlurStyle.outer,
              blurRadius: 8,
              color: Colors.black.withValues(alpha: 0.15),
            ),
          ],
          color: AppColors.homeCardBG.withValues(alpha: 0.45),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(width: 32.w, height: 32.h, icon),
              SizedBox(height: 16.h),
              Text(
                context.translate(title),
                style: context.textTheme.labelMedium!.copyWith(
                  color: AppColors.grayText,
                  //fontSize: 14.sp,
                ),
              ),
              // SizedBox(height: 4.h),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 7.h),
                child: Text(
                  textAlign: TextAlign.center,
                  subTitle1,
                  style: context.textTheme.bodyLarge!.copyWith(
                    color: AppColors.blackText,
                  ),
                ),
              ),
              Text(
                textAlign: TextAlign.center,
                subTitle2,
                style: context.textTheme.labelMedium!.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 13,
                  color: AppColors.grayText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _welcomeMessage() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.translate(LocalizationKeys.dashboard),
          style: context.textTheme.bodyLarge!.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8.h),
        Text(
          " ${context.translate(LocalizationKeys.welcomeMessage)} مستشفى القصر العيني",
          style: context.textTheme.labelMedium!.copyWith(
            color: AppColors.grayText,
          ),
        ),
      ],
    );
  }

  // Widget _appBarBody() {
  //   return Row(
  //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //     children: [
  //       Expanded(
  //         child: Padding(
  //           padding: const EdgeInsetsDirectional.only(
  //             start: 16,
  //             top: 24,
  //             bottom: 24,
  //           ),
  //           child: Column(
  //             crossAxisAlignment: CrossAxisAlignment.start,
  //             children: [
  //               FittedBox(
  //                 child: Text(
  //                   // maxLines: 1,
  //                   // overflow: TextOverflow.visible,
  //                   "مستشفى القصر العيني",
  //                   style: context.textTheme.bodyLarge!.copyWith(
  //                     color: AppColors.blackText,
  //                   ),
  //                 ),
  //               ),
  //               Text(
  //                 "القاهرة",
  //                 style: context.textTheme.labelMedium!.copyWith(
  //                   color: AppColors.blackText,
  //                 ),
  //               ),
  //             ],
  //           ),
  //         ),
  //       ),
  //       Padding(
  //         padding: const EdgeInsetsDirectional.only(end: 16, start: 24),
  //         child: SvgPicture.asset(AppAssetPaths.notificationIcon),
  //       ),
  //     ],
  //   );
  // }
}
