/* This File is used to display the Etlab Password textfield*/

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PasswordTextfield extends StatefulWidget {
  final TextEditingController passwordController;
  const PasswordTextfield({super.key, required this.passwordController});

  @override
  State<PasswordTextfield> createState() => _PasswordTextfieldState();
}

class _PasswordTextfieldState extends State<PasswordTextfield> {
  bool _isObscured = true;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 23, vertical: 17),
      child: TextField(
        style: TextStyle(color: Colors.white),
        keyboardType: TextInputType.visiblePassword,
        controller: widget.passwordController,
        obscureText: _isObscured,
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(
              30,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(
              30,
            ),
          ),
          hintText: 'Enter Password',
          hintStyle: GoogleFonts.poppins(
            fontSize: 14,
            color: Colors.white70,
          ),
          suffixIcon: IconButton(
            onPressed: () {
              setState(() {
                _isObscured = !_isObscured;
              });
            },
            icon: Icon(_isObscured ? Icons.visibility_off : Icons.visibility),
          ),
        ),
      ),
    );
  }
}
