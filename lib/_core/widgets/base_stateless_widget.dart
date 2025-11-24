import 'package:flutter/material.dart';
import 'package:organ_link/_core/platform_manager.dart';

abstract class BaseStatelessWidget extends StatelessWidget
    with PlatformManager {
  const BaseStatelessWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return baseBuild(context);
  }

  Widget baseBuild(BuildContext context);
}
