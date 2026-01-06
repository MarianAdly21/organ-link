import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organ_link/res/app_colors.dart';

class CustomDividerWidget extends StatelessWidget {
  const CustomDividerWidget({
    super.key,
    this.verticalPadding,
    this.endIndent,
    this.indent,
    this.color,
  });
  final double? verticalPadding;
  final double? indent;
  final double? endIndent;
  final Color? color;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: verticalPadding ?? 16.h),
      child: Divider(
        indent: indent,
        endIndent: endIndent,
        thickness: 2,
        color: color ?? AppColors.displayFieldBGColor,
      ),
    );
  }
}
