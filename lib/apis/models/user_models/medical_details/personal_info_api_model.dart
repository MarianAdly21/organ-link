class PersonalInfoApiModel {
  final String fullName;
  final String type;
  final String organ;/// required or donated organ
  final String medicalFileNumber;
  final String age;
  final String bloodType;

  PersonalInfoApiModel({required this.fullName, required this.type, required this.organ, required this.medicalFileNumber, required this.age, required this.bloodType});
  factory PersonalInfoApiModel.fromJson(Map<String,dynamic> json)
  {
    return PersonalInfoApiModel(
      fullName: json["full_name"], 
      type: json["type"], 
      organ: json["organ"],
      medicalFileNumber: json["medicalFileNumber"],
      age: json["medicalFileNumber"], 
      bloodType: json["bloodType"],
        );
  }
}