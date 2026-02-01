import 'package:flutter/material.dart';

class QuickActionItem {
  final String text;
  final Color backgroundColor;
  final VoidCallback onTap;

  const QuickActionItem({
    required this.text,
    required this.backgroundColor,
    required this.onTap,
  });
}
