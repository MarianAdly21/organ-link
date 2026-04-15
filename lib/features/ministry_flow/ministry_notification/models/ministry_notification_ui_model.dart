import 'package:organ_link/apis/models/ministry/ministry_notification/ministry_notification_api_model.dart';
import 'package:organ_link/features/ministry_flow/ministry_notification/models/ministry_notification_list_ui_model.dart';

class MinistryNotificationUiModel {
  final int totalAlerts;
  final int unreadAlerts;
  final int underInvestigation;
  final int resolvedAlerts;
  final List<MinistryNotificationListUiModel> alertList;

  MinistryNotificationUiModel({
    required this.totalAlerts,
    required this.unreadAlerts,
    required this.underInvestigation,
    required this.resolvedAlerts,
    required this.alertList,
  });

  factory MinistryNotificationUiModel.fromApiModel(
    MinistryNotificationApiModel e,
  ) {
    return MinistryNotificationUiModel(
      totalAlerts: e.totalAlerts,
      unreadAlerts: e.unreadAlerts,
      underInvestigation: e.underInvestigation,
      resolvedAlerts: e.resolvedAlerts,
      alertList: (e.alertList)
          .map((x) => MinistryNotificationListUiModel.fromApiModel(x))
          .toList(),
    );
  }
}
