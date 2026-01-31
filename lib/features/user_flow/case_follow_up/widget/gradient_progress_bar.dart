import 'package:flutter/material.dart';
import 'package:organ_link/_core/extensions/screen_sizer_extension.dart';
import 'package:organ_link/res/app_colors.dart';

class GradientProgressBar extends StatelessWidget {
  final double value;
  final double? width;

  const GradientProgressBar({super.key, required this.value, this.width});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(6),
      child: Container(
        width: width ?? context.width,
        height: 8,
        decoration: BoxDecoration(color: AppColors.progressBarBG),
        child: FractionallySizedBox(
          alignment: Alignment.centerLeft,
          widthFactor: value,
          child: Container(
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.mainColor, AppColors.seconderColor],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
