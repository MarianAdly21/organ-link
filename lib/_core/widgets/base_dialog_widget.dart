import 'package:flutter/material.dart';
import 'package:organ_link/_core/extensions/screen_sizer_extension.dart';
import 'package:organ_link/_core/widgets/base_stateful_widget.dart';
import 'package:organ_link/res/app_colors.dart';

Future<void> showAppDialog({
  required BuildContext context,
  required BaseDialogWidget dialogWidget,
  required bool Function() shouldPopCallback,
}) async {
  await showDialog(
    context: context,
    barrierDismissible: false,
    useRootNavigator: false,
    builder: (context) {
      return PopScope(
        canPop: shouldPopCallback(),
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          insetPadding: const EdgeInsets.all(15),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 0,
            vertical: 0,
          ),
          content: dialogWidget,
        ),
      );
    },
  );
}

abstract class BaseDialogWidget extends BaseStatefulWidget {
  const BaseDialogWidget({super.key});

  @override
  BaseDialogState baseCreateState() => baseDialogCreateState();

  BaseDialogState baseDialogCreateState();
}

abstract class BaseDialogState<W extends BaseDialogWidget>
    extends BaseState<W> {
  @override
  Widget baseBuild(BuildContext context) {
    return SizedBox(
      width: context.width,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          _closeIconWidget(),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 35),
            child: baseDialogBuild(context),
          ),
        ],
      ),
    );
  }

  void changeState() {
    setState(() {});
  }

  Widget baseDialogBuild(BuildContext context);

  ///////////////////////////////////////////////////////////
  //////////////////// Widget methods ///////////////////////
  ///////////////////////////////////////////////////////////

  Widget _closeIconWidget() {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: InkWell(
        onTap: () {
          closeDialog();
        },
        child: const Icon(
          Icons.close,
          size: 25,
          color: AppColors.closeDialogIcon,
        ),
      ),
    );
  }

  ///////////////////////////////////////////////////////////
  /////////////////// Helper methods ////////////////////////
  ///////////////////////////////////////////////////////////

  void closeDialog() {
    Navigator.of(context).pop();
  }
}
