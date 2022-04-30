import 'package:money_note/consts/app_theme.dart';
import 'package:money_note/data/sharedpref/shared_preferences_helper.dart';
import 'package:flutter/material.dart';

class ThemeProvider with ChangeNotifier {
  final SharedPreferenceHelper _sharedPreferenceHelper;

  ThemeProvider(this._sharedPreferenceHelper);

  bool _isDarkMode = false;

  bool get isDarkMode => _isDarkMode;

  void setDarkMode({bool? value}) {
    _isDarkMode = value ?? !_isDarkMode;
    _sharedPreferenceHelper.setDarkTheme(_isDarkMode);
    notifyListeners();
  }

  Future<bool> getDarkMode() async {
    final enable = await _sharedPreferenceHelper.getDarkTheme();
    _isDarkMode = enable;
    notifyListeners();
    return enable;
  }

  ThemeData get getThemeData {
    return _isDarkMode ? themeDarkData : themeData;
  }
}
