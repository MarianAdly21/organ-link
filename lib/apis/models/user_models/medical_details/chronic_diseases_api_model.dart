class ChronicDiseasesApiModel {
  final List<String>? chronicDiseases ;

  ChronicDiseasesApiModel({required this.chronicDiseases});
  factory ChronicDiseasesApiModel.fromJson(List<String> json) /// or list 
  {
    return ChronicDiseasesApiModel(chronicDiseases: json.cast<String>());
    
    // ChronicDiseasesApiModel(chronicDiseases: (json["chronic_diseases"] as List?)?.cast<String>());
  }
}


