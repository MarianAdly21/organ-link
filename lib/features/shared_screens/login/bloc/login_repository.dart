import 'package:organ_link/apis/managers/auth_api_manager.dart';
import 'package:organ_link/apis/models/auth/login/login_send_model.dart';
import 'package:organ_link/features/shared_screens/login/bloc/login_bloc.dart';
import 'package:organ_link/preferences/preferences_manager.dart';

abstract class BaseLoginRepository {

 Future<LoginState> loginWithIdNumberAndPassword({
  required String identificationNumber,
  required String password,
 });
}


class LoginRepository implements BaseLoginRepository {
  final AuthApiManager authApiManager;
  final PreferencesManager preferencesManager;

  LoginRepository({required this.authApiManager ,required this.preferencesManager});
  @override
  Future<LoginState> loginWithIdNumberAndPassword({required String identificationNumber, required String password})async {
    late LoginState loginState;
   await authApiManager.loginApi(
      LoginSendModelApi(identificationNumber, password), (response){
      loginState=LoginSuccessfullyState(loginSuccessfulResponse: response.data!);
    }, (error){
      loginState=LoginErrorState(errorMessage: error.message);
    });
     return loginState;
  }
}