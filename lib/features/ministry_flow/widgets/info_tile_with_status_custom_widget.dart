import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/features/hospital_flow/widget/container_with_background.dart';
import 'package:organ_link/res/app_colors.dart';

class InfoTileWithStatusCustomWidget extends StatelessWidget {
  const InfoTileWithStatusCustomWidget({
    super.key,
    required this.title,
    required this.subtitle,
    required this.status,
    this.textColor,
    this.textStatusColor,
    this.statusBGColor,
  });

  final String title;
  final String subtitle;
  final String status;
  final Color? textColor;
  final Color? textStatusColor;
  final Color? statusBGColor;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Padding(
            padding: EdgeInsetsDirectional.only(end: 12.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: context.textTheme.bodyMedium!.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: textColor ?? AppColors.blackText,
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 8.h),
                  child: Text(
                    subtitle,
                    style: context.textTheme.labelMedium!.copyWith(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        ContainerWithBackground(
          backgroundColor: statusBGColor ?? AppColors.readyTextBG,
          text: status,
          textColor: textStatusColor,
        ),
      ],
    );
  }
}
