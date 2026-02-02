import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/_core/extensions/screen_sizer_extension.dart';
import 'package:organ_link/_core/widgets/base_dialog_widget.dart';
import 'package:organ_link/_core/widgets/base_stateful_screen_widget.dart';
import 'package:organ_link/features/hospital_flow/widget/app_base_body_scaffold.dart';
import 'package:organ_link/features/ministry_flow/widgets/info_tile_with_status_custom_widget.dart';
import 'package:organ_link/features/ministry_flow/widgets/title_and_subtitle_custom_widget.dart';
import 'package:organ_link/features/shared_screens/log_out_confirmation/log_out_confirmationDialog_screen.dart';
import 'package:organ_link/features/widgets/app_buttons/app_button_with_gradient_colors.dart';
import 'package:organ_link/features/widgets/container_with_shadow.dart';
import 'package:organ_link/features/widgets/custom_divider_widget.dart';
import 'package:organ_link/features/widgets/data_row_with_status_container_widget.dart';
import 'package:organ_link/features/widgets/log_out_Widget.dart';
import 'package:organ_link/features/widgets/text_field/app_text_form_filed_widget.dart';
import 'package:organ_link/res/app_colors.dart';
import 'package:organ_link/utils/locale/app_localization.dart';
import 'package:organ_link/utils/locale/app_localization_keys.dart';

class MinistrySettingsScreen extends BaseStatefulScreenWidget {
  const MinistrySettingsScreen({super.key});
  static const routeName = "/ministry-setting-screen";

  @override
  BaseScreenState<BaseStatefulScreenWidget> baseScreenCreateState() =>
      _MinistrySettingsScreenState();
}

class _MinistrySettingsScreenState
    extends BaseScreenState<MinistrySettingsScreen> {
  @override
  Widget baseScreenBuild(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: AppBaseBodyScaffold(
        titleOfScreen: LocalizationKeys.settings,
        backTap: () {
          Navigator.pop(context);
        },
        body: _buildBody(),
      ),
    );
  }
  ///////////////////////////////////////////////////////////
  /////////////////// Helper widget ////////////////////////
  ///////////////////////////////////////////////////////////

  Widget _buildBody() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _personalInfoSection(),
          _registeredUsers(),
          LogOutWidget(
            text: context.translate(LocalizationKeys.logout),
            onPressed: () {
              _logoutConfirmation();
            },
          ),
        ],
      ),
    );
  }

  Widget _registeredUsers() {
    return ContainerWithShadow(
      padding: EdgeInsets.symmetric(vertical: 0, horizontal: 3),
      contentPadding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
      child: Column(
        children: [
          TitleAndSubtitleCustomWidget(
            title: LocalizationKeys.registeredUsers,
            subTitle: LocalizationKeys.userManagement,
          ),
          CustomDividerWidget(),
          ListView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            itemCount: 2,
            itemBuilder: (context, index) {
              return _registeredUserInfo(
                name: "د. أحمد محمود",
                email: "ahmed.mahmoud@moh.gov.eg",
                status: "نشط الان",
                job: "مسؤول النظام",
              );
            },
          ),
          AppButtonWithGradientColors(
            text: context.translate(LocalizationKeys.addNewUser),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget _registeredUserInfo({
    required String name,
    required String email,
    required String status,
    required String job,
  }) {
    return Column(
      children: [
        InfoTileWithStatusCustomWidget(
          title: name,
          subtitle: email,
          status: status,
        ),
        Padding(
          padding: EdgeInsets.only(top: 16.h),
          child: DataRowWithStatusContianerWidget(
            statusIsCentered: true,
            divider: true,
            title: "الوظيفة",
            subTitle: job,
            statusTextStyle: context.textTheme.labelMedium!.copyWith(
              color: AppColors.textColor,
            ),
            backgroundColor: AppColors.transparent,
            border: Border.all(color: AppColors.borderSettingsContainer),
          ),
        ),
      ],
    );
  }

  ContainerWithShadow _personalInfoSection() {
    return ContainerWithShadow(
      contentPadding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
      child: Column(
        children: [
          TitleAndSubtitleCustomWidget(
            title: LocalizationKeys.profileInformation,
            subTitle: LocalizationKeys.updatePersonalData,
          ),
          CustomDividerWidget(),
          _nameCard(),
          _formSection(),
        ],
      ),
    );
  }

  Widget _textField({required String title, required String hintText}) {
    return AppTextFormField(
      title: title,
      enableBorderColor: AppColors.enableBorderColorStting,
      fillColor: AppColors.filledColorenable,
      titleColor: AppColors.grayText,
      hintText: hintText,
      hintTextStyle: context.textTheme.labelMedium!.copyWith(
        color: AppColors.textColor,
      ),
    );
  }

  Widget _formSection() {
    return Form(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: _textField(
              title: LocalizationKeys.fullName,
              hintText: "د. أحمد محمود",
            ),
          ),
          _textField(
            title: LocalizationKeys.phoneNumber,
            hintText: "+201001234567",
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16),
            child: _textField(
              title: LocalizationKeys.email,
              hintText: "ahmed.mahmoud@moh.gov.eg",
            ),
          ),
          _textField(
            title: LocalizationKeys.position,
            hintText: "مسؤول النظام - وزارة الصحة",
          ),

          Padding(
            padding: EdgeInsets.only(top: 16.h),
            child: Row(
              children: [
                Expanded(
                  child: AppButtonWithGradientColors(
                    onTap: () {},
                    text: context.translate(LocalizationKeys.saveChange),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: AppButtonWithGradientColors(
                    onTap: () {},
                    text: context.translate(LocalizationKeys.cancel),
                    textColor: AppColors.blackText,
                    border: BoxBorder.all(color: AppColors.backButtonBorder),
                    colors: [
                      AppColors.followUpInvestigation,
                      AppColors.followUpInvestigation,
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _nameCard() {
    return Container(
      height: 119.h,
      width: context.width,
      decoration: BoxDecoration(
        color: AppColors.backgroundOfNameContainer,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: AppColors.borderOfNameContainer),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 16.w),
        child: Row(
          children: [
            Container(
              height: 64,
              width: 64,
              decoration: BoxDecoration(
                color: AppColors.seconderColor,
                borderRadius: BorderRadius.circular(50),
              ),
              child: Center(
                child: FittedBox(
                  child: Text(
                    "ا.م",
                    style: context.textTheme.labelLarge!.copyWith(
                      color: AppColors.nameInSettingsScreen,
                      fontSize: 32,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(width: 16.w),
            Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "د. أحمد محمود",
                  style: context.textTheme.bodyLarge!.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  "مسؤول النظام",
                  style: context.textTheme.labelMedium!.copyWith(
                    color: AppColors.grayText,
                  ),
                ),
              ],
            ),
          ],
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
