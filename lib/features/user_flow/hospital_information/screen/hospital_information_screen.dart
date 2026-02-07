import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/_core/widgets/base_stateful_screen_widget.dart';
import 'package:organ_link/features/user_flow/widget/base_body_scaffold.dart';
import 'package:organ_link/features/user_flow/widget/hospital_name_container.dart';
import 'package:organ_link/features/widgets/data_row_with_divider.dart';
import 'package:organ_link/features/widgets/data_section.dart';
import 'package:organ_link/features/widgets/custom_divider_widget.dart';
import 'package:organ_link/res/app_colors.dart';
import 'package:organ_link/utils/locale/app_localization_keys.dart';

class HospitalInformationScreen extends BaseStatefulScreenWidget {
  const HospitalInformationScreen({super.key});
  static const routeName = "/hospital-information-screen";

  @override
  BaseScreenState<BaseStatefulScreenWidget> baseScreenCreateState() =>
      _HospitalInformationScreenState();
}

class _HospitalInformationScreenState
    extends BaseScreenState<HospitalInformationScreen> {
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
      title: context.translate(LocalizationKeys.contactUs),
      onBackTap: () {
        Navigator.pop(context);
      },
      body: Padding(
        padding: EdgeInsets.only(bottom: 24.h),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            HospitalNameContainer(
              hospitalName: "Qasr El Aini Hospital",
              hospitalLocation: "Cairo",
            ),

            DataSection(
              paddingAroundContainer: EdgeInsets.symmetric(vertical: 0),
              title: context.translate(LocalizationKeys.location),
              titleOfButton: context.translate(LocalizationKeys.openInMaps),
              onTap: () {},
              body: Text(
                "Nile Corniche, El Aini, Sayeda Zeinab, Cairo",
                style: context.textTheme.labelMedium!.copyWith(
                  color: AppColors.grayText,
                ),
              ),
            ),
            DataSection(
              title: context.translate(LocalizationKeys.contactInformation),
              titleOfButton: context.translate(LocalizationKeys.callNow),
              body: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomDividerWidget(verticalPadding: 8),
                  SizedBox(height: 16.h),
                  DataRowWithDivider(
                    divider: true,
                    title: context.translate(LocalizationKeys.mainPhone),
                    subTitle: "+20 1012345678",
                  ),
                  DataRowWithDivider(
                    isImportant: true,
                    divider: true,
                    title: context.translate(LocalizationKeys.emergency),
                    subTitle: "+20 1012345678",
                  ),
                  DataRowWithDivider(
                    title: context.translate(LocalizationKeys.email),
                    subTitle: "email@gmail.com",
                  ),
                ],
              ),
            ),
            DataSection(
              paddingAroundContainer: EdgeInsets.symmetric(vertical: 0),
              title: context.translate(LocalizationKeys.attendingPhysician),
              body: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  CustomDividerWidget(verticalPadding: 8),
                  SizedBox(height: 16.h),
                  DataRowWithDivider(
                    divider: true,
                    title: context.translate(LocalizationKeys.name),
                    subTitle: "د. خالد عبدالله سالم",
                  ),
                  DataRowWithDivider(
                    divider: true,
                    title: context.translate(LocalizationKeys.specialty),
                    subTitle: "استشاري جراحة الكلي والمسالك البولية",
                  ),
                  DataRowWithDivider(
                    title: context.translate(
                      LocalizationKeys.clinicPhoneNumber,
                    ),
                    subTitle: "1012345678",
                  ),
                ],
              ),
            ),
            DataSection(
              title: context.translate(LocalizationKeys.workingHours),
              body: Column(
                children: [
                  CustomDividerWidget(verticalPadding: 8.h),
                  Center(
                    child: Text(
                      "السبت - الخميس | من 8:00 ص - 4:00 م",
                      style: context.textTheme.bodyMedium!.copyWith(
                        color: AppColors.blackText,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            _infoNoticeCard(),
          ],
        ),
      ),
    );
  }

  Widget _infoNoticeCard() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: Container(
        height: 95.h,
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: AppColors.importantText, blurRadius: 2)],
          borderRadius: BorderRadius.circular(16.r),
          color: AppColors.backgroundForImportantText,
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 26.w),
          child: Text(
            context.translate(LocalizationKeys.emergencyMessage),
            style: context.textTheme.labelMedium!.copyWith(
              color: Color(0xff656464),
              fontSize: 16,
            ),
          ),
        ),
      ),
    );
  }
}
