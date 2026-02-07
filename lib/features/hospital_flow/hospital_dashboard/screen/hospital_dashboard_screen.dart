import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/_core/widgets/base_stateful_screen_widget.dart';
import 'package:organ_link/features/hospital_flow/hospital_setting/screen/hospital_setting.dart';
import 'package:organ_link/features/hospital_flow/matching/screen/matching_screen.dart';
import 'package:organ_link/features/hospital_flow/notification_screen/screen/hospital_notification_screen.dart';
import 'package:organ_link/features/hospital_flow/surgeries/screen/surgeries_screen.dart';
import 'package:organ_link/features/hospital_flow/view_patient/screen/view_patient_screen.dart';
import 'package:organ_link/features/hospital_flow/widget/hospital_app_bar_base.dart';
import 'package:organ_link/features/ministry_flow/widgets/title_and_subtitle_custom_widget.dart';
import 'package:organ_link/features/widgets/app_buttons/app_elevated_button.dart';
import 'package:organ_link/features/widgets/container_with_black_shadow.dart';
import 'package:organ_link/features/widgets/custom_notification_icon.dart';
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
    return SafeArea(
      child: Column(
        children: [
          _appBar(),
          Expanded(child: SingleChildScrollView(child: _bodyContent())),
        ],
      ),
    );
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
            child: CustomNotificationIcon(
              onTap: () {
                Navigator.of(
                  context,
                ).pushNamed(HospitalNotificationScreen.routeName);
              },
            ),
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
          TitleAndSubtitleCustomWidget(
            title: context.translate(LocalizationKeys.dashboard),
            subTitle:
                " ${context.translate(LocalizationKeys.welcomeMessage)} مستشفى القصر العيني",
          ),
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
                onTap: () {
                  Navigator.of(context).pushNamed(ViewPatientScreen.routeName);
                },
                text: LocalizationKeys.viewDonors,
                backgroundColor: AppColors.seconderColor,
              ),
              SizedBox(width: 16.w),
              _quickActionsBtn(
                onTap: () {
                  Navigator.of(context).pushNamed(ViewPatientScreen.routeName);
                },
                text: LocalizationKeys.viewPatients,
                backgroundColor: AppColors.mainColor,
              ),
            ],
          ),
        ),
        Row(
          children: [
            _quickActionsBtn(
              onTap: () {
                Navigator.of(context).pushNamed(SurgeriesScreen.routeName);
              },
              text: LocalizationKeys.operations,
              backgroundColor: Color(0xffFF0004),
            ),
            SizedBox(width: 16.w),
            _quickActionsBtn(
              onTap: () {
                Navigator.of(context).pushNamed(MatchingScreen.routeName);
              },
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
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(HospitalSetting.routeName);
      },
      child: Padding(
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
                  count: "24",
                  subTitle2:
                      "+3${context.translate(LocalizationKeys.thisMonthCount)}",
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _mainCard(
                  icon: AppAssetPaths.peopleIcon,
                  title: LocalizationKeys.patientWaitingForTransplant,
                  count: "24",
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
                  count: "126578",
                  subTitle2:
                      "3${context.translate(LocalizationKeys.underAnalysisCount)}",
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _mainCard(
                  icon: AppAssetPaths.voltageIcon,
                  title: LocalizationKeys.ongoingOperations,
                  count: "56", //from back
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
    required String count,
    required String subTitle2,
  }) {
    return ContainerWithBlackShadow(
      height: 132.h,
      body: FittedBox(
        fit: BoxFit.scaleDown,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(icon),
            SizedBox(height: 16),
            Text(
              maxLines: 1,
              context.translate(title),
              style: context.textTheme.labelMedium!.copyWith(
                color: AppColors.grayText,
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 7),
              child: Text(
                textAlign: TextAlign.center,
                count,
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
    );
  }
}
