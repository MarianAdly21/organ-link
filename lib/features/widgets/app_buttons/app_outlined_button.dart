import 'package:flutter/material.dart';
import 'package:organ_link/features/widgets/app_buttons/common_widgets.dart';

class AppOutlinedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final Color? borderColor;

  final EdgeInsets? padding;

  const AppOutlinedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.padding,
    this.borderColor,
  });

  factory AppOutlinedButton.withTitle({
    Key? key,
    VoidCallback? onPressed,
    EdgeInsets? padding,
    Color? textColor,
    Color? borderColor,
    required String title,
  }) {
    return AppOutlinedButton(
      key: key,
      onPressed: onPressed,
      borderColor: borderColor,
      padding: padding,
      child: labelTextWidget(title, textColor),
    );
  }
  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      style: OutlinedButton.styleFrom(
        elevation: 0,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        side: BorderSide(color: borderColor ?? Theme.of(context).primaryColor),
        padding: padding ?? commonPadding,
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
