import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organ_link/res/app_colors.dart';

class HospitalAppBarBase extends StatelessWidget {
  const HospitalAppBarBase({super.key, required this.child});
  final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 96.h,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 16.h),
        margin: EdgeInsets.only(bottom: 5.h),
        decoration: BoxDecoration(
          color: AppColors.hospitalAppBarBG,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.25),
              blurRadius: 8,
              offset: Offset(4, 0),
            ),
          ],
        ),
        child: child,
      ),
    );
  }
}
