import 'package:organ_link/apis/managers/user_manager/user_home_api_manager.dart';
import 'package:organ_link/features/user_flow/home/bloc/user_home_bloc.dart';
import 'package:organ_link/features/user_flow/home/model/user_home_data_ui_model.dart';
import 'package:organ_link/preferences/preferences_manager.dart';

abstract class BaseUserHomeRepository {
  Future<UserHomeState> getUserHomeData();
}

class UserHomeRepository implements BaseUserHomeRepository {
  final UserHomeApiManager userHomeApiManager;
  final PreferencesManager preferencesManager;

  UserHomeRepository({
    required this.userHomeApiManager,
    required this.preferencesManager,
  });
  @override
  Future<UserHomeState> getUserHomeData() async {
    late UserHomeState userHomeState;
    final int? id = await preferencesManager.getId();
    await userHomeApiManager.userHomeApi(
      id!,
      (response) {
        final model = UserHomeDataUiModel.fromApiModel(response);
        userHomeState = UserHomeDataLoadedSuccessfullyState(
          userHomeDataUiModel: model,
        );
      },
      (error) {
        userHomeState = UserHomeErrorState(
          errorMessage: error.message,
          codeError: error.code,
        );
      },
    );
    return userHomeState;
  }
}
