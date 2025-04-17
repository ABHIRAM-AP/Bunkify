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
    return BottomAppBar(
      color: Colors.transparent,
      elevation: 0,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => HomeScreen(
                      attendanceData: attendanceDetails, internals: internals),
                ),
              );
            },
            icon: Icon(
              Icons.home_outlined,
              color: Colors.white,
              size: 36,
            ),
          ),
          const SizedBox(
            width: 70,
          ),
          IconButton(
            onPressed: () {
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
            icon: Icon(
              Icons.assignment_turned_in_rounded,
              color: Colors.white,
              size: 36,
            ),
          ),
        ],
      ),
    );
  }
}
