import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefService {
  static late SharedPreferences _preferences;

  static Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }

  static Future<void> saveAccessToken(String token) async {
    await _preferences.setString("accessToken", token);
  }

  static String? getAccessToken() {
    return _preferences.getString("accessToken");
  }

  static Future<void> saveRefreshToken(String token) async {
    await _preferences.setString("refreshToken", token);
  }

  static String? getRefreshToken() {
    return _preferences.getString("refreshToken");
  }

  static Future<void> saveExpiry(String expiry) async {
    await _preferences.setString("expiresAtUtc", expiry);
  }

  static String? getExpiry() {
    return _preferences.getString("expiresAtUtc");
  }

  static Future<void> clear() async {
    await _preferences.clear();
  }

  static Future<void> setOnboardingSeen() async {
    await _preferences.setBool("onboardingSeen", true);
  }

  static bool isOnboardingSeen() {
    return _preferences.getBool("onboardingSeen") ?? false;
  }

  static bool isLoggedIn() {
    final token = getAccessToken();
    return token != null && token.isNotEmpty;
  }
}