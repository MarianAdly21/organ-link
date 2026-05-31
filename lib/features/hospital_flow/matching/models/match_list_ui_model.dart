import 'package:organ_link/apis/models/hospital/matches/match_list_api_model.dart';

class MatchListUiModel {
  final String patientName;
  final String donorName;
  final String donorBloodType;
  final String patientOrgan;
  final DateTime requestMatchingDate;
  final double? matchPercentage;
  final String matchingNumber;
  final String aiStatus;
  final String status;
  final String? aiResult;
  final int matchId;

  MatchListUiModel({
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
  factory MatchListUiModel.fromApiModel(MatchListApiModel e) {
    return MatchListUiModel(
      patientName: e.patientName,
      donorName: e.donorName,
      donorBloodType: e.donorBloodType,
      patientOrgan: e.patientOrgan,
      requestMatchingDate: e.requestMatchingDate,
      matchPercentage: e.matchPercentage,
      matchingNumber: e.matchingNumber,
      aiStatus: e.aiStatus,
      status: e.status,
      aiResult: e.aiResult,
      matchId: e.matchId,
    );
  }
}
