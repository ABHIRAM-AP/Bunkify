import 'dart:convert';
import 'package:attendance/screens/home_screen.dart';
import 'package:attendance/widgets/etlab_id_textfield.dart';
import 'package:attendance/widgets/password_textfield.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:attendance/api_services/login_request.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final TextEditingController etlabidController;
  late final TextEditingController passwordController;
  // bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    etlabidController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    etlabidController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        behavior: SnackBarBehavior.floating,
        backgroundColor: Colors.redAccent,
      ),
    );
  }

  Future<void> storeData(Map<String, dynamic> data) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    // Convert JSON data to a string and store it
    prefs.setString('attendanceData', jsonEncode(data['attendance']));
    prefs.setString('internalMarks', jsonEncode(data['internal_marks']));
  }

  Future<void> loginUser() async {
    final userID = etlabidController.text.trim();
    final password = passwordController.text.trim();

    if (userID.isEmpty || password.isEmpty) {
      showSnackBar("ID and password cannot be empty.");
      return;
    }

    final data = await APISERVICES.sendLoginRequest(userID, password);

    if (data != null) {
      await APISERVICES.saveCredentials(userID, password);
      debugPrint("Data is $data");
      // Parsing internal marks data
      List<dynamic> internalResponse = data['internal_marks'];

      // Parsing attendance data
      Map<String, dynamic> attendanceResponse = data['attendance'];

      // debugPrint("Internal Marks Data: $internalResponse");
      debugPrint("Attendance Data: $attendanceResponse");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(
            attendanceData: attendanceResponse,
            internals: internalResponse,
          ),
          // builder: (context) => InternalsPage(internals: internalResponse),
        ),
      );
    } else {
      showSnackBar("Invalid Credentials");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage('assets/image.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),

          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "BUNK MATE",
                        style: GoogleFonts.poppins(
                          fontSize: 44,
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 70.0, bottom: 10),
                        child: Text(
                          "Hey There Let's have a Tea :)",
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            color: Colors.white70,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                  //Login Text
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0, bottom: 10),
                    child: Row(
                      children: [
                        Text(
                          "Login",
                          style: GoogleFonts.poppins(
                            fontSize: 23,
                            letterSpacing: 1,
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),

                  EtlabID(etlabidController: etlabidController),
                  PasswordTextfield(passwordController: passwordController),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () {
                      loginUser();
                    },
                    style: ButtonStyle(
                      elevation: WidgetStatePropertyAll(8),
                      backgroundColor:
                          WidgetStatePropertyAll(Color(0xFF5E5B59)),
                      padding: WidgetStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 80, vertical: 16),
                      ),
                    ),
                    child: Text(
                      "Login",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 35.0),
                    child: Text(
                      "A perfect companion for you to bunk classes :)",
                      style: GoogleFonts.quicksand(
                        color: Colors.white,
                        fontSize: 12.8,
                        fontWeight: FontWeight.w300,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  )
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
