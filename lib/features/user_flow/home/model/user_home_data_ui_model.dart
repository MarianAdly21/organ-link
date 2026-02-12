import 'package:organ_link/apis/models/user_models/user_Home/user_home_data_response.dart';

class UserHomeDataUiModel {
  final String name;
  final String type;
  final String identificationNumber;
  final String currentState;

  UserHomeDataUiModel({
    required this.name,
    required this.type,
    required this.identificationNumber,
    required this.currentState,
  });
  factory UserHomeDataUiModel.fromApiModel(UserHomeDataResponse e) {
    return UserHomeDataUiModel(
      name: e.fullName,
      type: e.type,
      identificationNumber: e.identificationNumber,
      currentState: e.currentState,
    );
  }
  // factory UserHomeDataUiModel.empty() {
  //   return UserHomeDataUiModel(
  //     name: "",
  //     type: "",
  //     identificationNumber: "",
  //     currentState: "",
  //   );
  // }
}
