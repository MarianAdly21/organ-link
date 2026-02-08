import 'package:flutter/material.dart';
import 'package:organ_link/res/app_colors.dart';

class ContainerWithBlackShadow extends StatelessWidget {
  const ContainerWithBlackShadow({
    super.key,
    required this.body,
    this.borderRadius,
    this.contentPadding,
    this.height,
    this.width,
    this.padding,
    this.backgroundColor,
    this.gradientBackgroundColor,
  });
  final Widget body;
  final double? borderRadius;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? contentPadding;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final List<Color>? gradientBackgroundColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.all(0),
      child: Container(
        height: height,
        width: width,
        padding:
            contentPadding ??
            EdgeInsets.symmetric(vertical: 18, horizontal: 14),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius ?? 16),
          boxShadow: [
            BoxShadow(
              blurStyle: BlurStyle.outer,
              blurRadius: 8,
              color: Colors.black.withValues(alpha: 0.15),
            ),
          ],

          gradient: gradientBackgroundColor != null
              ? LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomRight,
                  colors: gradientBackgroundColor!,
                  stops: const [0.0, 0.92],
                )
              : null,
          color: gradientBackgroundColor == null
              ? (backgroundColor ??
                    AppColors.homeCardBG.withValues(alpha: 0.45))
              : null,
        ),
        child: body,
      ),
    );
  }
}
