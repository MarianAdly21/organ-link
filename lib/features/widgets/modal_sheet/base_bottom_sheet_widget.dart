import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organ_link/_core/widgets/base_stateless_widget.dart';
import 'package:organ_link/res/app_colors.dart';

//ignore:must_be_immutable
class BaseBottomSheetWidget extends BaseStatelessWidget {
  const BaseBottomSheetWidget({
    super.key,
    required this.child,
    this.onCloseCallBack,
  });
  final Widget child;
  final VoidCallback? onCloseCallBack;

  @override
  Widget baseBuild(BuildContext context) {
    return Card(
      margin: EdgeInsets.zero,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 20.h),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                color: AppColors.changePasswordSuccessModalDivider,
                height: 3.h,
                width: 75.w,
              ),
              SizedBox(height: 3.h),
              Align(
                alignment: AlignmentDirectional.centerEnd,
                child: InkWell(
                  onTap: () => _closeClicked(context),
                  child: const Icon(
                    Icons.close,
                    size: 24,
                    weight: 300,
                    color: AppColors.changePasswordSuccessModalCloseIcon,
                  ),
                ),
              ),
              child,
            ],
          ),
        ),
      ),
    );
  }

  void _closeClicked(BuildContext context) {
    Navigator.of(context).pop();
    if (onCloseCallBack != null) {
      onCloseCallBack!();
    }
  }
}
