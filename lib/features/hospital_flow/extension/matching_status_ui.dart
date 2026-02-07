import 'package:flutter/material.dart';
import 'package:organ_link/features/hospital_flow/enum/matching_status.dart';
import 'package:organ_link/res/app_colors.dart';

extension MatchingStatusUi on MatchingStatus {
  Color get textColor {
    switch (this) {
      case MatchingStatus.ready:
        return AppColors.readyText;
      case MatchingStatus.matched:
        return AppColors.textColor;
      case MatchingStatus.pending:
        return AppColors.pendingText;
      case MatchingStatus.notFound:
        return AppColors.notFoundtext;
      case MatchingStatus.underReview:
        return AppColors.pendingText;
    }
  }

  Color get backgroundColor {
    return textColor.withValues(alpha: 0.15);
  }
}
