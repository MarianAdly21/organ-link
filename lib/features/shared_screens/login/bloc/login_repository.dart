import 'package:organ_link/apis/managers/auth_api_manager.dart';
import 'package:organ_link/apis/models/auth/login/login_send_model.dart';
import 'package:organ_link/apis/models/auth/login/login_successful_response.dart';
import 'package:organ_link/features/shared_screens/login/bloc/login_bloc.dart';
import 'package:organ_link/preferences/preferences_manager.dart';

abstract class BaseLoginRepository {
  Future<LoginState> loginWithIdNumberAndPassword({
    required String identificationNumber,
    required String password,
  });

  Future<LoginState> saveUserInfo(LoginSuccessfulResponse loginSuccessfulResponse);
  Future<LoginState> navToHomeScreen();
}

class LoginRepository implements BaseLoginRepository {
  final AuthApiManager authApiManager;
  final PreferencesManager preferencesManager;

  LoginRepository({
    required this.authApiManager,
    required this.preferencesManager,
  });
  @override
  Future<LoginState> loginWithIdNumberAndPassword({
    required String identificationNumber,
    required String password,
  }) async {
    late LoginState loginState;
    await authApiManager.loginApi(
      LoginSendModelApi(
        identificationNumber: identificationNumber,
        password: password,
      ),
      (response) {
        loginState = LoginSuccessfullyState(loginSuccessfulResponse: response);
      },
      (error) {
        loginState = LoginErrorState(errorMessage: error.message,codeError: error.code);
      },
    );
    return loginState;
  }
  
  @override
  Future<LoginState> saveUserInfo(LoginSuccessfulResponse loginSuccessfulResponse)async {
    late LoginState loginState;
   await preferencesManager.setType(loginSuccessfulResponse.type);
   await preferencesManager.setId(loginSuccessfulResponse.id);
   await preferencesManager.setToken(loginSuccessfulResponse.token);
    loginState=UserInfoSavedState();
    return loginState;
  }
  
  @override
  Future<LoginState> navToHomeScreen()async {
   late LoginState loginState;
   final String? type =  await preferencesManager.getType();
   final int? id =  await preferencesManager.getId();
   loginState=NavToHomeScreenState(type:type!,id: id!);
    return loginState;
  }
}
