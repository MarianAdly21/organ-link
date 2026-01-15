import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organ_link/res/app_colors.dart';

class ContainerWithShadow extends StatelessWidget {
  const ContainerWithShadow({
    super.key,
    required this.child,
    this.height,
    this.width,
    this.padding,
    this.contentPadding,
    this.background,
    this.borderRadius,
    this.borderSideColor,
  });
  final Widget child;
  final double? height;
  final double? width;
  final double? borderRadius;
  final Color? background;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? contentPadding;
  final Color? borderSideColor;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(vertical: 24.h, horizontal: 2.w),
      child: Container(
        height: height,
        width: width,
        padding: contentPadding,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowForContainerInfo.withValues(alpha: 0.25),
              blurRadius: 4,
            ),
          ],
          border: borderSideColor==null? null:BorderDirectional(
          end: BorderSide(
            width: 6,
            color:borderSideColor!,
            
          ),
        ),
          borderRadius: BorderRadius.circular(borderRadius ?? 16.r),
          color: background ?? AppColors.containerColor,
        ),
        child: child,
      ),
    );
  }
}
