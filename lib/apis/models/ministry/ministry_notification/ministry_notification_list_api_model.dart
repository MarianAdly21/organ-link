class MinistryNotificationListApiModel {
  final String messageTitle;
  final String message;
  final String alertType;
  final String status;
  final String createdAt;
  final String hospitalName;
  final int id;

  MinistryNotificationListApiModel({
    required this.messageTitle,
    required this.message,
    required this.alertType,
    required this.status,
    required this.createdAt,
    required this.id,
    required this.hospitalName,
  });
  factory MinistryNotificationListApiModel.fromJson(Map<String, dynamic> json) {
    return MinistryNotificationListApiModel(
      messageTitle: json["message_title"],
      message: json["message"],
      alertType: json["alert_type"],
      status: json["alert_status"],
      createdAt: json["created_at"],
      id: json["id"],
      hospitalName: json["sender_hospital"],
    );
  }
}
