import 'package:organ_link/apis/models/hospital/hospital_data_response.dart';

class HospitalInformationSettingUiModel {
  final String hospitalName;
  final String hospitalCity;
  final String licenseNumber;
  final String phone;
  final String email;

  HospitalInformationSettingUiModel({
    required this.hospitalName,
    required this.hospitalCity,
    required this.licenseNumber,
    required this.phone,
    required this.email,
  });
  factory HospitalInformationSettingUiModel.fromApiModel(
    HospitalDataResponse e,
  ) {
    return HospitalInformationSettingUiModel(
      hospitalName: e.hospitalName,
      hospitalCity: e.hospitalCity,
      licenseNumber: e.licenseNumber,
      phone: e.phone,
      email: e.email,
    );
  }
}
