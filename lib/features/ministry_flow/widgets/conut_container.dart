import 'package:flutter/material.dart';
import 'package:organ_link/_core/extensions/extension_theme.dart';
import 'package:organ_link/features/widgets/container_with_black_shadow.dart';

class ConutContainer extends StatelessWidget {
  const ConutContainer({
    super.key,
    required this.title,
    required this.count,
    this.padding,
  });

  final String title;
  final String count;
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ContainerWithBlackShadow(
        padding: padding,
        body: Column(
          children: [
            Text(
              title,
              style: context.textTheme.labelMedium!.copyWith(
                color: Color(0xff575757),
                fontSize: 13,
                fontWeight: FontWeight.w400,
              ),
            ),
            Text(
              overflow: TextOverflow.visible,
              maxLines: 1,
              count,
              style: context.textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }
}
