import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/_core/widgets/base_dialog_widget.dart';
import 'package:organ_link/features/widgets/app_buttons/app_button_with_gradient_colors.dart';
import 'package:organ_link/res/app_asset_paths.dart';
import 'package:organ_link/utils/locale/app_localization_keys.dart';

class UploadReportConfirmationDialogScreen extends BaseDialogWidget {
  const UploadReportConfirmationDialogScreen({super.key});

  @override
  BaseDialogState<BaseDialogWidget> baseDialogCreateState() =>
      _LogoutConfirmationDialogScreenState();
}

class _LogoutConfirmationDialogScreenState
    extends BaseDialogState<UploadReportConfirmationDialogScreen> {
  @override
  Widget baseDialogBuild(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(AppAssetPaths.doneImage),
        Padding(
          padding: EdgeInsets.only(top: 32.h, bottom: 24.h),
          child: FittedBox(
            child: Text(
              context.translate(LocalizationKeys.reportUploadedSuccess),
              maxLines: 1,
              style: context.textTheme.bodyLarge!.copyWith(
                fontSize: 24,

                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),

        AppButtonWithGradientColors(
          onTap: () {
            Navigator.pop(context,true);
            Navigator.pop(context,true);
          },
          text: context.translate(LocalizationKeys.goHome),
        ),
      ],
    );
  }
}
