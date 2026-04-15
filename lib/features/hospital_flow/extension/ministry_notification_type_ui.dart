import 'package:flutter/material.dart';
import 'package:organ_link/features/hospital_flow/enum/ministry_notification_type.dart';
import 'package:organ_link/res/app_colors.dart';

extension MinistryNotificationStatusUi on MinistryNotificationType {
  Color get backgroundColor {
    switch (this) {
      case MinistryNotificationType.danger:
        return AppColors.dangerStatusBGMinistryAlert;
      case MinistryNotificationType.warning:
        return AppColors.warningStatusBGMinistryAlert;
      case MinistryNotificationType.resolved:
        return AppColors.resolveStatusBGMinistryAlert;
      case MinistryNotificationType.critical:
        return AppColors.dangerStatusBGMinistryAlert;
    }
  }
}
