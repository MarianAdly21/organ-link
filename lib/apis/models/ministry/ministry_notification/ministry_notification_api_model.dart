import 'package:organ_link/apis/models/ministry/ministry_notification/ministry_notification_list_api_model.dart';

class MinistryNotificationApiModel {
  final int totalAlerts;
  final int unreadAlerts;
  final int underInvestigation;
  final int resolvedAlerts;
  final List<MinistryNotificationListApiModel> alertList;

  MinistryNotificationApiModel({
    required this.totalAlerts,
    required this.unreadAlerts,
    required this.underInvestigation,
    required this.resolvedAlerts,
    required this.alertList,
  });

  factory MinistryNotificationApiModel.fromJson(Map<String, dynamic> json) {
    return MinistryNotificationApiModel(
      totalAlerts: json["alerts_statistics"]["total_alerts"],
      unreadAlerts: json["alerts_statistics"]["unread_alerts"],
      underInvestigation: json["alerts_statistics"]["under_investigation"],
      resolvedAlerts: json["alerts_statistics"]["resolved_alerts"],
      alertList: (json["ministry_alerts"] as List? ?? [])
          .map((x) => MinistryNotificationListApiModel.fromJson(x))
          .toList(),
    );
  }
}
