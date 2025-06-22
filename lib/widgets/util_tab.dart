import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:attendance/screens/home_screen.dart';
import 'package:attendance/screens/internals.dart';
import 'package:attendance/screens/login_screen_normal.dart';
import 'package:attendance/services/auth_services.dart';

class UtilTab extends StatelessWidget {
  final List<dynamic> internals;
  final Map<String, dynamic> attendanceDetails;

  const UtilTab({
    super.key,
    required this.internals,
    required this.attendanceDetails,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 20.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(
              sigmaX: 15, sigmaY: 15), // stronger blur for image background
          child: Container(
            height: 65,
            decoration: BoxDecoration(
              color: Colors.white
                  .withOpacity(0.1), // semi-transparent for glass effect
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Colors.white.withOpacity(0.2),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.15),
                  blurRadius: 12,
                  offset: Offset(0, 6),
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildIcon(
                  icon: Icons.home_outlined,
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => HomeScreen(
                          attendanceData: attendanceDetails,
                          internals: internals,
                        ),
                      ),
                    );
                  },
                ),
                _buildIcon(
                  icon: Icons.assignment_turned_in_rounded,
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => InternalsPage(
                          internals: internals,
                          attendanceDetails: attendanceDetails,
                        ),
                      ),
                    );
                  },
                ),
                _buildIcon(
                  icon: Icons.logout_outlined,
                  onTap: () async {
                    await AuthServices.logout();
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const LoginScreen()),
                      (route) => false,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon({required IconData icon, required VoidCallback onTap}) {
    return InkWell(
      borderRadius: BorderRadius.circular(50),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          color: Colors.white.withValues(alpha: 0.08),
          shape: BoxShape.circle,
        ),
        child: Icon(
          icon,
          color: Colors.white,
          size: 26,
        ),
      ),
    );
  }
}
