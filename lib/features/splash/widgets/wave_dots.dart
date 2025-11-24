import 'dart:math';

import 'package:flutter/material.dart';
import 'package:organ_link/res/app_colors.dart';

class WaveDots extends StatefulWidget {
  const WaveDots({super.key});

  @override
  State<WaveDots> createState() => _WaveDotsState();
}

class _WaveDotsState extends State<WaveDots>
    with SingleTickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> animation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200), 
    )..repeat();

    animation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // width: 80,
      height: 16,
      child: AnimatedBuilder(
        animation: animation,
        builder: (context, child) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildDot(delay: 0),
              _buildDot(delay: 0.2, color: AppColors.mainColor),
              _buildDot(delay: 0.4),
            ],
          );
        },
      ),
    );
  }

  Widget _buildDot({Color? color, required double delay}) {
    double value = (animation.value + delay) % 1;

    double offsetY = sin(value * pi * 2) * 6;

    return Transform.translate(
      offset: Offset(0, offsetY),
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8),
        width: 12,
        height: 12,
        decoration: BoxDecoration(
          color: color ?? AppColors.seconderColor,
          shape: BoxShape.circle,
        ),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }
}
