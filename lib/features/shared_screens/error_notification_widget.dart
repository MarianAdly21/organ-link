import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/features/widgets/app_buttons/app_button_with_gradient_colors.dart';
import 'package:organ_link/features/widgets/app_buttons/app_elevated_button.dart';
import 'package:organ_link/res/app_asset_paths.dart';
import 'package:organ_link/res/app_colors.dart';
import 'package:organ_link/utils/locale/app_localization_keys.dart';

class ErrorNotificationWidget extends StatelessWidget {
  const ErrorNotificationWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.only(top: 24.h, bottom: 32.h),
              child: Image.asset(
                height: 220.h,
                AppAssetPaths.errorNotificationImage,
              ),
            ),
            Text(
              textAlign: TextAlign.center,
              context.translate(LocalizationKeys.errorOccurred),
              style: context.textTheme.bodyLarge!.copyWith(
                color: AppColors.errorText,
              ),
            ),
            SizedBox(height: 160.h),
            AppButtonWithGradientColors(
              text: context.translate(LocalizationKeys.retry),
              onTap: () {},
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 24.h),
              child: AppElevatedButton.withTitle(
                title: context.translate(LocalizationKeys.goBack),

                padding: EdgeInsets.symmetric(vertical: 16.h),
                shape: RoundedRectangleBorder(
                  side: BorderSide(color: AppColors.backButtonBorder),
                  borderRadius: BorderRadius.circular(16.r),
                ),
                textColor: AppColors.blackText,
                color: AppColors.backButtonBG,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
