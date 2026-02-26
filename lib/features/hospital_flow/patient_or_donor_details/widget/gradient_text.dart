import 'package:flutter/material.dart';
import 'package:organ_link/res/app_colors.dart';

class GradientText extends StatelessWidget {
  const GradientText({super.key, required this.text});

  final String text;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      blendMode: BlendMode.srcIn,
      shaderCallback: (bounds) => LinearGradient(colors: [
        AppColors.mainColor,
        AppColors.seconderColor
      ])
      .createShader(
        Rect.fromLTWH(0, 0, bounds.width, bounds.height),
      ),
      child: Text(text, style:TextStyle(fontSize: 16,fontWeight: FontWeight.w700)),
    );
  }
}
