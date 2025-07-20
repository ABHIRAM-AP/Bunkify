/* This File is used to display the animation screen while fetching data after login*/

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:google_fonts/google_fonts.dart';

class AnimationScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withValues(alpha: 0.85),
      extendBodyBehindAppBar: true,
      body: SizedBox.expand(
        child: Center(
          child: SizedBox(
            width: 250,
            child: DefaultTextStyle(
              style: GoogleFonts.poppins(
                fontSize: 48,
                color: Colors.white,
                fontWeight: FontWeight.w800,
              ),
              child: AnimatedTextKit(
                animatedTexts: [
                  TypewriterAnimatedText(
                    'BUNKIFY',
                    speed: const Duration(milliseconds: 150),
                    cursor: '',
                    textAlign: TextAlign.center,
                  ),
                ],
                repeatForever: true,
                isRepeatingAnimation: true,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
