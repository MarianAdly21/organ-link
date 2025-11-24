import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  final secureStorage = const FlutterSecureStorage();

  Future<void> storeKey({required String key, required String value}) async {
    await secureStorage.write(key: key, value: value);
  }

  Future<String?> readKey({required String key}) async {
    return await secureStorage.read(key: key);
  }
}
