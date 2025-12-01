import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/_core/widgets/base_stateful_screen_widget.dart';
import 'package:organ_link/features/user_flow/widget/base_body_scaffold.dart';
import 'package:organ_link/features/widgets/container_with_shadow.dart';
import 'package:organ_link/features/widgets/custom_divider_widget.dart';
import 'package:organ_link/res/app_asset_paths.dart';
import 'package:organ_link/res/app_colors.dart';
import 'package:organ_link/utils/locale/app_localization_keys.dart';

class MedicalDetailsScreen extends BaseStatefulScreenWidget {
  const MedicalDetailsScreen({super.key});
  static String routeName = "/medical-details-screen";

  @override
  BaseScreenState<BaseStatefulScreenWidget> baseScreenCreateState() =>
      _MedicalDetailsScreenState();
}

class _MedicalDetailsScreenState extends BaseScreenState<MedicalDetailsScreen> {
  @override
  Widget baseScreenBuild(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: _buildBody(),
    );
  }
  ///////////////////////////////////////////////////////////
  /////////////////// Helper methods ////////////////////////
  ///////////////////////////////////////////////////////////

  Widget _buildBody() {
    return BaseBodyScaffold(
      title: context.translate(LocalizationKeys.medicalDetailsScreen),
      onBackTap: () {
        Navigator.pop(context);
      },
      body: Column(
        children: [
          _personalInfoCard(),
          _chronicDiseasesCard(),
          _medicalTestCard(),
          _upcomingAppointmentCard(),
          _infoNoticeCard(),
        ],
      ),
    );
  }

  Widget _baseOfCard({
    required String titleOfCard,
    required Widget body,
    EdgeInsetsGeometry? padding,
    double? verticalPaddingOfDivider,
  }) {
    return ContainerWithShadow(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              context.translate(titleOfCard),
              style: context.textTheme.bodyLarge,
            ),
            Padding(
              padding: padding ?? EdgeInsets.all(0),
              child: CustomDividerWidget(
                verticalPadding: verticalPaddingOfDivider ?? 0,
              ),
            ),
            body,
          ],
        ),
      ),
    );
  }

  Widget _personalInfoCard() {
    return _baseOfCard(
      padding: EdgeInsets.only(bottom: 8.h, top: 16.h),
      titleOfCard: LocalizationKeys.personalInformation,
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _personalInfoColumn(
                  title: LocalizationKeys.fullName,
                  subTitle: "Mariana Adly Labib ",
                ),
                _personalInfoColumn(
                  title: LocalizationKeys.type,
                  subTitle: "female",
                ),
                _personalInfoColumn(
                  title: LocalizationKeys.requiredOrgan,
                  subTitle: "Kidney",
                ),
              ],
            ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _personalInfoColumn(
                  title: LocalizationKeys.medicalFileNumber,
                  subTitle: "MF-2025-1117",
                ),
                _personalInfoColumn(
                  title: LocalizationKeys.age,
                  subTitle: "21 year",
                ),
                _personalInfoColumn(
                  title: LocalizationKeys.bloodType,
                  subTitle: "A+",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _chronicDiseasesCard() {
    return _baseOfCard(
      verticalPaddingOfDivider: 16.h,
      titleOfCard: LocalizationKeys.chronicDiseases,
      body: _buildBodyOfChronicDiseasesCard(),
    );
  }

  Widget _medicalTestCard() {
    return _baseOfCard(
      verticalPaddingOfDivider: 16.h,
      titleOfCard: LocalizationKeys.medicalTests,
      body: Column(
        children: [
          Container(
            height: 85.h,
            // width: 311.w,
            decoration: BoxDecoration(
              color: AppColors.medicalTestContainerBG,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(color: Color(0xff00C951), offset: Offset(4, 0)),
              ],
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Complete Blood Count (CBC)",
                        style: context.textTheme.bodyMedium!.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      SizedBox(height: 9.h),
                      Text(
                        "October 16, 2025 | Normal",
                        style: context.textTheme.labelSmall!.copyWith(
                          fontWeight: FontWeight.w400,
                          color: AppColors.blackText,
                          fontSize: 13.sp,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 26.h,
                    width: 53.w,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      color: AppColors.medicalTestDoneBG,
                    ),
                    child: Center(
                      child: FittedBox(
                        fit: BoxFit.scaleDown,
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 8.w,
                            vertical: 4.h,
                          ),
                          child: Text(
                            "Done",

                            /// change based on condition
                            style: context.textTheme.labelMedium!.copyWith(
                              color: AppColors.medicalTestDoneText,
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              // height: 1.2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _upcomingAppointmentCard() {
    return _baseOfCard(
      verticalPaddingOfDivider: 16.h,
      titleOfCard: LocalizationKeys.upcomingAppointments,
      body: Container(
        decoration: BoxDecoration(
          color: AppColors.medicalTestContainerBG,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowForContainerInfo.withValues(alpha: 0.25),
              blurRadius: 4,
            ),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 84.w, vertical: 16.h),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(AppAssetPaths.calendarIcon),
              SizedBox(height: 16.h),
              Text(
                context.translate(LocalizationKeys.visitAppointment),
                style: context.textTheme.bodyMedium!.copyWith(
                  color: AppColors.grayText,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 9.h),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "25 November 2025",
                  style: context.textTheme.bodyLarge,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildBodyOfChronicDiseasesCard() {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.5,
        crossAxisSpacing: 16.w,
        mainAxisSpacing: 16.h,
      ),
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: EdgeInsets.zero,
      itemCount: 4,
      itemBuilder: (ctx, index) {
        return _diseaseCard(
          diseases: "Diabetes",
          diseasesIcon: AppAssetPaths.dropOfBloodIcon,
        );
      },
    );
  }

  Widget _diseaseCard({
    required String diseases,
    required String diseasesIcon,
  }) {
    return Container(
      // height: 98.h,
      // width: 147.w,
      padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 14.w),
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
            SvgPicture.asset(width: 32.w, height: 32.h, diseasesIcon),
            SizedBox(height: 16.h),
            Text(
              diseases,
              style: context.textTheme.labelSmall!.copyWith(
                fontWeight: FontWeight.w400,
                color: AppColors.blackText,
                fontSize: 13.sp,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _personalInfoColumn({
    required String title,
    required String subTitle,
  }) {
    return Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: Column(
        mainAxisSize: .min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            context.translate(title),
            style: context.textTheme.labelMedium!.copyWith(
              color: AppColors.grayText,
              fontSize: 14.sp,
            ),
          ),
          SizedBox(height: 8.h),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              subTitle,
              style: context.textTheme.labelSmall!.copyWith(
                color: AppColors.textColor,
                fontSize: 14.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoNoticeCard() {
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 6),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 26),
        height: 75.h,
        // width: 311.w,
        decoration: BoxDecoration(
          color: AppColors.medicalTestContainerBG,
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              AppColors.hospitalInfoColorBG2,
              AppColors.hospitalInfoColorBG1,
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.hospitalInfoShadow,
              offset: Offset(4, 0),
            ),
          ],
        ),
        child: Center(
          child: Text(
            context.translate(LocalizationKeys.hospitalDataNote),
            style: context.textTheme.displayMedium!.copyWith(
              fontSize: 16,
              color: AppColors.hospitalInfoText,
            ),
          ),
        ),
      ),
    );
  }
}
