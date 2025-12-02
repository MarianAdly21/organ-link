import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/features/widgets/app_buttons/app_button_with_gradient_colors.dart';
import 'package:organ_link/features/widgets/container_with_shadow.dart';

class DataSection extends StatelessWidget {
  const DataSection({
    super.key,
    this.height,
    required this.title,
    required this.body,
    this.titleOfButton,
    this.onTap,
    this.paddingAroundContainer
  });

  final double? height;
  final String title;
  final Widget body;
  final String? titleOfButton;
  final void Function()? onTap;
 final EdgeInsetsGeometry? paddingAroundContainer;

  @override
  Widget build(BuildContext context) {
    return ContainerWithShadow(
      height: height,
      padding: paddingAroundContainer,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 24, horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: context.textTheme.bodyLarge),
            SizedBox(height: 16.h),
            body,
            if (titleOfButton != null) ...[
              SizedBox(height: 24.h),
              AppButtonWithGradientColors(text: titleOfButton!, onTap: onTap),
            ],
          ],
        ),
      ),
    );
  }
}
