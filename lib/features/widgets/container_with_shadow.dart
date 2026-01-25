import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
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
    this.sectionTitle,
  });
  final Widget child;
  final double? height;
  final double? width;
  final double? borderRadius;
  final Color? background;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? contentPadding;
  final Color? borderSideColor;
  final String? sectionTitle;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.symmetric(vertical: 24.h, horizontal: 2.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if(sectionTitle!=null)...[
              Text(
          sectionTitle!,
          style: context.textTheme.bodyMedium!.copyWith(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: AppColors.blackText,
          ),
        ),
        SizedBox(height: 16.h),
          ],
          Container(
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
        ],
      ),
    );
  }
}
