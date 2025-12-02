import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/_core/widgets/base_stateless_widget.dart';
import 'package:organ_link/features/user_flow/widget/base_body_scaffold.dart';
import 'package:organ_link/features/user_flow/widget/data_row_with_divider.dart';
import 'package:organ_link/features/user_flow/widget/data_section.dart';
import 'package:organ_link/features/widgets/container_with_shadow.dart';
import 'package:organ_link/features/widgets/custom_divider_widget.dart';
import 'package:organ_link/res/app_asset_paths.dart';
import 'package:organ_link/res/app_colors.dart';
import 'package:organ_link/utils/locale/app_localization_keys.dart';

class ProcedureSchedulingScreen extends BaseStatelessWidget {
  const ProcedureSchedulingScreen({super.key});

  @override
  Widget baseBuild(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: _buildBody(context),
    );
  }

  ///////////////////////////////////////////////////////////
  /////////////////// Helper widget ////////////////////////
  ///////////////////////////////////////////////////////////

  Widget _buildBody(BuildContext context) {
    return BaseBodyScaffold(
      title: context.translate(LocalizationKeys.scheduleProcedure),
      onBackTap: () {},
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _transplantStatusMessage(context),
          _procedureInfo(context),
          _dataSectionWithName(
            context,
            padding: EdgeInsets.only(top: 24.h),
            title: LocalizationKeys.procedureLocation,
            subTitle: "مستشفى القصر العيني بالقاهرة",
            body: Column(
              children: [
                CustomDividerWidget(verticalPadding: 8.h),
                SizedBox(height: 16.h),
                DataRowWithDivider(
                  divider: true,
                  title: context.translate(LocalizationKeys.operatingRoom),
                  subTitle: "رقم 3- الطابق الثاني",
                ),
                DataRowWithDivider(
                  title: context.translate(LocalizationKeys.arrivalTime),
                  subTitle: "قبل الموعد المحدد بساعتين (8 ص)",
                ),
              ],
            ),
          ),
          _dataSectionWithName(
            context,
            padding: EdgeInsets.symmetric(vertical: 0),
            title: LocalizationKeys.medicalTeam,
            subTitle: context.translate(LocalizationKeys.expertTeam),
            body: Column(
              children: [
                CustomDividerWidget(verticalPadding: 8.h),
                SizedBox(height: 16.h),
                DataRowWithDivider(
                  divider: true,
                  title: "د. أحمد سالم",
                  titleStyle: context.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textColor,
                  ),
                  subTitle: "جراح رئيسي",
                  subTitleStyle: context.textTheme.labelMedium!.copyWith(
                    color: AppColors.grayText,
                  ),
                ),
                DataRowWithDivider(
                  divider: true,
                  title: "د. سارة محمد",
                  titleStyle: context.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textColor,
                  ),
                  subTitle: "جراح مساعد",
                  subTitleStyle: context.textTheme.labelMedium!.copyWith(
                    color: AppColors.grayText,
                  ),
                ),
                DataRowWithDivider(
                  title: "د. سارة محمد",
                  titleStyle: context.textTheme.bodyMedium!.copyWith(
                    fontWeight: FontWeight.w600,
                    color: AppColors.textColor,
                  ),
                  subTitle: "جراح مساعد",
                  subTitleStyle: context.textTheme.labelMedium!.copyWith(
                    color: AppColors.grayText,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _dataSectionWithName(
    BuildContext context, {
    EdgeInsetsGeometry? padding,
    required String title,
    required String subTitle,
    required Widget body,
  }) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(vertical: 24.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(context.translate(title), style: context.textTheme.bodyLarge),
          DataSection(title: subTitle, body: body),
        ],
      ),
    );
  }

  Widget _procedureInfo(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _infoCard(
          context,
          icon: AppAssetPaths.stopSwitchIcon,
          title: context.translate(LocalizationKeys.duration),
          subTile: "2 - 3 ساعات",
        ),
        SizedBox(width: 16),
        _infoCard(
          context,
          icon: AppAssetPaths.alarmClockIcon,
          title: context.translate(LocalizationKeys.time),
          subTile: "10:00 صباحا",
        ),
        SizedBox(width: 16),
        _infoCard(
          context,
          icon: AppAssetPaths.calendarIcon,
          title: context.translate(LocalizationKeys.date),
          subTile: "25 نوفمبر",
        ),
      ],
    );
  }

  Widget _infoCard(
    BuildContext context, {
    required String title,
    required String subTile,
    required String icon,
  }) {
    return Container(
      height: 112.h,
      width: 103.w,
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Expanded(child: SvgPicture.asset(icon)),
          SizedBox(height: 8.h),
          Expanded(
            child: Text(
              title,
              style: context.textTheme.labelSmall!.copyWith(
                fontWeight: FontWeight.w400,
                color: AppColors.blackText,
                fontSize: 13,
              ),
            ),
          ),
          SizedBox(height: 4.h),
          Expanded(
            child: Text(
              subTile,
              style: context.textTheme.bodyMedium!.copyWith(fontSize: 14),
            ),
          ),
        ],
      ),
    );
  }

  Widget _transplantStatusMessage(BuildContext context) {
    return ContainerWithShadow(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h),
        child: Column(
          children: [
            SvgPicture.asset(
              AppAssetPaths.inProgressIcon,
              // width: 28.w,
              // height: 28.w,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Text(
                context.translate(LocalizationKeys.procedureScheduled),
                style: context.textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Text(
              softWrap: true,
              overflow: TextOverflow.visible,
              context.translate(LocalizationKeys.allSetWeAreWithYou),
              style: context.textTheme.labelMedium!.copyWith(
                color: AppColors.grayText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
