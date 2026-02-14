class MatchingDetailsApiModel {
  final String donorName;
  final String donorBloodType;
  final String donorFileNum;
  final String patientName;
  final String patientFileNum;
  final String organ;
  final DateTime requestDate;
  final String requestStatus;
  final String? matchPercentage;

  MatchingDetailsApiModel({
    required this.donorName,
    required this.donorBloodType,
    required this.donorFileNum,
    required this.patientName,
    required this.patientFileNum,
    required this.organ,
    required this.requestDate,
    required this.requestStatus,
    required this.matchPercentage,
  });

  factory MatchingDetailsApiModel.formJson(Map<String, dynamic> json) {
    return MatchingDetailsApiModel(
      donorName: json["donor_detail"]["full_name"],
      donorBloodType: json["donor_detail"]["blood_type"],
      // donorFileNum: json[""],
      donorFileNum: "D001",
      patientName: json["patient_detail"]["full_name"],
      //  patientFileNum: json[""],
      patientFileNum: "P001",
      organ: json["organ_type"],
      requestDate: DateTime.parse(json["created_at"]),
      requestStatus: json["status"],
      matchPercentage: json["match_percentage"],
    );
  }
}
