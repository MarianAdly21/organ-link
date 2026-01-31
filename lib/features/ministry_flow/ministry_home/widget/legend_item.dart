import 'package:flutter/material.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';

class LegendItem extends StatelessWidget {
  const LegendItem({
    super.key,
    required this.color,
    required this.text,
    this.padding,
  });

  final String text;
  final Color color;
  final EdgeInsetsGeometry? padding;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Text(text, style: context.textTheme.labelMedium),
          SizedBox(width: 8),
          Container(
            width: 16,
            height: 16,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        ],
      ),
    );
  }
}
