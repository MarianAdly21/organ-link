import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/res/app_colors.dart';

class NoticeContainer extends StatelessWidget {
  const NoticeContainer({super.key, required this.notice, this.height});
  final String notice;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.only(end: 6),
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 16, horizontal: 26),
        height: height ?? 75.h,
        // width: 311.w,
        decoration: BoxDecoration(
          color: AppColors.medicalTestContainerBG,
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: [
              AppColors.hospitalInfoColorBG2,
              AppColors.hospitalInfoColorBG1,
            ],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.hospitalInfoShadow,
              offset: Offset(4, 0),
            ),
          ],
        ),
        child: Center(
          child: Text(
            textAlign: TextAlign.center,
            context.translate(notice),
            style: context.textTheme.displayMedium!.copyWith(
              fontSize: 16,
              color: AppColors.hospitalInfoText,
            ),
          ),
        ),
      ),
    );
  }
}
