class MinistryNotificationApiDetails {
  final String messageTitle;
  final String description;
  final String alertType;
  final String status;
  final String priority;
  final String createdAt;
  final String hospitalName;

  MinistryNotificationApiDetails({
    required this.messageTitle,
    required this.description,
    required this.alertType,
    required this.status,
    required this.priority,
    required this.createdAt,
    required this.hospitalName,
  });

  factory MinistryNotificationApiDetails.fromJson(Map<String, dynamic> json) {
    return MinistryNotificationApiDetails(
      messageTitle: json["message_title"],
      description: json["description"],
      alertType: json["alert_type"],
      status: json["ALERT_Status"],
      createdAt: json["created_at"],
      hospitalName: json["sender_hospital"]["name"],
      priority: json["priority"],
    );
  }
}
