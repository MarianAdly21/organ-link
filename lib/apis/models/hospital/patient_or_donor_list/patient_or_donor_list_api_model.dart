import 'package:organ_link/apis/models/hospital/patient_or_donor_list/patient_or_donor_api_model.dart';

class PatientOrDonorListApiModel {
  final List<PatientOrDonorApiModel> patientList;
  final List<PatientOrDonorApiModel> donorList;

  PatientOrDonorListApiModel({
    required this.patientList,
    required this.donorList,
  });
  factory PatientOrDonorListApiModel.formJson(Map<String, dynamic> json) {
    return PatientOrDonorListApiModel(
      patientList: (json["patients"] as List? ?? [])
          .map((x) => PatientOrDonorApiModel.formJson(x))
          .toList(),
      donorList: (json["donors"] as List? ?? [])
          .map((x) => PatientOrDonorApiModel.formJson(x))
          .toList(),
    );
  }
}
