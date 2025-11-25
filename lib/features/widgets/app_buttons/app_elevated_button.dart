import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organ_link/features/widgets/app_buttons/common_widgets.dart';
import 'package:organ_link/res/app_colors.dart';

class AppElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget label;
  final Color? color;
  final EdgeInsets? padding;
  final OutlinedBorder? shape;

  const AppElevatedButton({
    super.key,
    required this.onPressed,
    required this.label,
    this.color,
    this.padding,
    this.shape,
  });

  factory AppElevatedButton.withTitle({
    Key? key,
    VoidCallback? onPressed,
    EdgeInsets? padding,
    Color? textColor,
    Color? color,
    required String title,
  }) {
    return AppElevatedButton(
      key: key,
      padding: padding,
      color: color,
      label: labelTextWidget(title, textColor),
      onPressed: onPressed,
    );
  }
  factory AppElevatedButton.whiteWithTitle({
    Key? key,
    VoidCallback? onPressed,
    required String title,
  }) {
    return AppElevatedButton(
      key: key,
      label: labelTextWidget(title, AppColors.appButtonBlueText),
      color: AppColors.appButtonWhiteBackground,
      onPressed: onPressed,
    );
  }

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        padding: padding ?? commonPadding,
        shape:
            shape ??
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16.r)),
        backgroundColor: color,
      ),
      onPressed: onPressed,
      child: label,
    );
  }
}
