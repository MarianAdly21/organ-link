import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/_core/widgets/base_stateful_screen_widget.dart';
import 'package:organ_link/features/user_flow/widget/base_body_scaffold.dart';
import 'package:organ_link/features/widgets/container_with_black_shadow.dart';
import 'package:organ_link/features/widgets/container_with_shadow.dart';
import 'package:organ_link/features/widgets/custom_divider_widget.dart';
import 'package:organ_link/features/widgets/notice_container.dart';
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
  /////////////////// Helper widget ////////////////////////
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
          NoticeContainer(notice: LocalizationKeys.hospitalDataNote),
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
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _personalInfoColumn(
                  title: LocalizationKeys.fullName,
                  subTitle: "Mariana Adly Labib",
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
          SizedBox(width: 8),
          Expanded(
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
      body: Wrap(
        spacing: 16.w,
        runSpacing: 8.h,
        children: List.generate(6, (index) => _diseaseCard(disease: "السكري")),
      ),
    );
  }

  Widget _diseaseCard({required String disease}) {
    return ContainerWithBlackShadow(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      body: Text(
        disease,
        style: context.textTheme.labelSmall!.copyWith(
          fontWeight: FontWeight.w400,
          color: AppColors.blackText,
          fontSize: 13,
        ),
      ),
    );
  }

  Widget _medicalTestCard() {
    return _baseOfCard(
      verticalPaddingOfDivider: 16.h,
      titleOfCard: LocalizationKeys.medicalTests,
      body: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: 2,
        itemBuilder: (context, index) {
          return _medicalTest();
        },
      ),
    );
  }

  Widget _medicalTest() {
    return ContainerWithShadow(
      height: 85.h,
      borderSideColor: Color(0xff00C951),
      padding: EdgeInsets.only(bottom: 16.h),
      background: AppColors.medicalTestContainerBG,
      contentPadding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Complete Blood Count (CBC)",
                    style: context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 9.h),
                  Text(
                    "October 16, 2025 ",
                    style: context.textTheme.labelSmall!.copyWith(
                      fontWeight: FontWeight.w400,
                      color: AppColors.blackText,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(width: 9),
          Container(
            height: 26.h,
            width: 53.w,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: AppColors.medicalTestDoneBG,
            ),
            child: Center(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
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
    );
  }

  Widget _upcomingAppointmentCard() {
    return _baseOfCard(
      verticalPaddingOfDivider: 16.h,
      titleOfCard: LocalizationKeys.upcomingAppointments,
      body: Center(
        child: Container(
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
              fontSize: 14,
            ),
          ),
          SizedBox(height: 8.h),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              subTitle,
              style: context.textTheme.labelSmall!.copyWith(
                color: AppColors.textColor,
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
