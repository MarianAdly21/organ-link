import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/_core/widgets/base_dialog_widget.dart';
import 'package:organ_link/_core/widgets/base_stateful_screen_widget.dart';
import 'package:organ_link/features/shared_screens/log_out_confirmation/log_out_confirmation_dialog_screen.dart';
import 'package:organ_link/features/user_flow/widget/base_body_scaffold.dart';
import 'package:organ_link/features/widgets/data_row_with_divider.dart';
import 'package:organ_link/features/widgets/data_section.dart';
import 'package:organ_link/features/widgets/custom_divider_widget.dart';
import 'package:organ_link/features/widgets/log_out_Widget.dart';
import 'package:organ_link/res/app_colors.dart';
import 'package:organ_link/utils/locale/app_localization_keys.dart';
import 'package:organ_link/utils/locale/locale_cubit.dart';

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
      body: _buildBody(
        context,
        appLocale: context.appLocale.currentLocaleCode(),
      ),
    );
  }

  ///////////////////////////////////////////////////////////
  /////////////////// Helper widget ////////////////////////
  ///////////////////////////////////////////////////////////

  BaseBodyScaffold _buildBody(
    BuildContext context, {
    required String appLocale,
  }) {
    return BaseBodyScaffold(
      title: context.translate(LocalizationKeys.settings),
      onBackTap: () {
        Navigator.pop(context);
      },
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // HospitalNameContainer(
          //   hospitalName: "Qasr El Aini Hospital",
          //   hospitalLocation: "Cairo",
          // ),
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
                _languageItemWidget(
                  appLocale: appLocale,
                  language: 'English',
                  locale: 'en',
                  onTap: _englishItemOnTap,
                ),

                _languageItemWidget(
                  appLocale: appLocale,
                  language: 'عربي',
                  locale: 'ar',
                  onTap: _arabicItemOnTap,
                ),
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

  Widget _languageItemWidget({
    required String appLocale,
    required String language,
    required void Function() onTap,
    required String locale,
  }) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 7.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              language,
              style: context.textTheme.headlineMedium!.copyWith(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            appLocale == locale
                ? const Icon(
                    Icons.check_box,
                    size: 26,
                    color: AppColors.blackText,
                  )
                : const Icon(
                    Icons.check_box_outline_blank,
                    size: 26,
                    color: AppColors.blackText,
                  ),
          ],
        ),
      ),
    );
  }

  ///////////////////////////////////////////////////////////
  /////////////////// Helper Method ////////////////////////
  ///////////////////////////////////////////////////////////
  void _arabicItemOnTap() {
    //  _selectArabicLanguageEvent();
    _changeToArabicEvent();
  }

  void _englishItemOnTap() {
    _changeToEnglishEvent();
  }

  void _changeToEnglishEvent() {
    BlocProvider.of<LocaleCubit>(context).changeLocale(LocaleApp.en);
  }

  void _changeToArabicEvent() {
    BlocProvider.of<LocaleCubit>(context).changeLocale(LocaleApp.ar);
  }

  Future<void> _logoutConfirmation() {
    return showAppDialog(
      context: context,
      dialogWidget: LogOutConfirmationDialogScreen(),
      shouldPopCallback: () {
        return true;
      },
    );
  }
}
