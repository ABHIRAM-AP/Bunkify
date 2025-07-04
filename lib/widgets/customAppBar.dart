import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

PreferredSizeWidget customAppBar(String title, {VoidCallback? onBack}) {
  return AppBar(
    leading: onBack != null
        ? Padding(
            padding: const EdgeInsets.only(left: 18.0),
            child: IconButton(
              icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
              onPressed: onBack,
            ),
          )
        : null,
    automaticallyImplyLeading: false,
    title: Text(
      title,
      style: GoogleFonts.poppins(
        fontWeight: FontWeight.bold,
        color: Colors.white,
        fontSize: 24,
      ),
    ),
    backgroundColor: Colors.transparent,
    elevation: 7,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        bottomLeft: Radius.circular(25),
        bottomRight: Radius.circular(25),
      ),
    ),
  );
}
