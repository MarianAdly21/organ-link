import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organ_link/_core/extensions/screen_sizer_extension.dart';
import 'package:organ_link/res/app_colors.dart';

class AppBaseProgress extends StatelessWidget {
  const AppBaseProgress({super.key, required this.body, this.radius});
  final Widget body;
  final double? radius;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: 24.h, top: 8.h, left: 2.w, right: 2.w),
      child: Container(
        width: context.width,
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        decoration: BoxDecoration(
          color: AppColors.progressContainerBG.withValues(alpha: 0),
          borderRadius: BorderRadius.circular(radius ?? 42),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.25),
              blurRadius: 4,
              blurStyle: BlurStyle.outer,
            ),
          ],
        ),
        child: body,
      ),
    );
  }
}
