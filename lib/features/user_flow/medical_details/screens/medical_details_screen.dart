import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/_core/widgets/base_stateful_screen_widget.dart';
import 'package:organ_link/features/widgets/container_with_shadow.dart';
import 'package:organ_link/features/widgets/custom_divider_widget.dart';
import 'package:organ_link/res/app_asset_paths.dart';
import 'package:organ_link/res/app_colors.dart';

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
      body: buildBody(),
    );
  }
  ///////////////////////////////////////////////////////////
  /////////////////// Helper methods ////////////////////////
  ///////////////////////////////////////////////////////////

  Widget buildBody() {
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.only(left: 16.w, right: 16.w, bottom: 48.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildAppBar(),
            SizedBox(height: 24.h),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    personalInfoCard(),
                    chronicDiseasesCard(),
                    medicalTestCard(),
                    upcomingAppointmentCard(),
                    infoNoticeCard(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildAppBar() {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () {},
          child: SvgPicture.asset(AppAssetPaths.arrowBackIcon),
        ),
        SizedBox(width: 63),
        Text(
          "Medical Details",
          style: context.textTheme.bodyLarge!.copyWith(
            color: AppColors.blackText,
          ),
        ),
      ],
    );
  }

  Widget baseOfCard({
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
            Text(titleOfCard, style: context.textTheme.bodyLarge),
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

  Widget personalInfoCard() {
    return baseOfCard(
      padding: EdgeInsets.only(bottom: 8.h, top: 16.h),
      titleOfCard: "Personal information",
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                personalInfoColumn(
                  title: "full Name",
                  subTitle: "Mariana Adly Labib ",
                ),
                personalInfoColumn(title: "Type", subTitle: "female"),
                personalInfoColumn(title: "Required Organ", subTitle: "Kidney"),
              ],
            ),
          ),
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                personalInfoColumn(
                  title: "Medical File Number",
                  subTitle: "MF-2025-1117",
                ),
                personalInfoColumn(title: "Age", subTitle: "21 year"),
                personalInfoColumn(title: "Blood Type", subTitle: "A+"),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget chronicDiseasesCard() {
    return baseOfCard(
      verticalPaddingOfDivider: 16.h,
      titleOfCard: "Chronic Diseases",
      body: buildBodyOfChronicDiseasesCard(),
    );
  }

  Widget medicalTestCard() {
    return baseOfCard(
      verticalPaddingOfDivider: 16.h,
      titleOfCard: "Medical Tests",
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

  Widget upcomingAppointmentCard() {
    return baseOfCard(
      verticalPaddingOfDivider: 16.h,
      titleOfCard: "Upcoming Appointments",
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
                "Visit Appointment",
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

  Widget buildBodyOfChronicDiseasesCard() {
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
        return diseaseCard(
          diseases: "Diabetes",
          diseasesIcon: AppAssetPaths.dropOfBloodIcon,
        );
      },
    );
  }

  Widget diseaseCard({required String diseases, required String diseasesIcon}) {
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

  Widget personalInfoColumn({required String title, required String subTitle}) {
    return Padding(
      padding: EdgeInsets.only(top: 16.h),
      child: Column(
        mainAxisSize: .min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
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

  Widget infoNoticeCard() {
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
            "All information displayed here was entered by the hospital and cannot be modified.",
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
