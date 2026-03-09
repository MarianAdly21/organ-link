import 'package:organ_link/apis/models/hospital/matching_details_api_model.dart';

class MatchingDetailsUiModel {
  final String donorName;
  final String donorBloodType;
  final String donorFileNum;
  final String patientName;
  final String patientFileNum;
  final String organ;
  final DateTime requestDate;
  final String requestStatus;
  final double? matchPercentage;

  MatchingDetailsUiModel({
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
  factory MatchingDetailsUiModel.fromApiModel(MatchingDetailsApiModel e) {
    return MatchingDetailsUiModel(
      donorName: e.donorName,
      donorBloodType: e.donorBloodType,
      donorFileNum: e.donorFileNum,
      patientName: e.patientName,
      patientFileNum: e.patientFileNum,
      organ: e.organ,
      requestDate: e.requestDate,
      requestStatus: e.requestStatus,
      matchPercentage: e.matchPercentage,
    );
  }
}
