import 'package:flutter/material.dart';
import 'package:organ_link/features/hospital_flow/enum/medical_test_status.dart';
import 'package:organ_link/res/app_colors.dart';

extension MedicalTestStatusUi on MedicalTestStatus {
  Color get textColor {
    switch (this) {
      case MedicalTestStatus.labTests:
      case MedicalTestStatus.completed:
        return AppColors.readyText;
      case MedicalTestStatus.radiology:
      case MedicalTestStatus.inProgress:
        return AppColors.pendingText;
      case MedicalTestStatus.medicalReport:
        return AppColors.notFoundText;
    }
  }

  Color get badgeBackground {
    return textColor.withValues(alpha: 0.15);
  }
}
