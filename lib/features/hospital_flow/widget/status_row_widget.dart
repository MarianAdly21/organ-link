import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organ_link/_core/widgets/base_stateless_widget.dart';
import 'package:organ_link/features/hospital_flow/view_patient/helper_method/get_priority.dart';
import 'package:organ_link/features/hospital_flow/view_patient/helper_method/get_status.dart';
import 'package:organ_link/features/hospital_flow/widget/container_with_background.dart';
import 'package:organ_link/res/app_colors.dart';

class StatusRowWidget extends BaseStatelessWidget {
  const StatusRowWidget({
    super.key,
    required this.priority,
    required this.status,
  });
  final String priority;
  final String status;

  @override
  Widget baseBuild(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        ContainerWithBackground(
          backgroundColor: getPriority(priority).backgroundColor,
          textColor: getPriority(priority).textColor,
          text: getPriority(priority).priority,
        ),
        SizedBox(width: 16.w),
        ContainerWithBackground(
          backgroundColor: getStatus(status).backgroundColor,
          textColor: getStatus(status).textColor,
          text: getStatus(status).status,
        ),
      ],
    );
  }
}
