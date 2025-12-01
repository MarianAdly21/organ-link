import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/_core/widgets/base_stateless_widget.dart';
import 'package:organ_link/features/widgets/app_buttons/app_buttons.dart';
import 'package:organ_link/res/app_colors.dart';

class LogOutWidget extends BaseStatelessWidget {
  const LogOutWidget({super.key, required this.text, this.onPressed});
  final String text;
  final void Function()? onPressed;

  @override
  Widget baseBuild(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 2.w),
      child: Container(
        //height: 96.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.backgroundForLogoutContainer,
          boxShadow: [
            BoxShadow(color: AppColors.shadowForLogoutContainer, blurRadius: 2),
          ],
        ),
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 24.h, horizontal: 16.w),
          child: AppElevatedButton(
            onPressed: onPressed,
            padding: EdgeInsets.symmetric(vertical: 16.h),
            label: Text(
              text,
              style: context.textTheme.bodyMedium!.copyWith(
                color: Colors.white,
              ),
            ),
            color: AppColors.backgroundForLogoutButton,
          ),
        ),
      ),
    );
  }
}
