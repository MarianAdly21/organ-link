
import 'package:organ_link/apis/models/user_models/medical_details/chronic_diseases_api_model.dart';
import 'package:organ_link/apis/models/user_models/medical_details/medical_test_api_model.dart';
import 'package:organ_link/apis/models/user_models/medical_details/personal_info_api_model.dart';

class MedicalDetailsApiModel {
  final List<MedicalTestApiModel> medicalTestList;
  final ChronicDiseasesApiModel chronicDiseasesList;
  final PersonalInfoApiModel personalInfo;
    //final String upcomingData;
  MedicalDetailsApiModel({required this.medicalTestList, required this.chronicDiseasesList, required this.personalInfo});
  factory MedicalDetailsApiModel.formJson(Map<String , dynamic> json)
  {
   
    return MedicalDetailsApiModel(medicalTestList: json["medical_text"]==null
                           ?[]:List<MedicalTestApiModel>.from(json["medical_text"].map((x)=>MedicalTestApiModel.fromJson(x))),
                            chronicDiseasesList:json["chronic_diseases"] ,
                             personalInfo: PersonalInfoApiModel.fromJson(json["personal_info"]),);
  }
       
}


