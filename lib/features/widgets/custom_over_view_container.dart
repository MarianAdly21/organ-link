import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/res/app_colors.dart';

class CustomOverViewContainer extends StatelessWidget {
  const CustomOverViewContainer({
    super.key,
    required this.text,
    required this.count,
    this.backgroundColor,
    this.isGradient = false,
    this.height,
    this.width,
  });

  final String text;
  final String count;
  final Color? backgroundColor;
  final bool isGradient;
  final double? height;
  final double? width;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height ?? 80.h,
      width: width ?? 74.w,
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 14.w),
      decoration: BoxDecoration(
        gradient: isGradient
            ? LinearGradient(
                colors: [
                  AppColors.mainColor.withValues(alpha: 0.43),
                  AppColors.seconderColor.withValues(alpha: 0.43),
                ],
              )
            : null,
        color: isGradient
            ? null
            : backgroundColor ?? AppColors.overViewContainerBG,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            text,
            textAlign: TextAlign.center,
            style: context.textTheme.labelMedium!.copyWith(
              fontWeight: FontWeight.w400,
              fontSize: 13,
            ),
          ),
          SizedBox(height: 8.h),
          Flexible(child: Text(count, style: context.textTheme.bodyMedium)),
        ],
      ),
    );
  }
}
