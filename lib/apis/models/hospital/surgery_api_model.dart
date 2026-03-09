import 'package:organ_link/apis/models/hospital/surgery_list_api_model.dart';

class SurgeryApiModel {
  final List<SurgeryListApiModel> surgeryList;
  final int scheduledSurgeriesCount;
  final int ongoingSurgeriesCount;
  final int completedSurgeriesCount;
  final int underReviewSurgeriesCount;

  SurgeryApiModel({
    required this.surgeryList,
    required this.scheduledSurgeriesCount,
    required this.ongoingSurgeriesCount,
    required this.completedSurgeriesCount,
    required this.underReviewSurgeriesCount,
  });
  factory SurgeryApiModel.fromJson(Map<String, dynamic> json) {
    return SurgeryApiModel(
      scheduledSurgeriesCount: json["scheduled_surgeries_count"],
      ongoingSurgeriesCount: json["ongoing_surgeries_count"],
      completedSurgeriesCount: json["completed_surgeries_count"],
      underReviewSurgeriesCount: json["under_review_surgeries_count"],
      surgeryList: (json["surgeries"] as List? ?? [])
          .map((x) => SurgeryListApiModel.fromJson(x))
          .toList(),
    );
  }
}

