import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/_core/widgets/base_stateless_widget.dart';
import 'package:organ_link/res/app_colors.dart';

class AppButtonWithGradientColors extends BaseStatelessWidget {
  const AppButtonWithGradientColors({
    super.key,
    required this.text,
    required this.onTap,
    this.borderRadius,
    this.colors,
    this.textColor,
    this.border,
  });
  final String text;
  final void Function()? onTap;
  final double? borderRadius;
  final List<Color>? colors;
  final Color? textColor;
  final BoxBorder? border;

  @override
  Widget baseBuild(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 48.h,
        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 6),
        decoration: BoxDecoration(
          border: border,
          borderRadius: BorderRadius.circular(borderRadius ?? 16),
          gradient: LinearGradient(
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
            colors: colors ?? [AppColors.seconderColor, AppColors.mainColor],
          ),
        ),
        child: Center(
          child: FittedBox(
            child: Text(
              text,
              style: context.textTheme.labelLarge!.copyWith(
                color: textColor ?? AppColors.appButtonText,
                fontWeight: FontWeight.w700,
                fontSize: 16,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
