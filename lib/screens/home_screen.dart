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

  final double requiredPercent = 0.75;

  void parseAttendanceData() {
    List<String> headers = List<String>.from(widget.attendanceData['headers']);
    List<List<dynamic>> rows =
        List<List<dynamic>>.from(widget.attendanceData['data']);

    if (rows.isNotEmpty) {
      List<Map<String, String>> parsedData = [];

      for (int i = 3; i < headers.length - 2; i++) {
        String title = headers[i];
        String value = rows[0][i];

        // Extract only the percentage from the format "47/48 (98%)"
        if (value.contains('(') && value.contains('%')) {
          String percentage = value.split('(')[1].split(')')[0];
          value = percentage;
        }

        parsedData.add({
          "title": title,
          "value": value,
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
    print(attendanceDetails); // Check if it's populated properly after setState
  }

  /* Future<void> fetchAttendance() async {
    print("fetchAttendance() called"); // Debugging line

    String url = "https://etlab-scrapper.onrender.com/get-attendance";

    SharedPreferences pref = await SharedPreferences.getInstance();
    String? EtlabID = pref.getString("username");
    String? password = pref.getString("password");

    if (EtlabID != null && password != null) {
      final response = await http.post(
        Uri.parse(url),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(
          {
            'username': EtlabID,
            'password': password,
          },
        ),
      );

      print("Response status: ${response.statusCode}"); // Debugging line

      if (response.statusCode == 200) {
        print("Raw Response Body: ${response.body}"); // Debugging line

        final data = jsonDecode(response.body);
        print("Decoded Response: $data"); // Check the decoded response

        // Ensure the response contains the expected structure
        if (data is Map<String, dynamic> &&
            data.containsKey('headers') &&
            data.containsKey('data')) {
          List<String> headers = List<String>.from(data['headers']);
          List<List<dynamic>> rows = List<List<dynamic>>.from(data['data']);

          if (rows.isNotEmpty) {
            List<Map<String, String>> partialParsed = [];

            for (int i = 3; i < headers.length - 2; i++) {
              String title = headers[i];
              String value = rows[0][i];

              // Extract only the percentage from the format "47/48 (98%)"
              if (value.contains('(') && value.contains('%')) {
                String percentage = value.split('(')[1].split(')')[0];
                value = percentage;
              }

              partialParsed.add({
                "title": title,
                "value": value,
              });
            }

            setState(() {
              attendanceDetails = partialParsed;
            });

            print("Filtered attendanceDetails: $attendanceDetails");
          }
        } else {
          print("Invalid data structure: $data");
        }
      } else {
        print("Failed to fetch data. Status code: ${response.statusCode}");
      }
    } else {
      print("Username or password is null");
    }
  }
*/
  final items = ['90', '80', '75'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
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
          Container(
            // Background Image
            decoration: BoxDecoration(
              image: DecorationImage(
                image: const AssetImage('assets/image.png'),
                fit: BoxFit.fill,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 150),

                // Dropdown
                Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Colors.blue, width: 2),
                  ),
                  child: DropdownButton<String>(
                    value: items[0],
                    items: items
                        .map((item) => DropdownMenuItem<String>(
                              value: item,
                              child: Text(item),
                            ))
                        .toList(),
                    onChanged: (value) {},
                  ),
                ),

                // Attendance Cards
                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: attendanceDetails.length,
                  itemBuilder: (context, index) {
                    final item = attendanceDetails[index];
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
                              padding:
                                  const EdgeInsets.only(left: 16, bottom: 10),
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
                              padding:
                                  const EdgeInsets.only(left: 20, bottom: 10),
                              child: Text(
                                "Can Skip _____ classes",
                                style: GoogleFonts.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w300,
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
                                    value: 0.7,
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
        ],
      ),
      bottomNavigationBar: UtilTab(
        internals: widget.internals,
        attendanceDetails: widget.attendanceData,
      ),
    );
  }
}
