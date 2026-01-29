import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/res/app_asset_paths.dart';
import 'package:organ_link/res/app_colors.dart';

class AppSearchCustomWidget extends StatelessWidget {
  const AppSearchCustomWidget({
    super.key,
    required this.hintText,
    required this.onChanged,
  });
  final String hintText;
  final Function(String)? onChanged;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 8,
            offset: Offset(0, 2),
          ),
        ],
      ),
      child: TextField(
        decoration: InputDecoration(
          hintText: context.translate(hintText),
          hintStyle: context.textTheme.labelMedium!.copyWith(
            color: AppColors.grayText,
            fontSize: 13,
            fontWeight: FontWeight.w400,
          ),
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: SvgPicture.asset(AppAssetPaths.searchIcon),
          ),

          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        ),
        onChanged: onChanged,
      ),
    );
  }
}
