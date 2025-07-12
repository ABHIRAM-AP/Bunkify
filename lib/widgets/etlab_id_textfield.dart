/* This File is used to display the Etlab ID textfield*/

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class EtlabID extends StatefulWidget {
  final TextEditingController etlabidController;
  const EtlabID({super.key, required this.etlabidController});

  @override
  State<EtlabID> createState() => _EtlabIDState();
}

class _EtlabIDState extends State<EtlabID> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: TextField(
        controller: widget.etlabidController,
        style: TextStyle(color: Colors.white),
        decoration: InputDecoration(
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 25, vertical: 17),
          hintText: "Enter your Etlab ID",
          hintStyle: GoogleFonts.poppins(
            color: Colors.white70,
            fontSize: 14,
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(30),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        keyboardType: TextInputType.number,
      ),
    );
  }
}
