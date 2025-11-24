import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';

class DeviceInfo {
  final DeviceInfoPlugin _deviceInfo = DeviceInfoPlugin();

  Future<String?> getDeviceId() async {
    if (Platform.isAndroid) {
      final AndroidDeviceInfo androidInfo = await _deviceInfo.androidInfo;
      return androidInfo.id;
    } else if (Platform.isIOS) {
      final IosDeviceInfo iosInfo = await _deviceInfo.iosInfo;
      return iosInfo.identifierForVendor;
    } else {
      return null;
    }
  }
}
