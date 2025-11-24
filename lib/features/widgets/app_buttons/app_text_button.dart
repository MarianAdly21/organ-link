import 'package:flutter/material.dart';
import 'package:organ_link/features/widgets/app_buttons/common_widgets.dart';

class AppTextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;

  final EdgeInsetsGeometry? padding;

  const AppTextButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.padding,
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
        elevation: 0,
        padding: padding ?? EdgeInsets.zero,
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
