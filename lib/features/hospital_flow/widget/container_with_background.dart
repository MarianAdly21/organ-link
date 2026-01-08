import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organ_link/_core/widgets/base_stateless_widget.dart';
import 'package:organ_link/res/app_colors.dart';

class ContainerWithBackground extends BaseStatelessWidget {
  const ContainerWithBackground({super.key, this.textColor, required this.backgroundColor, required this.text});
  final Color? textColor;
  final Color backgroundColor;
  final String text;

  @override
  Widget baseBuild(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: backgroundColor,
      ),
      child: Text(
        text,
        style: TextStyle(
          color: textColor ?? AppColors.grayText,
          fontSize: 13,
          fontWeight: FontWeight.w400,
        ),
      ),
    );
  }
}
