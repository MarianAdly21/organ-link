import 'package:flutter/material.dart';
import 'package:organ_link/res/app_colors.dart';
import 'package:organ_link/features/widgets/modal_sheet/base_bottom_sheet_widget.dart';

class AppBottomSheet {
  static Future<void> openAppBottomSheet({
    required BuildContext context,
    required Widget child,
    ShapeBorder? shape = const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
    ),
    bool? isScrollControlled,
    bool withPadding = true,
    VoidCallback? onCloseCallBack,
  }) {
    return showModalBottomSheet(
      barrierColor: AppColors.changePasswordSuccessModalBarrier.withValues(
        alpha: 0.8,
      ),
      context: context,
      isScrollControlled: isScrollControlled ?? false,
      shape: shape,
      builder: (context) => Padding(
        padding: withPadding
            ? EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom)
            : EdgeInsets.zero,
        child: BaseBottomSheetWidget(
          onCloseCallBack: onCloseCallBack,
          child: SafeArea(child: child),
        ),
      ),
    );
  }
}
