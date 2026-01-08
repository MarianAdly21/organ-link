import 'package:flutter/material.dart';
import 'package:organ_link/features/widgets/app_buttons/common_widgets.dart';
import 'package:organ_link/res/app_colors.dart';

class AppTextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final BorderSide? side;
  final Color? backgroundColor;
  final OutlinedBorder? shape;

  final EdgeInsetsGeometry? padding;

  const AppTextButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.padding,
    this.side,
    this.backgroundColor,
    this.shape,
  });

  factory AppTextButton.withTitle({
    Key? key,
    VoidCallback? onPressed,
    EdgeInsetsGeometry? padding,
    Color? textColor,
    required String title,
  }) {
    return AppTextButton(
      key: key,
      padding: padding,
      onPressed: onPressed,
      child: labelTextWidget(title, textColor),
    );
  }

  @override
  Widget build(BuildContext context) {
    return TextButton(
      style: TextButton.styleFrom(
        overlayColor: AppColors.transparent,
        elevation: 0,
        padding: padding ?? EdgeInsets.zero,
        side: side,
        backgroundColor: backgroundColor,
        shape:
            shape ??
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
