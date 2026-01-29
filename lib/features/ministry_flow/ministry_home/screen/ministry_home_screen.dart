import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/_core/widgets/base_stateful_screen_widget.dart';
import 'package:organ_link/features/hospital_flow/widget/hospital_app_bar_base.dart';
import 'package:organ_link/features/ministry_flow/ministry_home/screen/widget/monthly_operations_chart.dart';
import 'package:organ_link/features/ministry_flow/ministry_home/screen/widget/organ_distribution_chart.dart';
import 'package:organ_link/features/widgets/app_buttons/app_elevated_button.dart';
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "لوحة التحكم",
                style: context.textTheme.bodyLarge!.copyWith(
                  color: AppColors.blackText,
                ),
              ),
              SizedBox(height: 9.h),
              Text(
                'OrganLink',
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

  Widget _bodyContent() {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _welcomeMessage(),
              _dashboardSection(),
              _organDistributionSection(),
              _monthlyOpertionsSection(),
              _quickActionsSection(),
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
          _titelAndSubTitalWidget(title: title, subTitle: subTitle),
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
      title: "العمليات الشهرية",
      subTitle: "إحصائيات العمليات على مدار اخر 6 شهور",
      body: MonthlyOperationsChart(),
    );
  }

  Widget _welcomeMessage() {
    return _titelAndSubTitalWidget(
      title: "مرحباً بك في نظام إدارة الأعضاء",
      subTitle: "مركز عامة على تطاوير زراعة الأعضاء",
    );
  }

  Widget _organDistributionSection() {
    return _baseChartContainer(
      title: "توزيع الأعضاء",
      subTitle: "نسب عمليات زراعة الأعضاء المختلفة",
      body: OrganDistributionChart(),
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
                text: "التقارير",
                backgroundColor: AppColors.seconderColor,
              ),
              SizedBox(width: 16.w),
              _quickActionsBtn(
                onTap: () {},
                text: "المستشفيات",
                backgroundColor: AppColors.mainColor,
              ),
            ],
          ),
        ),
        Row(
          children: [
            _quickActionsBtn(
              onTap: () {},
              text: "الاعدادات",
              backgroundColor: Color(0xffFF0004),
            ),
            SizedBox(width: 16.w),
            _quickActionsBtn(
              onTap: () {},
              text: "التنبيهات",
              backgroundColor: AppColors.grayText,
            ),
          ],
        ),
      ],
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
                  icon: AppAssetPaths.patientIcon,
                  title: "المرضى المحتاجون",
                  value: "24",
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _mainCard(
                  icon: AppAssetPaths.hospitalsIcon,
                  title: "المستشفيات المشاركة",
                  value: "24",
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _mainCard(
                  icon: AppAssetPaths.opertionsDoneIcon,
                  title: "العمليات الناجحة",
                  value: "12",
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _mainCard(
                  icon: AppAssetPaths.donorsIcon,
                  title: "المتبرعون",
                  value: "7", //from back
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
    required String value,
  }) {
    return GestureDetector(
      child: ContainerWithBlackShadow(
        body: FittedBox(
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
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 7.h),
                child: Text(
                  textAlign: TextAlign.center,
                  value,
                  style: context.textTheme.bodyLarge!.copyWith(
                    color: AppColors.blackText,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _titelAndSubTitalWidget({
    required String title,
    required String subTitle,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          context.translate(title),
          style: context.textTheme.bodyLarge!.copyWith(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        Text(
          subTitle,
          style: context.textTheme.labelMedium!.copyWith(
            color: AppColors.grayText,
          ),
        ),
      ],
    );
  }
}
