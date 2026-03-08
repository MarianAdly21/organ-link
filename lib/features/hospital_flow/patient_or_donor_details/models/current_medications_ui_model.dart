import 'package:organ_link/apis/models/hospital/current_medications_api_model.dart';

class CurrentMedicationsUiModel {
  final String name;
  final String note;
  final int frequencyPerDay;

  CurrentMedicationsUiModel({
    required this.name,
    required this.note,
    required this.frequencyPerDay,
  });
  factory CurrentMedicationsUiModel.fromApiModel(CurrentMedicationsApiModel e) {
    return CurrentMedicationsUiModel(
      name: e.name,
      note: e.note,
      frequencyPerDay: e.frequencyPerDay,
    );
  }
}

