import 'package:attendance/screens/animation_screen.dart';
import 'package:attendance/widgets/background_widget.dart';
import 'package:attendance/widgets/login_button.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:attendance/services/auth_services.dart';
import 'package:attendance/screens/home_screen.dart';

import 'package:attendance/widgets/etlab_id_textfield.dart';
import 'package:attendance/widgets/password_textfield.dart';
import 'package:attendance/api_services/login_request.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoadingAnimationScreen = false;
  late final TextEditingController etlabidController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    etlabidController = TextEditingController();
    passwordController = TextEditingController();
    _checkSavedCredentials();
  }

  @override
  void dispose() {
    etlabidController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void showAnimationScreen() {
    _isLoadingAnimationScreen = true;
    showGeneralDialog(
      context: context,
      barrierDismissible: false,
      barrierColor: Colors.black.withValues(alpha: 0.85),
      transitionDuration: Duration(milliseconds: 200),
      pageBuilder: (context, animation, secondaryAnimation) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: AnimationScreen(),
        );
      },
    );
  }

  void hideAnimationScreen() {
    if (_isLoadingAnimationScreen && mounted) {
      Navigator.of(context).pop();
      _isLoadingAnimationScreen = false;
    }
  }

  Future<void> _checkSavedCredentials() async {
    final savedCred = await APISERVICES.getStoredCredentials();
    if (savedCred != null) {
      final userID = savedCred['userID']!;
      final password = savedCred['password']!;

      // Delay navigation until after the first frame
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        showAnimationScreen();
        await loginAndNavigate(userID, password);
      });
    }
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

  Future<void> loginUser() async {
    final userID = etlabidController.text.trim();
    final password = passwordController.text.trim();

    if (userID.isEmpty || password.isEmpty) {
      showSnackBar("ID and password cannot be empty.");
      return;
    }
    showAnimationScreen();
    await loginAndNavigate(userID, password);
  }

  Future<void> loginAndNavigate(String userID, String password) async {
    try {
      final data = await APISERVICES.sendLoginRequest(userID, password);

      final attendance = data?['attendance'];
      final headers = attendance?['title'];
      final rows = attendance?['data'];

      if (headers != null &&
          headers.isNotEmpty &&
          rows != null &&
          rows.isNotEmpty) {
        await APISERVICES.saveCredentials(userID, password);
        debugPrint("Fetched Data: $data");

        // Save data locally
        await AuthServices.storeData(data!);

        if (mounted) {
          hideAnimationScreen();

          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(
                attendanceData: attendance,
              ),
            ),
          );
        }
      } else {
        if (mounted) Navigator.of(context).pop(); // Close loading screen
        showSnackBar("Invalid Credentials");
      }
    } catch (e) {
      showSnackBar(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        children: [
          // Background image
          BackgroundWidget(),
          Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildText(
                    "BUNKIFY",
                    48,
                    Colors.white,
                    FontWeight.w800,
                    null,
                  ),

                  Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 20),
                    child: _buildText(
                      "Hey There Let's have a Tea :)",
                      13,
                      Colors.white70,
                      FontWeight.w300,
                      null,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 40.0, bottom: 18),
                    child: Row(
                      children: [
                        _buildText(
                            "Login", 23, Colors.white, FontWeight.w600, 1),
                      ],
                    ),
                  ),
                  EtlabID(
                      etlabidController: etlabidController), //Etlab Textfield
                  PasswordTextfield(
                      passwordController:
                          passwordController), // Password Textfield
                  const SizedBox(height: 35),
                  LoginButton(loginUser: loginUser), // Login Button
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget _buildText(String title, double? fontSize, Color? color,
    FontWeight? fontWeight, double? letterSpacing) {
  return Text(
    title,
    style: GoogleFonts.poppins(
      fontSize: fontSize,
      color: color,
      fontWeight: fontWeight,
      letterSpacing: letterSpacing,
    ),
  );
}
