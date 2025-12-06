import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/_core/widgets/base_dialog_widget.dart';
import 'package:organ_link/_core/widgets/base_stateful_screen_widget.dart';
import 'package:organ_link/features/user_flow/widget/base_body_scaffold.dart';
import 'package:organ_link/features/widgets/data_row_with_divider.dart';
import 'package:organ_link/features/widgets/data_section.dart';
import 'package:organ_link/features/widgets/app_buttons/app_buttons.dart';
import 'package:organ_link/features/widgets/container_with_shadow.dart';
import 'package:organ_link/features/widgets/custom_divider_widget.dart';
import 'package:organ_link/features/widgets/log_out_Widget.dart';
import 'package:organ_link/res/app_colors.dart';
import 'package:organ_link/utils/locale/app_localization_keys.dart';

class SettingsScreen extends BaseStatefulScreenWidget {
  const SettingsScreen({super.key});
  static const routeName = "/settings-screen";
  @override
  BaseScreenState<BaseStatefulScreenWidget> baseScreenCreateState() =>
      _SettingsScreenState();
}

class _SettingsScreenState extends BaseScreenState<SettingsScreen> {
  @override
  Widget baseScreenBuild(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: _buildBody(context),
    );
  }

  ///////////////////////////////////////////////////////////
  /////////////////// Helper widget ////////////////////////
  ///////////////////////////////////////////////////////////

  BaseBodyScaffold _buildBody(BuildContext context) {
    return BaseBodyScaffold(
      title: context.translate(LocalizationKeys.settings),
      onBackTap: () {
        Navigator.pop(context);
      },
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          _hospitalName(),
          DataSection(
            paddingAroundContainer: EdgeInsets.symmetric(vertical: 0),
            title: context.translate(LocalizationKeys.appAbout),
            body: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomDividerWidget(verticalPadding: 8),
                SizedBox(height: 16.h),
                DataRowWithDivider(
                  divider: true,
                  title: context.translate(LocalizationKeys.appNameTitle),
                  subTitle: context.translate(LocalizationKeys.appName),
                ),
                DataRowWithDivider(
                  divider: true,
                  title: context.translate(LocalizationKeys.appVersion),
                  subTitle: "1.0.0",
                ),
                DataRowWithDivider(
                  title: context.translate(LocalizationKeys.appDescription),
                  subTitle: context.translate(
                    LocalizationKeys.appFullDescription,
                  ),
                ),
              ],
            ),
          ),
          DataSection(
            title: context.translate(LocalizationKeys.language),
            body: Column(
              children: [
                CustomDividerWidget(verticalPadding: 8),
                SizedBox(height: 16.h),
              ],
            ),
          ),
          DataSection(
            paddingAroundContainer: EdgeInsets.symmetric(vertical: 0),
            title: context.translate(LocalizationKeys.support),
            body: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomDividerWidget(verticalPadding: 8),
                SizedBox(height: 16.h),
                DataRowWithDivider(
                  title: context.translate(LocalizationKeys.email),
                  subTitle: "support@organlink.health",
                ),
                SizedBox(height: 16.h),
                DataRowWithDivider(
                  title: context.translate(LocalizationKeys.hotline),
                  subTitle: "92000",
                ),
              ],
            ),
          ),
          LogOutWidget(
            onPressed: () {
              _logoutConfirmation();
            },
            text: context.translate(LocalizationKeys.logout),
          ),
        ],
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

class LogoutConfirmationDialogScreen extends BaseDialogWidget {
  const LogoutConfirmationDialogScreen({super.key});

  @override
  BaseDialogState<BaseDialogWidget> baseDialogCreateState() =>
      _LogoutConfirmationDialogScreenState();
}

class _LogoutConfirmationDialogScreenState
    extends BaseDialogState<LogoutConfirmationDialogScreen> {
  @override
  Widget baseDialogBuild(BuildContext context) {
    return Column(
      children: [
        Text(
          context.translate(LocalizationKeys.confirmLogoutTitle),
          style: context.textTheme.bodyLarge,
        ),
        SizedBox(height: 8.h),
        Text(
          textAlign: TextAlign.center,
          context.translate(
            LocalizationKeys.areYouSureYouWantToLogOutOfTheApplication,
          ),
          style: context.textTheme.labelMedium!.copyWith(
            color: AppColors.grayText,
          ),
        ),
        SizedBox(height: 16.h),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _dialogBtn(
              text: LocalizationKeys.cancel,
              onTap: () {
                Navigator.pop(context);
              },
              backgroundColor: AppColors.cancelBtnBG,
              textColor: AppColors.blackText,
            ),
            SizedBox(width: 16.w),
            _dialogBtn(
              text: LocalizationKeys.confirmLogout,
              onTap: () {},
              backgroundColor: AppColors.backgroundForLogoutButton,
              textColor: Colors.white,
            ),
          ],
        ),
      ],
    );
  }

  Widget _dialogBtn({
    required String text,
    required Color? textColor,
    required Color? backgroundColor,
    required void Function() onTap,
  }) {
    return Expanded(
      child: AppElevatedButton(
        onPressed: onTap,
        color: backgroundColor,
        padding: EdgeInsets.symmetric(vertical: 16),
        label: FittedBox(
          fit: BoxFit.scaleDown,
          child: Text(
            context.translate(text),
            style: context.textTheme.bodyMedium!.copyWith(color: textColor),
          ),
        ),
      ),
    );
  }
}
