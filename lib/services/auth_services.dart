/* This File is for storing attendance data and log out.*/

import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  static Future<void> storeData(Map<String, dynamic> data) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString('attendanceData', jsonEncode(data['attendance']));
  }

  static Future<void> logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('attendanceData');
    await prefs.remove('userID');
    await prefs.remove('password');
  }
}
