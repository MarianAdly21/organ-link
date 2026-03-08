import 'dart:ui';

import 'package:organ_link/features/hospital_flow/enum/patient_or_donor_status.dart';
import 'package:organ_link/res/app_colors.dart';

extension PatientOrDonorStatusUi on PatientOrDonorStatus {
  Color get textColor {
    switch (this) {
      case PatientOrDonorStatus.ready:
      case PatientOrDonorStatus.surgeryCompleted:
      case PatientOrDonorStatus.veryGoodHealth:
      case PatientOrDonorStatus.excellentHealth:
      case PatientOrDonorStatus.lowPriority:
        return AppColors.readyText;
      case PatientOrDonorStatus.underMatching:
      case PatientOrDonorStatus.underReview:
      case PatientOrDonorStatus.donationCompleted:
        return AppColors.textColor;
      case PatientOrDonorStatus.goodHealth:
      case PatientOrDonorStatus.mediumPriority:
        return AppColors.pendingText;
         case PatientOrDonorStatus.highPriority:
        return AppColors.notFoundText;
    }
  }


  Color get badgeBackground {
    return textColor.withValues(alpha: 0.15);
  } 
}
