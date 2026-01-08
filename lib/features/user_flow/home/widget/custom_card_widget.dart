import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/features/user_flow/home/model/card_ui_model.dart';
import 'package:organ_link/res/app_colors.dart';

class CustomCardWidget extends StatelessWidget {
  const CustomCardWidget({super.key, required this.cardUiModel});
  final CardUiModel cardUiModel;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: cardUiModel.onTap,
      child: Container(
        // height: 116.h,
        //  width: 164.w,
        padding: EdgeInsets.symmetric(vertical: 18.h, horizontal: 14.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              blurStyle: BlurStyle.outer,
              blurRadius: 8,
              color: Colors.black.withValues(alpha: 0.15),
            ),
          ],
          color: AppColors.homeCardBG.withValues(alpha: 0.45),
        ),
        child: FittedBox(
          fit: BoxFit.scaleDown,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              SvgPicture.asset(width: 32.w, height: 32.h, cardUiModel.icon),
              SizedBox(height: 16.h),
              Text(
                context.translate(cardUiModel.title),
                style: context.textTheme.labelMedium!.copyWith(
                  fontWeight: FontWeight.w600,
                  color: AppColors.blackText,
                  fontSize: 14.sp,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                // maxLines: 1,
                // overflow: TextOverflow.visible,
                textAlign: TextAlign.center,
               context.translate( cardUiModel.subTitle),
                style: context.textTheme.labelMedium!.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: 13.sp,
                  color: AppColors.grayText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
