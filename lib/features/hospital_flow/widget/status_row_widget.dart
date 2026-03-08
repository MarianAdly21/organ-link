import 'package:flutter/cupertino.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:organ_link/_core/widgets/base_stateless_widget.dart';
import 'package:organ_link/features/hospital_flow/enum/patient_or_donor_status.dart';
import 'package:organ_link/features/hospital_flow/extension/patient_or_donor_status_ui.dart';
import 'package:organ_link/features/hospital_flow/widget/container_with_background.dart';

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
          backgroundColor: mapPatientOrDonorStatus(priority).badgeBackground,
          textColor: mapPatientOrDonorStatus(priority).textColor,
          text: priority,
        ),
        SizedBox(width: 16.w),
        ContainerWithBackground(
          backgroundColor: mapPatientOrDonorStatus(status).badgeBackground,
          textColor: mapPatientOrDonorStatus(status).textColor,
          text:status,
        ),
      ],
    );
  }
}
