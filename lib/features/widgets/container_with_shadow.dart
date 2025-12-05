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
    this.contentPadding
  });
  final Widget child;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? padding;
 final EdgeInsetsGeometry? contentPadding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:padding?? EdgeInsets.symmetric(vertical: 24.h),
      child: Container(
        height: height,
        width: width,
        padding:contentPadding ,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.shadowForContainerInfo.withValues(alpha: 0.25),
              blurRadius: 4,
            ),
          ],
          borderRadius: BorderRadius.circular(16.r),
          color: AppColors.containerColor,
        ),
        child: child,
      ),
    );
  }
}
