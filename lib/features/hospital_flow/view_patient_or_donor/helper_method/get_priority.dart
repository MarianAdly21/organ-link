import 'package:flutter/material.dart';
import 'package:organ_link/features/hospital_flow/view_patient_or_donor/models/priority_display_model.dart';
import 'package:organ_link/res/app_colors.dart';

PriorityDisplayModel getPriority(String priority) {
  switch (priority) {
    case "أولوية عالية":
      return PriorityDisplayModel(
        priority: "أولوية عالية",
        backgroundColor: AppColors.highPriorityTextBG,
        textColor: AppColors.highPriorityText,
      );
    case "اولوليه متوسطة":
     return PriorityDisplayModel(
        priority: "اولوليه متوسطة",
        backgroundColor: AppColors.midPriorityTextBG,
        textColor: AppColors.midPriorityText,
      );
    case "اولوليه منخفضة":
      return PriorityDisplayModel(
        priority: "اولوليه منخفضة",
        backgroundColor: AppColors.readyTextBG,
        textColor: AppColors.readyText,
      );
    default:
      return PriorityDisplayModel(
        priority: priority,
        backgroundColor: AppColors.grayText,
        textColor: Colors.white,
      );
      
  }
}
