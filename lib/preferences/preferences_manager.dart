import 'package:organ_link/preferences/preferences_keys.dart';
import 'package:organ_link/utils/preferences/preferences_utils.dart';

class PreferencesManager {
  Future<bool> clearData() async {
    final String? locale = await getLocale();
    await PreferencesUtils.clearData();
    if (locale != null) await setLocale(locale);
    return true;
  }

  Future<bool> setLocale(String data) async {
    return await PreferencesUtils.setString(PreferencesKeys.lang.name, data);
  }

  Future<String?> getLocale() async {
    return await PreferencesUtils.getString(PreferencesKeys.lang.name);
  }
  Future<bool> setType(String data) async {
    return await PreferencesUtils.setString(PreferencesKeys.type.name, data);
  }

  Future<String?> getType() async {
    return await PreferencesUtils.getString(PreferencesKeys.type.name);
  }

  Future<void> setLoggedIn() async {
    await PreferencesUtils.setBool(PreferencesKeys.isLoggedIn.name, true);
  }

  Future<bool> isAsGuest() async {
    return !await PreferencesUtils.getBool(PreferencesKeys.isLoggedIn.name);
  }

  Future<void> setNotLoggedIn() async {
    await PreferencesUtils.setBool(PreferencesKeys.isLoggedIn.name, false);
  }

  Future<bool> isLoggedIn() async {
    return await PreferencesUtils.getBool(PreferencesKeys.isLoggedIn.name);
  }

  Future<void> setAccessToken(String data) async {
    await PreferencesUtils.setString(PreferencesKeys.accessToken.name, data);
  }

  Future<String?> getAccessToken() async {
    return await PreferencesUtils.getString(PreferencesKeys.accessToken.name);
  }

  Future<void> setRefreshToken(String data) async {
    await PreferencesUtils.setString(PreferencesKeys.refreshToken.name, data);
  }

  Future<String?> getRefreshToken() async {
    return await PreferencesUtils.getString(PreferencesKeys.refreshToken.name);
  }

  Future<void> setName(String data) async {
    await PreferencesUtils.setString(PreferencesKeys.name.name, data);
  }

  Future<String?> getName() async {
    return await PreferencesUtils.getString(PreferencesKeys.name.name);
  }
   Future<void> setToken(String data) async {
    await PreferencesUtils.setString(PreferencesKeys.token.name, data);
  }

  Future<String?> getToken() async {
    return await PreferencesUtils.getString(PreferencesKeys.token.name);
  }

  Future<void> setUserImageUrl(String data) async {
    await PreferencesUtils.setString(PreferencesKeys.userImageUrl.name, data);
  }

  Future<String?> getUserImageUrl() async {
    return await PreferencesUtils.getString(PreferencesKeys.userImageUrl.name);
  }

  Future<void> setEmail(String data) async {
    await PreferencesUtils.setString(PreferencesKeys.email.name, data);
  }

  Future<String?> getEmail() async {
    return await PreferencesUtils.getString(PreferencesKeys.email.name);
  }

  Future<void> setExpiresToken(int data) async {
    await PreferencesUtils.setInt(PreferencesKeys.expiresIn.name, data);
  }

  Future<int?> getExpiresToken() async {
    return await PreferencesUtils.getInt(PreferencesKeys.expiresIn.name);
  }

  Future<void> setId(int data) async {
    await PreferencesUtils.setInt(PreferencesKeys.id.name, data);
  }

  Future<int?> getId() async {
    return await PreferencesUtils.getInt(PreferencesKeys.id.name);
  }

  Future<void> setTokenData(
    String accessToken,
    String? refreshToken,
    int expiresIn,
  ) async {
    await setAccessToken(accessToken);
    await setExpiresToken(expiresIn);
    if (refreshToken != null) {
      await setRefreshToken(refreshToken);
    }
  }

  /// Notifications Settings
  Future<bool> setIsAllowNotifications(bool data) async {
    return await PreferencesUtils.setBool(
      PreferencesKeys.isAllowNotifications.name,
      data,
    );
  }

  Future<bool> getIsAllowNotifications() async {
    return await PreferencesUtils.getBool(
      PreferencesKeys.isAllowNotifications.name,
    );
  }
}
