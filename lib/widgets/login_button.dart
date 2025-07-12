/* This File is used to display the Login Button*/

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginButton extends StatelessWidget {
  final VoidCallback loginUser;
  const LoginButton({super.key, required this.loginUser});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: loginUser,
          style: ButtonStyle(
            elevation: const WidgetStatePropertyAll(8),
            backgroundColor: const WidgetStatePropertyAll(Color(0xFFBB6E68)),
            padding: const WidgetStatePropertyAll(
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
        //Text under Login Button
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22.0),
          child: Text(
            "A perfect companion for you to bunk classes :)",
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 12.7,
              fontWeight: FontWeight.w400,
            ),
          ),
        )
      ],
    );
  }
}
