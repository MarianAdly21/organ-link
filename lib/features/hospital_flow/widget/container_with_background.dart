import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organ_link/_core/widgets/base_stateless_widget.dart';
import 'package:organ_link/res/app_colors.dart';

class ContainerWithBackground extends BaseStatelessWidget {
  const ContainerWithBackground({
    super.key,
    this.textColor,
    required this.backgroundColor,
    required this.text,
    this.isCentered = false,
    this.contentPadding,
    this.textStyle,
    this.border,
    this.height,
    this.width,
    this.borderRadius,
  });
  final Color? textColor;
  final Color backgroundColor;
  final String text;
  final bool isCentered;
  final EdgeInsetsGeometry? contentPadding;
  final TextStyle? textStyle;
  final BoxBorder? border;
  final double? height;
  final double? width;
  final double? borderRadius;

  @override
  Widget baseBuild(BuildContext context) {
    return Container(
      height: height,
      width: width,
      padding:
          contentPadding ??
          EdgeInsets.symmetric(vertical: 4.h, horizontal: 8.w),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(borderRadius?? 12),
        border: border,
        color: backgroundColor,
      ),
      child: Text(
        textAlign: isCentered ? TextAlign.center : null,
        text,
        style:
            textStyle ??
            TextStyle(
              color: textColor ?? AppColors.grayText,
              fontSize: 13,
              fontWeight: FontWeight.w400,
            ),
      ),
    );
  }
}
