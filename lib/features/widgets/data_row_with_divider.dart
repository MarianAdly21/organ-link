import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/features/widgets/custom_divider_widget.dart';
import 'package:organ_link/res/app_colors.dart';

class DataRowWithDivider extends StatelessWidget {
  const DataRowWithDivider({
    super.key,
    required this.title,
    required this.subTitle,
    this.divider = false,
    this.isImportant = false,
    this.subTitleStyle,
    this.titleStyle,
    this.dividerColor,
    this.importantTextColor,
  });

  final String title;
  final bool divider;
  final bool isImportant;
  final String subTitle;
  final TextStyle? titleStyle;
  final TextStyle? subTitleStyle;
  final Color? dividerColor;
  final Color? importantTextColor;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style:
                  titleStyle ??
                  context.textTheme.labelMedium!.copyWith(
                    color: AppColors.grayText,
                  ),
            ),
            SizedBox(width: 48.w),
            Expanded(
              child: Text(
                subTitle,
                textAlign: TextAlign.end,
                softWrap: true,
                overflow: TextOverflow.visible,
                style:
                    subTitleStyle ??
                    context.textTheme.bodyMedium!.copyWith(
                      fontWeight: FontWeight.w600,
                      color: isImportant
                          ?importantTextColor?? AppColors.importantText
                          : AppColors.textColor,
                    ),
              ),
            ),
          ],
        ),
        divider
            ? CustomDividerWidget(indent: 24.w, endIndent: 24.w ,color: dividerColor,)
            : SizedBox.shrink(),
      ],
    );
  }
}
