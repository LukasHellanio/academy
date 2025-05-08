import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthStorageService {
  static const _storage = FlutterSecureStorage();
  static const _isLoggedInKey = 'is_logged_in';

  static Future<void> setLoggedIn(bool value) async {
    await _storage.write(key: _isLoggedInKey, value: value ? 'true' : 'false');
  }

  static Future<bool> isLoggedIn() async {
    final value = await _storage.read(key: _isLoggedInKey);
    return value == 'true';
  }

  static Future<void> logout() async {
    await _storage.delete(key: _isLoggedInKey);
  }
}
