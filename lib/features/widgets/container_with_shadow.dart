import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organ_link/res/app_colors.dart';

class ContainerWithShadow extends StatelessWidget {
  const ContainerWithShadow({super.key, required this.child});
 final Widget child;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24.h),
      child: Container(
        // height: 230.h,
        //width: 343.w,
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
        child:child  ),
    );
    
  }
}