import 'package:flutter/material.dart';
import 'package:organ_link/features/hospital_flow/enum/operation_status.dart';

extension OperationStatusUI on OperationStatus {
  Color get sideColor {
    switch (this) {
      case OperationStatus.scheduled:
        return Color(0xff870099);
      case OperationStatus.successful:
        return Color(0xff008736);
      case OperationStatus.ongoing:
        return Color(0xff005FAB);
      case OperationStatus.underObservation:
        return Color(0xffFF9800);
    }
  }

  Color get badgeBackground {
    return sideColor.withValues(alpha: 0.15);
  }

  Color get textColor {
    return sideColor;
  }
}
