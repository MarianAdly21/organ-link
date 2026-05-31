class VitalSignsApiModel {
  final String bloodPressure;
  final double temperatureC;
  final double oxygenSaturation;
  final int heartRate;
  final int respiratoryRate;

  VitalSignsApiModel({
    required this.bloodPressure,
    required this.temperatureC,
    required this.oxygenSaturation,
    required this.heartRate,
    required this.respiratoryRate,
  });
  factory VitalSignsApiModel.fromJson(Map<String, dynamic> json) {
    return VitalSignsApiModel(
      bloodPressure: json["blood_pressure"],
      temperatureC: json["temperature_c"],
      oxygenSaturation: json["oxygen_saturation"],
      heartRate: json["heart_rate"],
      respiratoryRate: json["respiratory_rate"],
    );
  }
}
