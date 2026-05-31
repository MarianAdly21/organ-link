import 'package:organ_link/apis/models/hospital/vital_signs_api_model.dart';

class VitalSignsUiModel {
  final String bloodPressure;
  final double temperatureC;
  final double oxygenSaturation;
  final int heartRate;
  final int respiratoryRate;

  VitalSignsUiModel({
    required this.bloodPressure,
    required this.temperatureC,
    required this.oxygenSaturation,
    required this.heartRate,
    required this.respiratoryRate,
  });
  factory VitalSignsUiModel.fromApiModel(VitalSignsApiModel e) {
    return VitalSignsUiModel(
      bloodPressure: e.bloodPressure,
      temperatureC:e.temperatureC,
      oxygenSaturation: e.oxygenSaturation,
      heartRate: e.heartRate,
      respiratoryRate: e.respiratoryRate,
    );
  }
}
