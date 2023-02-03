import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  // const keys
  static String accessToken = "access_token";

  static const FlutterSecureStorage _storage = FlutterSecureStorage();

  static Future<String?> getString(String key, {String defValue = ''}) {
    return _storage.read(key: key);
  }

  static Future<void> putString(String key, String value) {
    return _storage.write(key: key, value: value);
  }
}
