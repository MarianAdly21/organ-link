import 'package:organ_link/apis/models/ministry/ministry_notification/ministry_notification_api_details.dart';

class MinistryNotificationDetailsUiModel {
  final String messageTitle;
  final String description;
  final String alertType;
  final String status;
  final String priority;
  final String createdAt;
  final String hospitalName;

  MinistryNotificationDetailsUiModel({
    required this.messageTitle,
    required this.description,
    required this.alertType,
    required this.status,
    required this.priority,
    required this.createdAt,
    required this.hospitalName,
  });

  factory MinistryNotificationDetailsUiModel.fromApiModel(
    MinistryNotificationApiDetails e,
  ) {
    return MinistryNotificationDetailsUiModel(
      messageTitle: e.messageTitle,
      description: e.description,
      alertType: e.alertType,
      status: e.status,
      createdAt: e.createdAt,
      hospitalName: e.hospitalName,
      priority: e.priority,
    );
  }
}
