import 'package:organ_link/apis/models/hospital/hospital_notification/hospital_notification_api_model.dart';
import 'package:organ_link/features/hospital_flow/notification_screen/model/hospital_notification_list_ui_model.dart';

class HospitalNotificationUiModel {
  final List<HospitalNotificationListUiModel> notificationList;
  final int totalNotification;
  final int unreadNotification;
  final int criticalNotification;

  HospitalNotificationUiModel({
    required this.notificationList,
    required this.totalNotification,
    required this.unreadNotification,
    required this.criticalNotification,
  });
  factory HospitalNotificationUiModel.fromApiModel(
    HospitalNotificationApiModel e,
  ) {
    return HospitalNotificationUiModel(
      notificationList: (e.notificationList)
          .map((x) => HospitalNotificationListUiModel.fromApiModel(x))
          .toList(),
      totalNotification: e.totalNotification,
      unreadNotification: e.unreadNotification,
      criticalNotification: e.criticalNotification,
    );
  }
}
