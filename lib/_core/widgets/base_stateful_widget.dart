import 'package:flutter/material.dart';
import 'package:organ_link/_core/platform_manager.dart';

abstract class BaseStatefulWidget extends StatefulWidget {
  const BaseStatefulWidget({super.key});

  @override
  // ignore: no_logic_in_create_state
  BaseState createState() => baseCreateState();

  BaseState baseCreateState();
}

abstract class BaseState<W extends BaseStatefulWidget> extends State<W>
    with PlatformManager {
  @override
  Widget build(BuildContext context) {
    return baseBuild(context);
  }

  Widget baseBuild(BuildContext context);
}
