import 'package:organ_link/apis/models/hospital/hospital_notification/hospital_notification_list_api_model.dart';

class HospitalNotificationApiModel {
  final List<HospitalNotificationListApiModel> notificationList;
  final int totalNotification;
  final int unreadNotification;
  final int criticalNotification;

  HospitalNotificationApiModel({
    required this.notificationList,
    required this.totalNotification,
    required this.unreadNotification,
    required this.criticalNotification,
  });
  factory HospitalNotificationApiModel.fromJson(Map<String, dynamic> json) {
    return HospitalNotificationApiModel(
      notificationList: (json["alerts_hospitals"] as List? ?? [])
          .map((x) => HospitalNotificationListApiModel.fromJson(x))
          .toList(),
      totalNotification: json["total_alerts"],
      unreadNotification: json["unread_alerts"],
      criticalNotification: json["critical_alerts"],
    );
  }
}
