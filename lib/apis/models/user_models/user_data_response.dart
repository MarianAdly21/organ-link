import 'package:organ_link/apis/models/user_models/notification_user_api_model.dart';

class UserDataResponse {
  final String fullName;
  final String type;
  final String identificationNumber;
  final String currentState;
  final DateTime lastUpdate;
  final List<NotificationUserApiModel> notificationList;

  UserDataResponse({
    required this.fullName,
    required this.type,
    required this.identificationNumber,
    required this.currentState,
    required this.lastUpdate,
    required this.notificationList,
  });
  factory UserDataResponse.formJson(Map<String, dynamic> json) {
    return UserDataResponse(
      fullName: json["full_name"] as String,
      type: json["role"] as String,
      identificationNumber: json["medical_record_number"] as String,
      currentState: json["status"] as String,
      lastUpdate: DateTime.parse(json["updated_at"]),
      notificationList: (json["alerts"] as List? ?? [])
          .map((x) => NotificationUserApiModel.formJson(x))
          .toList(),
    );
  }
}
