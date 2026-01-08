import 'package:organ_link/features/hospital_flow/view_patient/models/priority_display_model.dart';
import 'package:organ_link/res/app_colors.dart';

PriorityDisplayModel getPriority(String priority) {
  switch (priority) {
    case "أولوية عالية":
      return PriorityDisplayModel(
        priority: "أولوية عالية",
        backgroundColor: AppColors.highPriorityTextBG,
        textColor: AppColors.highPriorityText,
      );
    case "متوسطة":
     return PriorityDisplayModel(
        priority: "متوسطة",
        backgroundColor: AppColors.midPriorityText,
        textColor: AppColors.midPriorityTextBG,
      );
    case "منخفضة":
      return PriorityDisplayModel(
        priority: "منخفضة",
        backgroundColor: AppColors.readyTextBG,
        textColor: AppColors.readyText,
      );
    default:
      return PriorityDisplayModel(
        priority: priority,
        backgroundColor: AppColors.grayText,
        textColor: AppColors.grayText,
      );
      
  }
}
