/* This File is used to display the Attendance Details by using helper methods for skipping etc
  Its the core of the app.
*/

import 'package:attendance/widgets/customAppBar.dart';
import 'package:attendance/widgets/attendance_progess.dart';
import 'package:attendance/widgets/background_widget.dart';
import 'package:attendance/widgets/subject_card.dart';
import 'package:attendance/widgets/util_tab.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  final Map<String, dynamic> attendanceData;
  final Map<String, dynamic> subjectsData;

  const HomeScreen({
    super.key,
    required this.attendanceData,
    required this.subjectsData,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, String>> attendanceDetails = [];
  double _totalAttendancePercentage = 0;

  void parseAttendanceData() {
    List<String> headers = List<String>.from(widget.attendanceData['title']);
    List<dynamic> rows = List<dynamic>.from(widget.attendanceData['data']);
    _totalAttendancePercentage = double.tryParse(
            widget.attendanceData['data'][12].toString().replaceAll('%', '')) ??
        0;

    if (rows.isNotEmpty) {
      List<Map<String, String>> parsedData = [];

      for (int i = 3; i < headers.length - 2; i++) {
        String title = headers[i];
        String value = rows[i];

        String percentage = '';
        String raw = value;

        if (value.contains('(') && value.contains('%')) {
          percentage = value.split('(')[1].split('%')[0]; // just "98"
        }

        parsedData.add({
          "title": title,
          "value": percentage,
          "raw": raw,
        });
      }

      setState(() {
        attendanceDetails = parsedData;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    print("Data of home ${widget.attendanceData}");
    parseAttendanceData();
    print(attendanceDetails); // !! For ensuring whether setState() worked !!
  }

  final List<String> items = const ['90', '80', '75'];
  String selectedValue = '90';

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: customAppBar("BUNKIFY"),
      body: Stack(
        children: [
          BackgroundWidget(), // Background Image
          // Scrollable content
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                top: screenHeight * 0.12,
                bottom: MediaQuery.of(context).viewInsets.bottom + 70,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  _totalAttendancePercentageCard(), // Total Attendance Percentage
                  _attendancePercentageDropdown(), // [ 90, 80, 75 ]
                  SizedBox(height: screenHeight * 0.025),
                  ...attendanceDetails.map(
                    (item) =>
                        SubjectCard(item: item, selectedValue: selectedValue),
                  ), // Builds each Subject Attendance data
                  SizedBox(
                    height: MediaQuery.of(context).viewInsets.bottom + 50,
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: UtilTab(
          attendanceDetails: widget.attendanceData,
          subjectsDetails: widget.subjectsData,
          selectedIndex: 0,
        ),
      ),
    );
  }

  Widget _totalAttendancePercentageCard() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.13,
          width: MediaQuery.of(context).size.width - 20,
          child: Card(
            color: Colors.transparent,
            surfaceTintColor: const Color(0xFFE1E1E1),
            elevation: 4,
            margin: const EdgeInsets.symmetric(horizontal: 21),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(18),
            ),
            child: ListTile(
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 10).copyWith(top: 23),
              title: Text(
                "Total Attendance Percentage",
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                  fontSize: 13,
                ),
              ),
              trailing: AttendanceProgress(
                percent: (_totalAttendancePercentage / 100).clamp(0.0, 1.0),
                label: _totalAttendancePercentage.toString(),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _attendancePercentageDropdown() {
    return Container(
      margin: const EdgeInsets.only(top: 20, right: 30),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.blue, width: 2),
      ),
      child: DropdownButton<String>(
        value: selectedValue,
        icon: Icon(Icons.arrow_drop_down, color: Colors.white),
        dropdownColor: Colors.black,
        underline: SizedBox(),
        style: GoogleFonts.poppins(fontSize: 14, color: Colors.white),
        items: items
            .map((item) => DropdownMenuItem<String>(
                  value: item,
                  child: Text(item),
                ))
            .toList(),
        onChanged: (value) {
          setState(() {
            selectedValue = value!;
          });
        },
      ),
    );
  }
}
