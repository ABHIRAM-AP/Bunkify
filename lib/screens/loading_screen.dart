import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Center(
          child: Lottie.asset(
            'assets/running.json',
            fit: BoxFit.contain,
            width: 300,
            height: 300,
          ),
        ),
      ),
    );
  }
}
