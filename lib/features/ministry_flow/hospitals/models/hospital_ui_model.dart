import 'package:organ_link/apis/models/ministry/hospitals_list/hospital_api_model.dart';
import 'package:organ_link/features/ministry_flow/hospitals/models/organ_needs_ui_model.dart';

class HospitalUiModel {
  final String hospitalName;
  final int hospitalId;
  final String hospitalLocation;
  final String hospitalStatus;
  final int surgeriesCount;
  final int donorsCount;
  final int patientsCount;
  final List<OrganNeedsUiModel> organNeeds;

  HospitalUiModel({
    required this.hospitalName,
    required this.hospitalLocation,
    required this.hospitalStatus,
    required this.surgeriesCount,
    required this.donorsCount,
    required this.patientsCount,
    required this.organNeeds,
    required this.hospitalId,
  });
  factory HospitalUiModel.fromApiModel(HospitalApiModel e) {
    return HospitalUiModel(
      hospitalName: e.hospitalName,
      hospitalId: e.hospitalId,
      hospitalLocation: e.hospitalLocation,
      hospitalStatus: e.hospitalStatus,
      surgeriesCount: e.surgeriesCount,
      donorsCount: e.donorsCount,
      patientsCount: e.patientsCount,
      organNeeds: (e.organNeeds)
          .map((e) => OrganNeedsUiModel.fromApiModel(e))
          .toList(),
    );
  }
}
