import 'package:organ_link/apis/models/_base/base_wrapper.dart';
import 'package:organ_link/apis/models/user_Home/user_home_data_response.dart';

class UserHomeDataWrapper extends BaseWrapper {
  final UserHomeDataResponse? data;
  UserHomeDataWrapper(super.isSuccess, super.message,this.data);
  UserHomeDataWrapper.fromJson(super.json)
    : data = json["data"] != null
          ? UserHomeDataResponse.formJson(json["data"])
          : null,
      super.fromJson();
      }
