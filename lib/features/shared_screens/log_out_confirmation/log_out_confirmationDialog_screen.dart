import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/_core/widgets/base_dialog_widget.dart';
import 'package:organ_link/features/widgets/app_buttons/app_elevated_button.dart';
import 'package:organ_link/res/app_colors.dart';
import 'package:organ_link/utils/locale/app_localization_keys.dart';

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
        padding: EdgeInsets.symmetric(vertical: 16.h),
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
