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
  });

  final String title;
  final bool divider;
  final bool isImportant;
  final String subTitle;
  final TextStyle? titleStyle;
  final TextStyle? subTitleStyle;
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
                          ? AppColors.importantText
                          : AppColors.textColor,
                    ),
              ),
            ),
          ],
        ),
        divider
            ? CustomDividerWidget(indent: 24.w, endIndent: 24.w)
            : SizedBox.shrink(),
      ],
    );

    // Column(
    //   children: [
    //     Row(
    //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //       children: [
    //         Text(
    //           title,
    //           style: context.textTheme.labelMedium!.copyWith(
    //             color: AppColors.grayText,
    //           ),
    //         ),
    //         Spacer(flex: 1),
    //         Expanded(
    //           child: Text(
    //             subTitle,
    //             textAlign: TextAlign.center,
    //             softWrap: true,
    //             overflow: TextOverflow.visible,
    //             style: context.textTheme.bodyMedium!.copyWith(
    //               fontWeight: FontWeight.w600,
    //               color: isImportant
    //                   ? AppColors.importantText
    //                   : AppColors.textColor,
    //             ),
    //           ),
    //         ),
    //       ],
    //     ),
    //     divider
    //         ? CustomDividerWidget(indent: 24.w, endIndent: 24.w)
    //         : SizedBox.shrink(),
    //   ],
    // );
  }
}
