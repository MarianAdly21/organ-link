import 'package:organ_link/apis/models/hospital/matching_api_model.dart';

class MatchingUiModel {
  final String patientName;
  final String donorName;
  final String donorBloodType;
  final String patientOrgan;
  final int matchId;
  final DateTime requestMatchingDate;
  final String? matchPercentage;
  final String matchingNumber;
  final String aiStatus;
  final String status;
  final String aiResult;

  MatchingUiModel({
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
    required this.matchId
  });
  factory MatchingUiModel.fromApiModel(MatchingApiModel e) {
    return MatchingUiModel(
      patientName: e.patientName,
      donorName: e.donorName,
      donorBloodType: e.donorBloodType,
      patientOrgan: e.patientOrgan,
      requestMatchingDate: e.requestMatchingDate,
      matchPercentage: "77 %",
    //  matchPercentage: e.matchPercentage,
      matchingNumber: e.matchingNumber,
      aiStatus: e.aiStatus,
      status: e.status,
      aiResult: e.aiResult,
      matchId: e.matchId
    );
  }
}
