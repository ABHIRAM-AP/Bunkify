import 'dart:convert';
import 'package:attendance/screens/home_screen.dart';
import 'package:attendance/screens/loading_screen.dart';
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

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (_) => const LoadingScreen(),
    );

    final data = await APISERVICES.sendLoginRequest(userID, password);
    final attendance = data?['attendance'];
    final headers = attendance?['headers'];
    final rows = attendance?['data'];
    final internals = data?['internal_marks'];

    Navigator.of(context).pop();

    debugPrint("Headers: $headers");
    debugPrint("Rows: $rows");
    debugPrint("Internals: $internals");

    if (headers != null &&
        headers.isNotEmpty &&
        rows != null &&
        rows.isNotEmpty) {
      await APISERVICES.saveCredentials(userID, password);
      debugPrint("Data is $data");

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => HomeScreen(
            attendanceData: attendance,
            internals: internals ?? [],
          ),
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
                        "BUNKIFY",
                        style: GoogleFonts.poppins(
                          fontSize: 48,
                          color: Colors.white,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 85.0, bottom: 10),
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
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0, bottom: 18),
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
                  const SizedBox(height: 35),
                  ElevatedButton(
                    onPressed: () {
                      loginUser();
                    },
                    style: ButtonStyle(
                      elevation: WidgetStatePropertyAll(8),
                      backgroundColor: WidgetStatePropertyAll(
                        Color(0xFFBB6E68),
                      ),
                      padding: WidgetStatePropertyAll(
                        EdgeInsets.symmetric(horizontal: 80, vertical: 16),
                      ),
                    ),
                    child: Text(
                      "Login",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 22.0),
                    child: Text(
                      "A perfect companion for you to bunk classes :)",
                      style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 12.7,
                        fontWeight: FontWeight.w400,
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
