import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organ_link/res/app_colors.dart';

class ContainerWithBlackShadow extends StatelessWidget {
  const ContainerWithBlackShadow({
    super.key,
    required this.body,
    this.borderRadius,
    this.contentyPadding,
    this.height,
    this.padding,
  });
  final Widget body;
  final double? borderRadius;
  final double? height;
  final EdgeInsetsGeometry? contentyPadding;
  final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.all(0),
      child: Container(
        //  height: height ?? 132.h,
        padding:
            contentyPadding ??
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
          color: AppColors.homeCardBG.withValues(alpha: 0.45),
        ),
        child: body,
      ),
    );
  }
}
