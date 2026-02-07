import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/features/widgets/container_with_shadow.dart';
import 'package:organ_link/res/app_colors.dart';

class HospitalNameContainer extends StatelessWidget {
  const HospitalNameContainer({
    super.key,
    required this.hospitalName,
    required this.hospitalLocation,
  });
  final String hospitalName;
  final String hospitalLocation;

  @override
  Widget build(BuildContext context) {
    return ContainerWithShadow(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(hospitalName, style: context.textTheme.bodyLarge),
            SizedBox(height: 10.h),
            Text(
              hospitalLocation,
              style: context.textTheme.labelMedium!.copyWith(
                color: AppColors.grayText,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
