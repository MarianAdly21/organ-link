import 'package:organ_link/apis/models/_base/base_wrapper.dart';
import 'package:organ_link/apis/models/auth/login/login_successful_response.dart';

class LoginWrapper extends BaseWrapper {
  final LoginSuccessfulResponse? data;
  LoginWrapper(this.data, super.isSuccess, super.message);

  LoginWrapper.fromJson(super.json)
    : data = json["data"] != null
          ? LoginSuccessfulResponse.formJson(json["data"])
          : null,
      super.fromJson();
}
