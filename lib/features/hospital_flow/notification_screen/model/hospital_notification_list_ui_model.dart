import 'package:organ_link/apis/models/hospital/hospital_notification/hospital_notification_list_api_model.dart';

class HospitalNotificationListUiModel {
  final String title;
  final String content;
  final bool isUrgent;
  final DateTime notificationTime;

  HospitalNotificationListUiModel({
    required this.title,
    required this.content,
    required this.isUrgent,
    required this.notificationTime,
  });
  factory HospitalNotificationListUiModel.fromApiModel(
    HospitalNotificationListApiModel e,
  ) {
    return HospitalNotificationListUiModel(
      title: e.title,
      content: e.content,
      isUrgent: e.isUrgent,
      notificationTime: e.notificationTime,
    );
  }
}
