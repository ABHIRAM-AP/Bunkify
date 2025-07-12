/* This File is used to represent the attendance circular progress widget*/

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AttendanceProgress extends StatelessWidget {
  final double percent;
  final String label;

  const AttendanceProgress({
    required this.percent,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: 58,
          width: 58,
          child: CircularProgressIndicator(
            value: percent.clamp(0.0, 1.0),
            strokeWidth: 4,
            color: const Color(0xFFBB6E68),
          ),
        ),
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 13.6,
            color: Colors.white,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
