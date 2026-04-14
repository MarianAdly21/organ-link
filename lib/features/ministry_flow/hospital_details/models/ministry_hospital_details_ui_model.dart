import 'package:organ_link/apis/models/ministry/hospital_details/hospital_details_api_model.dart';
import 'package:organ_link/features/ministry_flow/hospital_details/models/last_surgeries_ui_model.dart';
import 'package:organ_link/features/ministry_flow/hospitals/models/organ_needs_ui_model.dart';

class MinistryHospitalDetailsUiModel {
  final String hospitalName;
  final String hospitalLocation;
  final String hospitalStatus;
  final String hospitalType;
  final String phone;
  final String email;
  final int totalPatients;
  final int totalDonors;
  final int totalSurgeries;
  final double successPercentage;
  final List<OrganNeedsUiModel> organNeeds;
  final List<LastSurgeriesUiModel> lastSurgeries;

  MinistryHospitalDetailsUiModel({
    required this.hospitalName,
    required this.hospitalLocation,
    required this.hospitalStatus,
    required this.hospitalType,
    required this.phone,
    required this.email,
    required this.totalPatients,
    required this.totalDonors,
    required this.totalSurgeries,
    required this.successPercentage,
    required this.organNeeds,
    required this.lastSurgeries,
  });

  factory MinistryHospitalDetailsUiModel.fromApiModel(HospitalDetailsApiModel e) {
    return MinistryHospitalDetailsUiModel(
      hospitalName: e.hospitalName,
      hospitalLocation: e.hospitalLocation,
      hospitalStatus: e.hospitalStatus,
      hospitalType: e.hospitalType,
      phone: e.phone,
      email: e.email,
      totalPatients: e.totalPatients,
      totalDonors: e.totalDonors,
      totalSurgeries: e.totalSurgeries,
      successPercentage: e.successPercentage,
      organNeeds: e.organNeeds
          .map((x) => OrganNeedsUiModel.fromApiModel(x))
          .toList(),
      lastSurgeries: e.lastSurgeries
          .map((x) => LastSurgeriesUiModel.fromApiModel(x))
          .toList(),
    );
  }
}
