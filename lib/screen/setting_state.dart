import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingState with ChangeNotifier {
  bool notifications = true;
  bool sound = true;
  bool vibration = true;
  bool showNotifications = false;
  double textSize = 14.0;
  bool isDarkMode = false;

  SettingState() {
    loadSettings();
  }

  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    notifications = prefs.getBool('notifications') ?? true;
    sound = prefs.getBool('sound') ?? true;
    vibration = prefs.getBool('vibration') ?? true;
    showNotifications = prefs.getBool('showNotifications') ?? false;
    textSize = prefs.getDouble('textSize') ?? 14.0;
    isDarkMode = prefs.getBool('isDarkMode') ?? false;
    notifyListeners();
  }

  void setTextSize(double size) async {
    textSize = size;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('textSize', size);
    notifyListeners();
  }

  void toggleDarkMode(bool value) async {
    isDarkMode = value;
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', value);
    notifyListeners();
  }

  void updateBoolSetting(String key, bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(key, value);
    switch (key) {
      case 'notifications':
        notifications = value;
        break;
      case 'sound':
        sound = value;
        break;
      case 'vibration':
        vibration = value;
        break;
      case 'showNotifications':
        showNotifications = value;
        break;
    }
    notifyListeners();
  }
}
