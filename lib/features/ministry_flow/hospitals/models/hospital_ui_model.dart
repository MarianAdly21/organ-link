class HospitalUiModel {
  final String hospitalName;
  final String hospitalState;
  // final bool isActive;
  final String city;
  final int patientsCount;
  final int donorsCount;
  final int operationsCount;
  final List<OrganNeedModel> organNeeds;

  HospitalUiModel({
    required this.hospitalName,
    required this.hospitalState,
    required this.city,
    required this.patientsCount,
    required this.donorsCount,
    required this.operationsCount,
    required this.organNeeds,
  });

  factory HospitalUiModel.fromJson(Map<String, dynamic> json) {
    return HospitalUiModel(
      hospitalName: json['name'],
      city: json['city'],
      hospitalState: json['is_active'],
      patientsCount: json['patients_count'],
      donorsCount: json['donors_count'],
      operationsCount: json['operations_count'],
      organNeeds: (json['organ_needs'] as List)
          .map((e) => OrganNeedModel.fromJson(e))
          .toList(),
    );
  }
}

class OrganNeedModel {
  final String organName;
  final int count;

  OrganNeedModel({required this.organName, required this.count});

  factory OrganNeedModel.fromJson(Map<String, dynamic> json) {
    return OrganNeedModel(organName: json['organ_name'], count: json['count']);
  }
}
