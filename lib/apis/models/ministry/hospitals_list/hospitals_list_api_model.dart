
import 'package:organ_link/apis/models/ministry/hospitals_list/hospital_api_model.dart';

class HospitalsListApiModel {
   final List<HospitalApiModel> hospitalsList;

  HospitalsListApiModel({required this.hospitalsList});
  factory HospitalsListApiModel.fromJson(Map<String, dynamic> json) {
    return HospitalsListApiModel(
      hospitalsList: (json["hospitals"] as List)
          .map((x) => HospitalApiModel.fromJson(x))
          .toList(),
    );
  }
}