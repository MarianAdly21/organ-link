class CurrentMedicationsApiModel {
  final String name;
  final String note;
  final int frequencyPerDay;

  CurrentMedicationsApiModel({
    required this.name,
    required this.note,
    required this.frequencyPerDay,
  });
  factory CurrentMedicationsApiModel.fromJson(Map<String, dynamic> json) {
    return CurrentMedicationsApiModel(
      name: json["name"],
      note: json["notes"],
      frequencyPerDay: json["frequency_per_day"],
    );
  }
}

