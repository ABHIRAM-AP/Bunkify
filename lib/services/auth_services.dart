import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  static Future<void> storeData(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('attendanceData', jsonEncode(data['attendance']));
    prefs.setString('internalMarks', jsonEncode(data['internal_marks']));
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('attendanceData');
    await prefs.remove('internalMarks');
    await prefs.remove('userID');
    await prefs.remove('password');
  }
}
