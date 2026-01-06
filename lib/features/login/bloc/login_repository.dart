
import 'package:organ_link/apis/managers/auth_api_manager.dart';
import 'package:organ_link/apis/models/auth/login/login_send_model.dart';
import 'package:organ_link/features/login/bloc/login_bloc.dart';
import 'package:organ_link/preferences/preferences_manager.dart';

abstract class BaseLoginRepository {
  Future<LoginState> loginWithPasswordAndIdNumberApi({
    required String idNumber,
    required String password,
  });
}

class LoginRepository implements BaseLoginRepository {
  final PreferencesManager preferencesManager;
  final AuthApiManager authApiManager;
  LoginRepository({
    required this.preferencesManager,
    required this.authApiManager,
  });
  @override
  Future<LoginState> loginWithPasswordAndIdNumberApi({
    required String idNumber,
    required String password,
  }) async {
    late LoginState loginState;
    await authApiManager.loginApi(
     LoginSendModelApi(identificationNumber:idNumber , password:password ) ,
      (response) {
        loginState = LoginSuccessfullyState(
         
        );
      },
      (errorApiModel) {
        loginState = LoginErrorState(
          errorMessage: errorApiModel.message,
        );
      },
    );
    return loginState;
  }
}
