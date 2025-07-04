import 'dart:ui';
import 'package:attendance/screens/developer_page.dart';
import 'package:flutter/material.dart';
import 'package:attendance/screens/home_screen.dart';
import 'package:attendance/screens/login_screen_normal.dart';
import 'package:attendance/services/auth_services.dart';
import 'package:google_fonts/google_fonts.dart';

class UtilTab extends StatelessWidget {
  final Map<String, dynamic> attendanceDetails;

  const UtilTab({
    super.key,
    required this.attendanceDetails,
  });
  void _showAlertDialogForLogOut(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Container(
        child: AlertDialog(
          elevation: 10,
          backgroundColor: const Color(0xFF2A2A2A),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(30),
          ),
          actionsAlignment: MainAxisAlignment.spaceAround,
          title: Text(
            'Logout Confirmation',
            style: GoogleFonts.poppins(fontSize: 20, color: Colors.white70),
          ),
          content: Text(
            'Are you sure you want to log out?',
            style: GoogleFonts.poppins(fontSize: 15, color: Colors.white70),
          ),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.of(context).pop();
                await AuthServices.logout();
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (_) => const LoginScreen()),
                  (route) => false,
                );
              },
              child: Text(
                "Yes",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  color: Colors.green,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text(
                "No",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  color: Colors.red,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0, right: 16.0, bottom: 20.0),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 1.2, sigmaY: 1.2),
          child: Container(
            height: 65,
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(30),
              border: Border.all(
                color: Colors.white.withValues(alpha: 0.2),
                width: 1.2,
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.15),
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
                        ),
                      ),
                    );
                  },
                ),
                _buildIcon(
                  icon: Icons.person,
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => DeveloperPage(
                          attendanceDetails: attendanceDetails,
                        ),
                      ),
                    );
                  },
                ),
                _buildIcon(
                  title: 'LogOut',
                  icon: Icons.logout_outlined,
                  onTap: () => _showAlertDialogForLogOut(context),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildIcon(
      {required IconData icon, required VoidCallback onTap, String? title}) {
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
