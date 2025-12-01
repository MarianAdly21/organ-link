import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/_core/widgets/base_stateful_screen_widget.dart';
import 'package:organ_link/features/user_flow/case_follow_up/screen/case_follow_up_screen.dart';
import 'package:organ_link/features/user_flow/hospital_information/screen/hospital_information_screen.dart';
import 'package:organ_link/features/user_flow/medical_details/screens/medical_details_screen.dart';
import 'package:organ_link/features/widgets/custom_divider_widget.dart';
import 'package:organ_link/res/app_asset_paths.dart';
import 'package:organ_link/res/app_colors.dart';
import 'package:organ_link/utils/locale/app_localization_keys.dart';

class HomeUserScreen extends BaseStatefulScreenWidget {
  const HomeUserScreen({super.key});
  static const routeName = "/home-user-screen";

  @override
  BaseScreenState<BaseStatefulScreenWidget> baseScreenCreateState() =>
      _HomeUserScreenState();
}

class _HomeUserScreenState extends BaseScreenState<HomeUserScreen> {
  // final List<CardUiModel> cards = [
  //   CardUiModel(
  //     icon: AppAssetPaths.personalIcon,
  //     title: LocalizationKeys.medicalDetails,
  //     subTitle: LocalizationKeys.viewHealthInformation,
  //     onTap: () {},
  //   ),
  //   CardUiModel(
  //     icon: AppAssetPaths.hospitalIcon,
  //     title: LocalizationKeys.hospitalInformation,
  //     subTitle: LocalizationKeys.contactAndLocation,
  //     onTap: () {},
  //   ),
  //   CardUiModel(
  //     icon: AppAssetPaths.stockChartIcon,
  //     title: LocalizationKeys.caseFollowUp,
  //     subTitle: LocalizationKeys.operationStagesTracking,
  //     onTap: () {},
  //   ),
  //   CardUiModel(
  //     icon: AppAssetPaths.settingIcon,
  //     title: LocalizationKeys.settings,
  //     subTitle: LocalizationKeys.accountManagement,
  //     onTap: () {},
  //   ),
  // ];

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
    return SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
        child: Column(
          children: [
            _appBarWidget(),
            SizedBox(height: 8.h),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    SizedBox(height: 48.h),
                    _cardDetails(),
                    SizedBox(height: 24.h),
                    _buildBodyList(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBodyList() {
    return Column(
      children: [
        Row(
          children: [
            Flexible(
              child: _mainCard(
                onTap: () {
                  Navigator.of(
                    context,
                  ).pushNamed(MedicalDetailsScreen.routeName);
                },
                icon: AppAssetPaths.personalIcon,
                title: LocalizationKeys.medicalDetails,
                subTitle: LocalizationKeys.viewHealthInformation,
              ),
            ),
            SizedBox(width: 16.w),
            Flexible(
              child: _mainCard(
                onTap: () {
                  Navigator.of(context).pushNamed(CaseFollowUpScreen.routeName);
                },
                icon: AppAssetPaths.stockChartIcon,
                title: LocalizationKeys.caseFollowUp,
                subTitle: LocalizationKeys.operationStagesTracking,
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Flexible(
              child: _mainCard(
                onTap: () {
                  Navigator.of(
                    context,
                  ).pushNamed(HospitalInformationScreen.routeName);
                },
                icon: AppAssetPaths.hospitalIcon,
                title: LocalizationKeys.hospitalInformation,
                subTitle: LocalizationKeys.contactAndLocation,
              ),
            ),
            SizedBox(width: 16.w),
            Flexible(
              child: _mainCard(
                onTap: () {},
                icon: AppAssetPaths.settingIcon,
                title: LocalizationKeys.settings,
                subTitle: LocalizationKeys.accountManagement,
              ),
            ),
          ],
        ),
      ],
    );

    // GridView.builder(
    //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //     crossAxisCount: 2,
    //     childAspectRatio: 1.4,
    //     crossAxisSpacing: 16.w,
    //     mainAxisSpacing: 16.h,
    //   ),
    //   shrinkWrap: true,
    //   physics: const NeverScrollableScrollPhysics(),
    //   padding: EdgeInsets.zero,
    //   itemCount: cards.length,
    //   itemBuilder: (ctx, index) {
    //     return CustomCardWidget(cardUiModel: cards[index]);
    //   },
    // );
  }

  Widget _mainCard({
    required String icon,
    required String title,
    required String subTitle,
    required void Function() onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 116.h,
        width: 164.w,
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
              SvgPicture.asset(width: 32.w, height: 32.h, icon),
              SizedBox(height: 16.h),
              Text(
                context.translate(title),
                style: context.textTheme.labelMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.blackText,
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                // maxLines: 1,
                // overflow: TextOverflow.visible,
                textAlign: TextAlign.center,
                context.translate(subTitle),
                style: context.textTheme.labelMedium!.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 13.sp,
                  color: AppColors.grayText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _appBarWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SvgPicture.asset(
          height: 32.h,
          width: 32.w,
          AppAssetPaths.notificationIcon,
        ),
        GestureDetector(
          onTap: () {},
          child: SvgPicture.asset(
            height: 32.h,
            width: 109.w,
            AppAssetPaths.organLinkTextWithIcon,
          ),
        ),
      ],
    );
  }

  Widget _cardDetails() {
    return Container(
      // height: 230.h,
      width: 343.w,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: AppColors.shadowForContainerInfo.withValues(alpha: 0.25),
            blurRadius: 4,
          ),
        ],
        borderRadius: BorderRadius.circular(16.r),
        color: AppColors.containerColor,
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Mariana Adly Labib",
                      style: context.textTheme.bodyLarge!.copyWith(
                        color: AppColors.blackText,
                      ),
                    ),
                    SizedBox(height: 16.h),
                    Text(
                      "${context.translate(LocalizationKeys.identificationNumberWithColumn)}1234 ",
                      style: context.textTheme.labelMedium!.copyWith(
                        color: AppColors.grayText,
                      ),
                    ),
                  ],
                ),
                Container(
                  height: 24,
                  width: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8.r),
                    color: AppColors.displayFieldBGColor,
                  ),
                  child: Center(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        context.translate(LocalizationKeys.patient),

                        /// change based on condition
                        style: context.textTheme.labelMedium!.copyWith(
                          color: AppColors.textColor,
                          fontSize: 14,
                          height: 1.2,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            CustomDividerWidget(),
            Text(
              context.translate(LocalizationKeys.currentStatus),
              style: context.textTheme.labelMedium!.copyWith(
                color: AppColors.blackText,
              ),
            ),
            SizedBox(height: 12.h),
            Container(
              height: 40.h,
              width: 310.w,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16.r),
                color: AppColors.displayFieldBGColor,
              ),
              child: Center(
                child: Text(
                  context.translate(LocalizationKeys.underReview),

                  /// change based on condition
                  style: context.textTheme.bodyMedium!.copyWith(
                    color: AppColors.textColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
            SizedBox(height: 16.h),
            Text(
              "${context.translate(LocalizationKeys.lastUpdate)}date",
              style: context.textTheme.bodySmall!.copyWith(
                color: AppColors.grayText,
                fontWeight: FontWeight.w400,
                fontSize: 13,
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _navToMedicalDetailsScreen() {
    Navigator.of(context).pushNamed(MedicalDetailsScreen.routeName);
  }
}
