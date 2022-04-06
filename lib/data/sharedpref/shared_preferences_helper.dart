import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  final SharedPreferences _sharedPreference;

  SharedPreferenceHelper(this._sharedPreference);

  // key
  static const THEME_STATUS = "THEME_STATUS";
  static const AUTH_TOKEN = "AUTH_TOKEN";

  // theme
  setDarkTheme(bool value) async {
    _sharedPreference.setBool(THEME_STATUS, value);
  }

  Future<bool> getDarkTheme() async {
    return _sharedPreference.getBool(THEME_STATUS) ?? false;
  }

  // auth
  Future<String?> get authToken async {
    return _sharedPreference.getString(AUTH_TOKEN);
  }

  setAuthToken(String value) async {
    _sharedPreference.setString(AUTH_TOKEN, value);
  }
}
