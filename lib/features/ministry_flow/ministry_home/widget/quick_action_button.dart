import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/features/ministry_flow/ministry_home/models/quick_action_item.dart';
import 'package:organ_link/features/widgets/app_buttons/app_elevated_button.dart';
import 'package:organ_link/res/app_colors.dart';

class QuickActionButton extends StatelessWidget {
  final QuickActionItem item;

  const QuickActionButton({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return AppElevatedButton(
      onPressed: item.onTap,
      color: item.backgroundColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.r)),
      padding: EdgeInsets.symmetric(vertical: 16.h, horizontal: 8.w),
      label: FittedBox(
        fit: BoxFit.scaleDown,
        child: Text(
          context.translate(item.text),
          style: context.textTheme.bodyMedium!.copyWith(
            color: AppColors.hospitalBtnText,
          ),
        ),
      ),
    );
  }
}
