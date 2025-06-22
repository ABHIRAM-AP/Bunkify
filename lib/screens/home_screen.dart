import 'package:attendance/widgets/util_tab.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  final Map<String, dynamic> attendanceData;
  final List<dynamic> internals;
  const HomeScreen(
      {super.key, required this.attendanceData, required this.internals});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Map<String, String>> attendanceDetails = [];

  void parseAttendanceData() {
    List<String> headers = List<String>.from(widget.attendanceData['headers']);
    List<List<dynamic>> rows =
        List<List<dynamic>>.from(widget.attendanceData['data']);

    if (rows.isNotEmpty) {
      List<Map<String, String>> parsedData = [];

      for (int i = 3; i < headers.length - 2; i++) {
        String title = headers[i];
        String value = rows[0][i];

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

  int skippableClasses(int attended, int total, double requiredPercent) {
    double x = (attended - (requiredPercent * total)) / requiredPercent;
    int skippable = x.floor();
    return skippable >= 0 ? skippable : 0;
  }

  @override
  void initState() {
    super.initState();
    print("Data of home ${widget.attendanceData}");
    parseAttendanceData();
    print(attendanceDetails); // !! For ensuring whether setState() worked !!
  }

  final items = ['90', '80', '75'];
  late String selectedValue = items[0];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        automaticallyImplyLeading: false,
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
          // Background Image
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage('assets/image.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          // Scrollable content
          Padding(
            padding: EdgeInsets.only(
              top: 65,
              bottom: MediaQuery.of(context).viewInsets.bottom + 70,
            ),
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                  top: 100,
                  bottom: MediaQuery.of(context).viewInsets.bottom + 70,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    // Dropdown on top of cards with spacing
                    Container(
                      margin: const EdgeInsets.only(
                        right: 30,
                      ),
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
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: Colors.white,
                        ),
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
                    ),
                    const SizedBox(height: 20),
                    // Manual list of cards
                    ...attendanceDetails.map(
                      (item) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 20.0),
                          child: Card(
                            color: Colors.transparent,
                            surfaceTintColor: const Color(0xFFE1E1E1),
                            elevation: 4,
                            margin: const EdgeInsets.symmetric(horizontal: 21),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: const Color(0xFFBB6E68), width: 2),
                              ),
                              height: 110,
                              child: ListTile(
                                title: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 16, bottom: 10),
                                  child: Text(
                                    item['title'] ?? '',
                                    style: GoogleFonts.poppins(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 20, bottom: 10),
                                  child: Text(
                                    () {
                                      try {
                                        String raw = item['raw'] ?? '';
                                        String fraction = raw.split(' ')[
                                            0]; // Gets the value like this "47/48"
                                        List<String> parts =
                                            fraction.split('/');
                                        int attended = int.parse(parts[0]);
                                        int total = int.parse(parts[1]);
                                        double percent =
                                            double.parse(selectedValue) / 100;

                                        int skips = skippableClasses(
                                            attended, total, percent);
                                        return "Can skip $skips classes";
                                      } catch (e) {
                                        return "Oh Crap!Logic or Something in Function Failed";
                                      }
                                    }(), // IIFE -> For Immediately Call this function after dropdown value selected & logic calculations and return the value  :)
                                    style: GoogleFonts.poppins(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                                trailing: Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    SizedBox(
                                      height: 52,
                                      width: 52,
                                      child: CircularProgressIndicator(
                                        value: () {
                                          try {
                                            String raw = item['raw'] ?? '';

                                            // Check if the raw string contains the expected format
                                            if (raw.contains('(') &&
                                                raw.contains('%')) {
                                              String percentString = raw
                                                  .split('(')[1]
                                                  .split('%')[0]
                                                  .trim();
                                              double percent =
                                                  double.parse(percentString) /
                                                      100;

                                              return percent.clamp(0.0, 1.0);
                                            } else {
                                              return 0.0;
                                            }
                                          } catch (e) {
                                            print('Error: $e');
                                            return 0.0;
                                          }
                                        }(),
                                        strokeWidth: 4,
                                        color: const Color(0xFFBB6E68),
                                      ),
                                    ),
                                    Text(
                                      item['value'] ?? '',
                                      style: GoogleFonts.poppins(
                                        fontSize: 13.6,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w400,
                                      ),
                                    ),
                                  ],
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
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: UtilTab(
          internals: widget.internals,
          attendanceDetails: widget.attendanceData,
        ),
      ),
    );
  }
}
