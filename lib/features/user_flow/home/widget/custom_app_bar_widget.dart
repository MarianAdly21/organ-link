import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/res/app_asset_paths.dart';
import 'package:organ_link/res/app_colors.dart';

class CustomAppBarWidget extends StatelessWidget {
  const CustomAppBarWidget({super.key, required this.title, required this.onTap});
  final String title;
  final void Function() onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: onTap,
          child: SvgPicture.asset(AppAssetPaths.arrowBackIcon),
        ),
        SizedBox(width: 63),
        Text(
          title,
          style: context.textTheme.bodyLarge!.copyWith(
            color: AppColors.blackText,
          ),
        ),
      ],
    );

  }
}
