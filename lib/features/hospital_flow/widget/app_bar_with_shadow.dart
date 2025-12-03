import 'package:flutter/material.dart';
import 'package:organ_link/res/app_colors.dart';

class AppBarWithShadow extends StatelessWidget {
  const AppBarWithShadow({super.key, required this.child});
final Widget child;
  @override
  Widget build(BuildContext context) {
    return Container(
      //height: 91.h,
      decoration: BoxDecoration(
        color: AppColors.hospitalAppBarBG,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.25),
            blurRadius: 8,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child:child);
  }
}