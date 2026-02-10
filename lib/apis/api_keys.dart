import 'package:organ_link/utils/build_type/build_type.dart';

class ApiKeys {
  /// KEYs
  static const grantTypeRefreshToken = "refresh_token";
  static const authorization = "Authorization";
  static const accept = "Accept";
  static const applicationJson = "application/json";
  static const locale = "locale";
  static const acceptLanguage = "Accept-Language";
  static const contentType = "Content-Type";
  static const keyBearer = "Bearer";
  static const deviceTokenKey = "device_token";
  static const pageNumberKey = "page";
  static const perPageKey = "per_page";
  static const perPageValue = "15";
  static const notificationsKey = 'general';
  static const passKey = 'pass_key';
  static const lastEmailKey = 'last_email_key';
  static const egKey = 'EG';

  /// URLs
  static const baseUrlProduction = "";

  // static const apiKeyUrl = "api";
  // static const apiVersion = "v1";
  // static const baseApiUrl = '/$apiKeyUrl';
  static const baseUrl = 'https://web-production-00d08.up.railway.app/api';

  static const loginUrl = '$baseUrl/login/';

  static String get currentEnvironmentUrl =>
      isDevMode() ? ApiKeys.baseUrlProduction : ApiKeys.baseUrlProduction;
}
