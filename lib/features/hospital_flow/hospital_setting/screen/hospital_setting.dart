import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/_core/widgets/base_dialog_widget.dart';
import 'package:organ_link/_core/widgets/base_stateful_screen_widget.dart';
import 'package:organ_link/features/hospital_flow/widget/container_with_background.dart';
import 'package:organ_link/features/hospital_flow/widget/app_base_body_scaffold.dart';
import 'package:organ_link/features/ministry_flow/widgets/title_and_subtitle_custom_widget.dart';
import 'package:organ_link/features/shared_screens/log_out_confirmation/log_out_confirmationDialog_screen.dart';
import 'package:organ_link/features/widgets/app_buttons/app_button_with_gradient_colors.dart';
import 'package:organ_link/features/widgets/container_with_shadow.dart';
import 'package:organ_link/features/widgets/custom_divider_widget.dart';
import 'package:organ_link/features/widgets/data_row_with_divider.dart';
import 'package:organ_link/features/widgets/log_out_Widget.dart';
import 'package:organ_link/features/widgets/text_field/app_text_form_filed_widget.dart';
import 'package:organ_link/res/app_colors.dart';
import 'package:organ_link/utils/locale/app_localization_keys.dart';

class HospitalSetting extends BaseStatefulScreenWidget {
  const HospitalSetting({super.key});
  static const routeName = "/hospital-setting";
  @override
  BaseScreenState<BaseStatefulScreenWidget> baseScreenCreateState() =>
      _HospitalSettingState();
}

class _HospitalSettingState extends BaseScreenState<HospitalSetting> {
  @override
  Widget baseScreenBuild(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: AppBaseBodyScaffold(
        titleOfScreen: context.translate(LocalizationKeys.settings),
        backTap: () {
          Navigator.pop(context);
        },
        body: _buildBody(context),
      ),
    );
  }
  ///////////////////////////////////////////////////////////
  /////////////////// Helper widget ////////////////////////
  ///////////////////////////////////////////////////////////

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TitleAndSubtitleCustomWidget(
            title: context.translate(LocalizationKeys.settingsInformation),
            subTitle: context.translate(
              LocalizationKeys.manageHospitalAccountInfo,
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: 24.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                _hospitalInfoSection(),
                _systemInformation(),
                LogOutWidget(
                  onPressed: () {
                    _logoutConfirmation();
                  },
                  text: context.translate(LocalizationKeys.logout),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _systemInformation() {
    return ContainerWithShadow(
      borderSideColor: AppColors.seconderColor,
      padding: EdgeInsets.symmetric(vertical: 12.h),
      contentPadding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            context.translate(LocalizationKeys.systemInformation),
            style: context.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w600,
              color: AppColors.blackText,
            ),
          ),
          CustomDividerWidget(),
          DataRowWithDivider(
            divider: true,
            title: context.translate(LocalizationKeys.appVersion),
            subTitle: "v2.5.0",
          ),
          DataRowWithDivider(
            divider: true,
            title: context.translate(LocalizationKeys.userId),
            subTitle: "KE",
          ),
          DataRowWithDivider(
            divider: true,
            title: context.translate(LocalizationKeys.lastUpdate),
            subTitle: "2025-02-10",
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                context.translate(LocalizationKeys.connectionStatus),
                style: context.textTheme.labelMedium!.copyWith(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                ),
              ),
              ContainerWithBackground(
                backgroundColor: AppColors.readyTextBG,
                text: "متصل",
                textColor: AppColors.readyText,
              ),
            ],
          ),
          SizedBox(height: 16.h),
          AppButtonWithGradientColors(
            text: context.translate(LocalizationKeys.details),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _hospitalInfoSection() {
    return ContainerWithShadow(
      padding: EdgeInsets.only(bottom: 24.h),
      contentPadding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            context.translate(LocalizationKeys.hospitalInformation),
            style: context.textTheme.bodyMedium!.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            context.translate(LocalizationKeys.basicHospitalInfoMoh),
            style: context.textTheme.labelMedium!.copyWith(
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
          ),
          CustomDividerWidget(),
          _textField(
            title: context.translate(LocalizationKeys.hospitalName),
            hintText: "مستشفى القصر العيني  ",
          ),
          Row(
            children: [
              Flexible(
                child: Column(
                  children: [
                    _textField(
                      title: context.translate(
                        LocalizationKeys.registrationNumber,
                      ),
                      hintText: "HSP-2024-001",
                    ),
                    _textField(
                      title: context.translate(LocalizationKeys.numberOfBeds),
                      hintText: "HSP-2024-001",
                    ),
                  ],
                ),
              ),
              SizedBox(width: 16.w),
              Flexible(
                child: Column(
                  children: [
                    _textField(
                      title: context.translate(LocalizationKeys.city),
                      hintText: "القاهرة",
                    ),
                    _textField(
                      isEnable: true,
                      title: context.translate(LocalizationKeys.phoneNumber),
                      hintText: "012222222",
                    ),
                  ],
                ),
              ),
            ],
          ),
          _textField(
            isEnable: true,
            title: context.translate(LocalizationKeys.email),
            hintText: "m2005@gamialh",
          ),
          Padding(
            padding: EdgeInsets.only(top: 16.h, bottom: 24.h),
            child: AppButtonWithGradientColors(
              text: context.translate(LocalizationKeys.saveChange),
              onTap: () {},
            ),
          ),
          _notic(),
        ],
      ),
    );
  }

  Widget _notic() {
    return ContainerWithBackground(
      isCentered: true,
      contentPadding: EdgeInsets.symmetric(vertical: 9.h, horizontal: 16.w),
      textColor: AppColors.notificationMainTitle,
      backgroundColor: AppColors.notificationImportantItemBG,
      text: context.translate(LocalizationKeys.mohNota),
    );
  }

  Widget _textField({
    bool? isEnable,
    required String title,
    required String hintText,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: AppTextFormField(
        enable: isEnable ?? false,
        title: title,
        enableBorderColor: isEnable == true
            ? AppColors.enableBorderColorStting
            : null,
        fillColor: isEnable == true ? AppColors.filledColorenable : null,
        titleColor: AppColors.grayText,
        hintText: hintText,
        hintTextStyle: context.textTheme.labelMedium!.copyWith(
          color: isEnable == true ? AppColors.textColor : AppColors.blackText,
        ),
      ),
    );
  }

  ///////////////////////////////////////////////////////////
  /////////////////// Helper Method ////////////////////////
  ///////////////////////////////////////////////////////////

  Future<void> _logoutConfirmation() {
    return showAppDialog(
      context: context,
      dialogWidget: LogoutConfirmationDialogScreen(),
      shouldPopCallback: () {
        return true;
      },
    );
  }
}
