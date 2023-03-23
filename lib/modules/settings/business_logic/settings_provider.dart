import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../constants/prefs_keys/prefs_keys.dart';
import '../../../core/base_providers/base_provider.dart';
import '../model/setting.dart';

class SettingsProvider extends BaseProvider {
  final SharedPreferences _prefs;
  Setting setting = Setting.init();
  SettingsProvider( this._prefs) {
    loadSettings();
  }
  loadSettings() {
    setUserSettings();
    updateUI();
  }

  setUserSettings() {
    if (_prefs.getString(PrefsKeys.languageCode) != null) {
      setting.mobileLanguage = Locale(_prefs.getString(PrefsKeys.languageCode)!);
    } else {
      _prefs.setString(PrefsKeys.languageCode, 'en');
    }
  }

  Future<void> changeLanguage(String languageCode) async {
    _prefs.setString(PrefsKeys.languageCode, languageCode);
    setting.mobileLanguage = Locale(languageCode);
    updateUI();
  }
}
