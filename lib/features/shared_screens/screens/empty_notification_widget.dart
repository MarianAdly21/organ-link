import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/res/app_asset_paths.dart';
import 'package:organ_link/utils/locale/app_localization_keys.dart';

class EmptyNotificationScreen extends StatelessWidget {
  const EmptyNotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 24.h, bottom: 48.h),
          child: SvgPicture.asset(AppAssetPaths.noNotificationImage),
        ),
        Text(
          context.translate(LocalizationKeys.emptyPageMessage),
          style: context.textTheme.bodyLarge,
        ),
      ],
    );
  }
}
