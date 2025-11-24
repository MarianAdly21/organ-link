import 'package:organ_link/apis/models/refresh_token/refresh_token_successful_response.dart';

class RefreshTokenWrapper {
  final RefreshTokenSuccessfulResponse? data;

  RefreshTokenWrapper(this.data);

  RefreshTokenWrapper.fromJson(Map<String, dynamic> json)
    : data = (json['access_token'] != null)
          ? RefreshTokenSuccessfulResponse.fromJson(json)
          : null;

  Map<String, dynamic> toJson() => {'data': data?.toJson()};
}
