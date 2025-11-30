import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/_core/widgets/base_stateful_screen_widget.dart';
import 'package:organ_link/features/user_flow/widget/base_body_scaffold.dart';
import 'package:organ_link/features/widgets/app_buttons/app_button_with_gradient_colors.dart';
import 'package:organ_link/features/widgets/container_with_shadow.dart';
import 'package:organ_link/features/widgets/custom_divider_widget.dart';
import 'package:organ_link/res/app_colors.dart';
import 'package:organ_link/utils/locale/app_localization_keys.dart';

class HospitalInformationScreen extends BaseStatefulScreenWidget {
  const HospitalInformationScreen({super.key});

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
  /////////////////// Helper methods ////////////////////////
  ///////////////////////////////////////////////////////////

  Widget _buildBody() {
    return BaseBodyScaffold(title: context.translate(LocalizationKeys.contactUs), onBackTap: (){}, body:  Padding(
                  padding: EdgeInsets.only(bottom: 24.h),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      _hospitalName(),
                      _sections(
                        //height: 170.h,
                        title: context.translate(LocalizationKeys.location),
                        titleOfButton: context.translate(
                          LocalizationKeys.openInMaps,
                        ),
                        onTap: () {},
                        body: Text(
                          "Nile Corniche, El Aini, Sayeda Zeinab, Cairo",
                          style: context.textTheme.labelMedium!.copyWith(
                            color: AppColors.grayText,
                          ),
                        ),
                      ),
                      _sections(
                        // height: 350.h,
                        title: context.translate(
                          LocalizationKeys.contactInformation,
                        ),
                        titleOfButton: context.translate(
                          LocalizationKeys.callNow,
                        ),
                        body: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomDividerWidget(verticalPadding: 8),
                            SizedBox(height: 16.h),
                            _rowInfoCard(
                              divider: true,
                              title: context.translate(
                                LocalizationKeys.mainPhone,
                              ),
                              subTitle: "+20 1012345678",
                            ),
                            _rowInfoCard(
                              isImportant: true,
                              divider: true,
                              title: context.translate(
                                LocalizationKeys.emergency,
                              ),
                              subTitle: "+20 1012345678",
                            ),
                            _rowInfoCard(
                              title: context.translate(LocalizationKeys.email),
                              subTitle: "email@gmail.com",
                            ),
                          ],
                        ),
                      ),
                      _sections(
                        //height: 310.h,
                        title: context.translate(
                          LocalizationKeys.attendingPhysician,
                        ),
                        body: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            CustomDividerWidget(verticalPadding: 8),
                            SizedBox(height: 16.h),
                            _rowInfoCard(
                              divider: true,
                              title: context.translate(LocalizationKeys.name),
                              subTitle: "د. خالد عبدالله سالم",
                            ),
                            _rowInfoCard(
                              divider: true,
                              title: context.translate(
                                LocalizationKeys.specialty,
                              ),
                              subTitle: "استشاري جراحة الكلي والمسالك البولية",
                            ),
                            _rowInfoCard(
                              title: context.translate(
                                LocalizationKeys.clinicPhoneNumber,
                              ),
                              subTitle: "1012345678",
                            ),
                          ],
                        ),
                      ),
                      _sections(
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

  Widget _rowInfoCard({
    required String title,
    bool divider = false,
    bool isImportant = false,
    required String subTitle,
  }) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: context.textTheme.labelMedium!.copyWith(
                color: AppColors.grayText,
              ),
            ),
            Spacer(flex: 1),
            Expanded(
              child: Text(
                subTitle,
                textAlign: TextAlign.center,
                softWrap: true,
                overflow: TextOverflow.visible,
                style: context.textTheme.bodyMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: isImportant
                      ? AppColors.importantText
                      : AppColors.textColor,
                ),
              ),
            ),

            // Text(
            //   subTitle,
            //   style: context.textTheme.bodyMedium!.copyWith(
            //     fontWeight: FontWeight.w600,
            //     color: isImportant
            //         ? AppColors.importantText
            //         : AppColors.textColor,
            //   ),
            // ),
          ],
        ),
        divider
            ? CustomDividerWidget(indent: 24.w, endIndent: 24.w)
            : SizedBox.shrink(),
      ],
    );
  }

  Widget _sections({
    double? height,
    required String title,
    required Widget body,
    String? titleOfButton,
    void Function()? onTap,
  }) {
    return ContainerWithShadow(
      height: height,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: context.textTheme.bodyLarge),
            SizedBox(height: 16.h),
            body,
            if (titleOfButton != null) ...[
              SizedBox(height: 24.h),
              AppButtonWithGradientColors(text: titleOfButton, onTap: onTap),
            ],
          ],
        ),
      ),
    );
  }

  Widget _hospitalName() {
    return ContainerWithShadow(
      //height: 93.h,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                "Qasr El Aini Hospital",
                style: context.textTheme.bodyLarge,
              ),
            ),
            SizedBox(height: 10.h),
            Text(
              "Cairo",
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
