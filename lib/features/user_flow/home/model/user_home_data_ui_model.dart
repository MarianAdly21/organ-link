import 'package:organ_link/apis/models/user_models/user_data_response.dart';

class UserHomeDataUiModel {
  final String name;
  final String type;
  final String identificationNumber;
  final String currentState;
  final DateTime lastUpdate;

  UserHomeDataUiModel({
    required this.name,
    required this.type,
    required this.identificationNumber,
    required this.currentState,
    required this.lastUpdate,
  });
  factory UserHomeDataUiModel.fromApiModel(UserDataResponse e) {
    return UserHomeDataUiModel(
      name: e.fullName,
      type: e.type,
      identificationNumber: e.identificationNumber,
      currentState: e.currentState,
      lastUpdate: e.lastUpdate,
    );
  }
}
