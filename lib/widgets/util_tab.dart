import 'package:attendance/screens/home_screen.dart';
import 'package:attendance/screens/internals.dart';
import 'package:flutter/material.dart';

class UtilTab extends StatelessWidget {
  final List<dynamic> internals;
  final Map<String, dynamic> attendanceDetails;

  const UtilTab(
      {super.key, required this.internals, required this.attendanceDetails});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.transparent, // Make it transparent
      elevation: 0,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home, color: Colors.white),
          label: "Home",
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.mark_email_unread_sharp, color: Colors.white),
          label: "Internals",
        ),
      ],
      onTap: (index) {
        if (index == 0) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(
                attendanceData: attendanceDetails,
                internals: internals,
              ),
            ),
          );
        } else if (index == 1) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => InternalsPage(
                  internals: internals,
                  attendanceDetails: attendanceDetails,
                ),
              ));
        }
      },
    );
  }
}
