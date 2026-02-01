import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/_core/widgets/base_stateless_widget.dart';
import 'package:organ_link/features/ministry_flow/model/dashboard_ministry_ui_model.dart';
import 'package:organ_link/features/widgets/container_with_black_shadow.dart';
import 'package:organ_link/res/app_colors.dart';

class DashboardMinistryWidget extends BaseStatelessWidget {
  const DashboardMinistryWidget({super.key, required this.dashboardList});
  final List<DashboardMinistryUiModel> dashboardList;
  @override
  Widget baseBuild(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Row(
            children: [
              Expanded(
                child: _mainCard(
                  context,
                  icon: dashboardList[0].icon,
                  title: dashboardList[0].title,
                  value: dashboardList[0].conut,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _mainCard(
                  context,
                  icon: dashboardList[1].icon,
                  title: dashboardList[1].title,
                  value: dashboardList[1].conut,
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _mainCard(
                  context,
                  icon: dashboardList[2].icon,
                  title: dashboardList[2].title,
                  value: dashboardList[2].conut,
                ),
              ),
              SizedBox(width: 16),
              Expanded(
                child: _mainCard(
                  context,
                  icon: dashboardList[3].icon,
                  title: dashboardList[3].title,
                  value: dashboardList[3].conut, //from back
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _mainCard(
    BuildContext context, {
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
}
