import 'package:flutter/material.dart';
import 'package:organ_link/_core/loading_manager.dart';
import 'package:organ_link/_core/widgets/base_stateful_widget.dart';

abstract class BaseStatefulScreenWidget extends BaseStatefulWidget {
  const BaseStatefulScreenWidget({super.key});

  @override
  BaseScreenState baseCreateState() => baseScreenCreateState();

  BaseScreenState baseScreenCreateState();
}

abstract class BaseScreenState<W extends BaseStatefulScreenWidget>
    extends BaseState<W>
    with LoadingManager {
  @override
  Widget baseBuild(BuildContext context) {
    return Material(
      child: Stack(
        fit: StackFit.expand,
        children: [baseScreenBuild(context), loadingManagerWidget()],
      ),
    );
  }

  void changeState() {
    setState(() {});
  }

  @override
  void runChangeState() {
    changeState();
  }

  Widget baseScreenBuild(BuildContext context);
}
