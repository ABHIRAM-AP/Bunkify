/*  
This file contains functions and class for sending login request to backend(render), saving and retreiving the stored credentials like userID, password
*/

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class APISERVICES {
  static const url = "https://etlab-scrapper.onrender.com/get_data";

  // Send login request and return the list of internals and attendance data
  static Future<Map<String, dynamic>?> sendLoginRequest(
      String userID, String password) async {
    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(
          {
            'userID': userID,
            'password': password,
          },
        ),
      );

      if (response.statusCode == 200) {
        var decodedResponse = jsonDecode(response.body);
        return decodedResponse;
      } else {
        debugPrint("Login Failed: ${response.body}");
        return null;
      }
    } catch (e) {
      debugPrint("Exception occurred during login request: $e");
      return null;
    }
  }

  // Save credentials to SharedPreferences
  static Future<void> saveCredentials(String userID, String password) async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    await pref.setBool('isLoggedIn', true);
    await pref.setString('userID', userID);
    await pref.setString('password', password);
  }

  // Retrieve stored credentials from SharedPreferences
  static Future<Map<String, String>?> getStoredCredentials() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    String? userID = pref.getString('userID');
    String? password = pref.getString('password');

    // Check if both credentials exist and return them as a map
    if (userID != null && password != null) {
      return {
        'userID': userID,
        'password': password,
      };
    } else {
      debugPrint("Credentials not found.");
      return null;
    }
  }
}
