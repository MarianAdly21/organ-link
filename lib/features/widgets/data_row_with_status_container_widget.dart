import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organ_link/_core/extensions/extension_localization.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/features/hospital_flow/widget/container_with_background.dart';
import 'package:organ_link/features/widgets/custom_divider_widget.dart';
import 'package:organ_link/res/app_colors.dart';

class DataRowWithStatusContianerWidget extends StatelessWidget {
  const DataRowWithStatusContianerWidget({
    super.key,
    required this.title,
    required this.subTitle,
    required this.backgroundColor,
    this.subTitleColor,
    this.divider = false,
  });
  final String title;

  final String subTitle;
  final Color? subTitleColor;
  final Color backgroundColor;
  final bool divider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              context.translate(title),
              style: context.textTheme.labelMedium!.copyWith(
                color: AppColors.grayText,
              ),
            ),
            ContainerWithBackground(
              backgroundColor: backgroundColor,
              text: subTitle,
              textColor: subTitleColor,
            ),
          ],
        ),
        divider
            ? CustomDividerWidget(indent: 24.w, endIndent: 24.w)
            : SizedBox.shrink(),
      ],
    );
  }
}
