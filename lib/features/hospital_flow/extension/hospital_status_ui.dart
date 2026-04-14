import 'package:flutter/material.dart';
import 'package:organ_link/features/hospital_flow/enum/hospital_status.dart';
import 'package:organ_link/res/app_colors.dart';

extension HospitalStatusUi on HospitalStatus {
  Color get textColor {
    switch (this) {
      case HospitalStatus.ready:
        return AppColors.readyText;
      case HospitalStatus.underReview:
        return AppColors.pendingText;
    }
  }

  Color get backgroundColor {
    return textColor.withValues(alpha: 0.15);
  }
}
