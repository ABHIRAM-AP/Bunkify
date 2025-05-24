import 'package:attendance/widgets/util_tab.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class InternalsPage extends StatefulWidget {
  final List<dynamic> internals;
  final Map<String, dynamic> attendanceDetails;

  const InternalsPage({
    super.key,
    required this.internals,
    required this.attendanceDetails,
  });
  @override
  State<InternalsPage> createState() => _InternalsPageState();
}

class _InternalsPageState extends State<InternalsPage> {
  late String obtainedMarks;
  late String maximumMarks;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      extendBody: true,
      appBar: AppBar(
        title: Text(
          'BUNK MATE',
          style: GoogleFonts.poppins(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            fontSize: 24,
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 7,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(25),
            bottomRight: Radius.circular(25),
          ),
        ),
      ),
      body: Stack(
        children: [
          // Background image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage('assets/image.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),

          // Main content area with cards, scrollable
          Padding(
            padding: EdgeInsets.only(
              top: 40,
              bottom: MediaQuery.of(context).viewInsets.bottom + 70,
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: widget.internals.length,
                    itemBuilder: (context, index) {
                      final item = widget.internals[index];
                      obtainedMarks = item['marks_obtained'];
                      maximumMarks = item['max_marks'];
                      return Padding(
                        padding: const EdgeInsets.only(top: 40.0),
                        child: Card(
                          color: Colors.transparent,
                          surfaceTintColor: const Color(0xFFE1E1E1),
                          elevation: 4,
                          margin: EdgeInsets.symmetric(horizontal: 21),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: SizedBox(
                            height: 110,
                            child: ListTile(
                              title: Padding(
                                padding: const EdgeInsets.only(
                                  left: 16,
                                  bottom: 10,
                                ),
                                child: Text(
                                  item['subject_name'] ?? 'No Name',
                                  style: GoogleFonts.poppins(
                                    fontSize: 15,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              subtitle: Padding(
                                padding: const EdgeInsets.only(
                                  left: 20,
                                ),
                                child: Text(
                                  item['subject_code'],
                                  style: GoogleFonts.poppins(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w300,
                                      color: Colors.white),
                                ),
                              ),
                              trailing: Padding(
                                padding:
                                    const EdgeInsets.only(top: 20, left: 24.0),
                                child: Text(
                                  "$obtainedMarks / $maximumMarks",
                                  style: GoogleFonts.poppins(
                                    fontSize: 13,
                                    color: Colors.white,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: UtilTab(
        internals: widget.internals,
        attendanceDetails: widget.attendanceDetails,
      ),
    );
  }
}
