import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceHelper {
  final SharedPreferences _sharedPreference;

  SharedPreferenceHelper(this._sharedPreference);

  // key
  static const THEME_STATUS = "THEME_STATUS";

  // theme
  setDarkTheme(bool value) async {
    _sharedPreference.setBool(THEME_STATUS, value);
  }

  Future<bool> getDarkTheme() async {
    return _sharedPreference.getBool(THEME_STATUS) ?? false;
  }
}
