import 'package:organ_link/features/hospital_flow/view_patient_or_donor/models/status_display_model.dart';
import 'package:organ_link/res/app_colors.dart';

StatusDisplayModel getStatus(String statue)
{
  switch(statue)
  {
    case "جاهز":
    return StatusDisplayModel(
        status:  "جاهز",
        backgroundColor: AppColors.readyTextBG,
        textColor: AppColors.readyText, 
      );
      case "تمت العملية":
      return StatusDisplayModel(
        status: "تمت العملية",
        backgroundColor: AppColors.readyTextBG,
        textColor: AppColors.readyText,
      );
      case "قيد المراجعه":
      return StatusDisplayModel(
        status: "قيد المراجعة",
        backgroundColor: AppColors.underMatchingTextBG,
        textColor: AppColors.underMatchingText,
      );
    case "تمت المطابقة":
      return StatusDisplayModel(
        status: "تمت المطابقة",
         backgroundColor: AppColors.underMatchingTextBG,
        textColor: AppColors.underMatchingText,
      );
   
    default:
      return StatusDisplayModel(
        status: statue,
        backgroundColor:AppColors.transparent,
        textColor: AppColors.transparent,
      );

  }

}