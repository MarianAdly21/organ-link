import 'package:organ_link/apis/models/ministry/hospitals_list/hospitals_list_api_model.dart';
import 'package:organ_link/features/ministry_flow/hospitals/models/hospital_ui_model.dart';
class HospitalsListUiModel {
  final List<HospitalUiModel> hospitalsList;

  HospitalsListUiModel({required this.hospitalsList});
  factory HospitalsListUiModel.fromApiModel(HospitalsListApiModel e) {
    return HospitalsListUiModel(
      hospitalsList: (e.hospitalsList)
          .map((x) => HospitalUiModel.fromApiModel(x))
          .toList(),
    );
  }
}
