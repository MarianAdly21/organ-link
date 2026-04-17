class HospitalNotificationListApiModel {
  final String title;
  final String content;
  final bool isUrgent;
  final DateTime notificationTime;

  HospitalNotificationListApiModel({
    required this.title,
    required this.content,
    required this.isUrgent,
    required this.notificationTime,
  });

  factory HospitalNotificationListApiModel.fromJson(Map<String, dynamic> json) {
    return HospitalNotificationListApiModel(
      title: json["message_title"],
      content: json["message"],
      isUrgent: json["is_urgent"],
      notificationTime: DateTime.parse(json["created_at"]),
    );
  }
}
