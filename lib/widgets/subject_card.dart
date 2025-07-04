import 'package:attendance/utils/attendance_helper.dart';
import 'package:attendance/widgets/attendance_progess.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubjectCard extends StatelessWidget {
  final Map<String, dynamic> item;
  final String selectedValue;
  const SubjectCard({
    super.key,
    required this.item,
    required this.selectedValue,
  });

  @override
  Widget build(BuildContext context) {
    String subjectTitle = item['title'] ?? '';
    String raw = item['raw'] ?? ''; // eg:- raw: 47/48 (98%)
    String percentage = item['value'] ?? '';
    String fraction = '';
    String subtitleText = '';

    try {
      fraction = raw.split(' ')[0]; // e.g., "47/48"
      List<String> parts = fraction.split('/');
      int attended = int.parse(parts[0]);
      int total = int.parse(parts[1]);
      double required = double.parse(selectedValue) / 100;

      if (attended >= required * total) {
        int skips =
            AttendanceHelper.skippableClasses(attended, total, required);
        subtitleText = "Can skip $skips classes till $selectedValue%";
      } else {
        int requiredClassesForThreshold =
            AttendanceHelper.requiredClassToReachThreshold(
                attended, total, required);
        subtitleText =
            "Need $requiredClassesForThreshold classes to reach $selectedValue%";
      }
    } catch (_) {
      subtitleText = "Attendance Data not Available";
    }

    return Padding(
      padding: const EdgeInsets.only(bottom: 25.0),
      child: Card(
        color: Colors.transparent,
        surfaceTintColor: const Color(0xFFE1E1E1),
        elevation: 4,
        margin: const EdgeInsets.symmetric(horizontal: 21),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Container(
          height: 110,
          padding: const EdgeInsets.only(top: 17),
          child: ListTile(
            title: Padding(
              padding: const EdgeInsets.only(left: 16, bottom: 10),
              child: Row(
                children: [
                  Text(
                    subjectTitle,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                  if (fraction.isNotEmpty)
                    Text(
                      "\t\t($fraction)",
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                      ),
                    ),
                ],
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.only(left: 20, bottom: 10),
              child: Text(
                subtitleText,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w400,
                  color: Colors.white70,
                ),
              ),
            ),
            trailing: AttendanceProgress(
              percent: double.tryParse(percentage) != null
                  ? double.parse(percentage) / 100
                  : 0.0,
              label: percentage.isNotEmpty ? percentage : 'N/A',
            ),
          ),
        ),
      ),
    );
  }
}
