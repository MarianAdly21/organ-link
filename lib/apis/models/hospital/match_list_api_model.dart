
class MatchListApiModel {
  final String patientName;
  final String donorName;
  final String donorBloodType;
  final String patientOrgan;
  final DateTime requestMatchingDate;
  final double? matchPercentage;
  final String matchingNumber;
  final String aiStatus;
  final String status;
  final String aiResult;
  final int matchId;

  MatchListApiModel({
    required this.patientName,
    required this.donorName,
    required this.donorBloodType,
    required this.patientOrgan,
    required this.requestMatchingDate,
    required this.matchPercentage,
    required this.matchingNumber,
    required this.aiStatus,
    required this.status,
    required this.aiResult,
    required this.matchId,
  });

  factory MatchListApiModel.formJson(Map<String, dynamic> json) {
    return MatchListApiModel(
      patientName: json["patient_detail"]["full_name"],
      donorName: json["donor_detail"]["full_name"],
      donorBloodType: json["donor_detail"]["blood_type"],
      patientOrgan: json["organ_type"],
      requestMatchingDate: DateTime.parse(json["created_at"]),
      matchPercentage: json["match_percentage"],
      matchId: json["id"],
      matchingNumber: json["request_number"],
      aiStatus: json["status"],
      status: "demoجاهز",
      aiResult: json["ai_result"]["result"] ?? "demo Ai result",
    );
  }
}
