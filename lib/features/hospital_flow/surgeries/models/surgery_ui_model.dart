import 'package:organ_link/apis/models/hospital/surgeries/surgery_api_model.dart';
import 'package:organ_link/features/hospital_flow/surgeries/models/surgery_list_ui_model.dart';

class SurgeryUiModel {
  final List<SurgeryListUiModel> surgeryList;
  final int scheduledSurgeriesCount;
  final int ongoingSurgeriesCount;
  final int completedSurgeriesCount;
  final int underReviewSurgeriesCount;

  SurgeryUiModel({
    required this.surgeryList,
    required this.scheduledSurgeriesCount,
    required this.ongoingSurgeriesCount,
    required this.completedSurgeriesCount,
    required this.underReviewSurgeriesCount,
  });
  factory SurgeryUiModel.fromApiModel(SurgeryApiModel e) {
    return SurgeryUiModel(
      surgeryList: (e.surgeryList)
          .map((x) => SurgeryListUiModel.fromApiModel(x))
          .toList(),
      scheduledSurgeriesCount: e.scheduledSurgeriesCount,
      ongoingSurgeriesCount: e.ongoingSurgeriesCount,
      completedSurgeriesCount: e.completedSurgeriesCount,
      underReviewSurgeriesCount: e.underReviewSurgeriesCount,
    );
  }
}
