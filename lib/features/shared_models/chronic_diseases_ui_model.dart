import 'package:organ_link/apis/models/shared_models/chronic_diseases_api_model.dart';

class ChronicDiseasesUiModel {
  //final int id;
  final String name;
  ChronicDiseasesUiModel({ required this.name});
  factory ChronicDiseasesUiModel.fromApiModel(ChronicDiseasesApiModel e) {
    return ChronicDiseasesUiModel( name: e.name);
  }
}
