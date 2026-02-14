class MatchingApiModel {
  final String patientName;
  final String donorName;
  final String donorBloodType;
  final String patientOrgan;
  final DateTime requestMatchingDate;
  final String? matchPercentage;
  final String matchingNumber;
  final String aiStatus;
  final String status;
  final String aiResult;
  final int matchId;

  MatchingApiModel({
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

  factory MatchingApiModel.formJson(Map<String, dynamic> json) {
    return MatchingApiModel(
      patientName: json["patient_detail"]["full_name"],
      donorName: json["donor_detail"]["full_name"],
      donorBloodType: json["donor_detail"]["blood_type"],
      patientOrgan: json["organ_type"],
      requestMatchingDate: DateTime.parse(json["created_at"]),
      matchPercentage: json["match_percentage"],
      // matchingNumber: json[""],
      matchId: json["id"],
      matchingNumber: "MR001",
      aiStatus:json["status"] ,
      // status: json[""],
      status: "جاهز",
      aiResult:json["ai_result"] ?? "demo Ai result" ,
    );
  }
}
