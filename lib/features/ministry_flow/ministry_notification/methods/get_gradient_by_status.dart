import 'dart:ui';

import 'package:organ_link/features/hospital_flow/enum/ministry_notification_type.dart';
import 'package:organ_link/res/app_colors.dart';

List<Color> getGradientByStatus(MinistryNotificationType status) {
  switch (status) {
    case MinistryNotificationType.resolved:
      return [
        AppColors.resolveStatusContainerBGMinistryAlert,
        AppColors.resolveStatusContainerBGMinistryAlert,
      ];
    case MinistryNotificationType.danger:
    case MinistryNotificationType.critical:
      return [
        AppColors.dangerStatusContainerBGMinistryAlert1,
        AppColors.dangerStatusContainerBGMinistryAlert2,
      ];
    case MinistryNotificationType.warning:
      return [
        AppColors.warningStatusContainerBGMinistryAlert1,
        AppColors.warningStatusContainerBGMinistryAlert2,
      ];
  }
}
