import 'package:organ_link/apis/models/hospital/hospital_data_response.dart';

class HospitalDashboardUiModel {
  final String hospitalName;
  final String hospitalCity;
  final int totalMatches;
  final int totalSurgeries;
  final int patientsCount;
  final int donorsCount;

  HospitalDashboardUiModel({
    required this.hospitalName,
    required this.hospitalCity,
    required this.totalMatches,
    required this.totalSurgeries,
    required this.patientsCount,
    required this.donorsCount,
  });
  factory HospitalDashboardUiModel.fromApiModel(HospitalDataResponse e) {
    return HospitalDashboardUiModel(
      hospitalName: e.hospitalName,
      hospitalCity: e.hospitalCity,
      totalMatches: e.totalMatches,
      totalSurgeries: e.totalSurgeries,
      patientsCount: e.patientsCount,
      donorsCount: e.donorsCount,
    );
  }
}
