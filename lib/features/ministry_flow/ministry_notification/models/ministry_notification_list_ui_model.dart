import 'package:organ_link/apis/models/ministry/ministry_notification/ministry_notification_list_api_model.dart';

class MinistryNotificationListUiModel {
  final String messageTitle;
  final String message;
  final String alertType;
  final String status;
  final String createdAt;
  final String hospitalName;
  final int id;

  MinistryNotificationListUiModel({
    required this.messageTitle,
    required this.message,
    required this.alertType,
    required this.status,
    required this.createdAt,
    required this.id,
    required this.hospitalName,
  });
  factory MinistryNotificationListUiModel.fromApiModel(
    MinistryNotificationListApiModel e,
  ) {
    return MinistryNotificationListUiModel(
      messageTitle: e.messageTitle,
      message: e.message,
      alertType: e.alertType,
      status: e.status,
      createdAt: e.createdAt,
      id: e.id,
      hospitalName: e.hospitalName,
    );
  }
}
