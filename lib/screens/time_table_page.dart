/* 
This File is used to display the Subjects with name for students to reduce the complexity while using the home screen
*/

import 'package:attendance/widgets/background_widget.dart';
import 'package:attendance/widgets/util_tab.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TimeTablePage extends StatefulWidget {
  final Map<String, dynamic> attendanceDetails;
  final Map<String, dynamic> subjectsDetails;
  const TimeTablePage({
    super.key,
    required this.attendanceDetails,
    required this.subjectsDetails,
  });

  @override
  State<TimeTablePage> createState() => _TimeTablePageState();
}

class _TimeTablePageState extends State<TimeTablePage> {
  @override
  void initState() {
    super.initState();
    printDetails();
  }

  void printDetails() {
    print("Details\n");
    widget.subjectsDetails.forEach((code, name) {
      print("Code: $code, Name: $name\n");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      body: Stack(
        children: [
          BackgroundWidget(),
          SafeArea(
            child: SingleChildScrollView(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(height: 16),
                Text(
                  "Subjects",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                ...widget.subjectsDetails.entries.map(
                  (entry) {
                    final subjectCode = entry.key;
                    final subjectName = entry.value;

                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Card(
                        color: Colors.transparent,
                        surfaceTintColor: const Color(0xFFE1E1E1),
                        elevation: 4,
                        margin: const EdgeInsets.symmetric(
                            horizontal: 15, vertical: 9),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16, bottom: 10),
                          child: ListTile(
                            title: Text(
                              subjectCode,
                              style: GoogleFonts.poppins(
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                                color: Colors.white,
                              ),
                            ),
                            subtitle: Text(
                              subjectName,
                              style: GoogleFonts.poppins(
                                fontSize: 12.5,
                                color: Colors.white70,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ).toList(),
              ],
            )),
          )
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: UtilTab(
          attendanceDetails: widget.attendanceDetails,
          subjectsDetails: widget.subjectsDetails,
        ),
      ),
    );
  }
}
