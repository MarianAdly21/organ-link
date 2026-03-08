import 'package:organ_link/apis/models/hospital/allergies_api_model.dart';

class AllergiesUiModel {
  final String name;

  AllergiesUiModel({required this.name});
  factory AllergiesUiModel.fromApiModel(AllergiesApiModel e) {
    return AllergiesUiModel(name: e.name);
  }
}