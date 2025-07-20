/* This File is used to display the details of app and about the developer(Myself)*/

import 'package:attendance/screens/home_screen.dart';
import 'package:attendance/widgets/background_widget.dart';
import 'package:attendance/widgets/customAppBar.dart';
import 'package:attendance/widgets/util_tab.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

class DeveloperPage extends StatefulWidget {
  final Map<String, dynamic> attendanceDetails;
  final Map<String, dynamic> subjectsDetails;
  const DeveloperPage(
      {super.key,
      required this.attendanceDetails,
      required this.subjectsDetails});

  @override
  State<DeveloperPage> createState() => _DeveloperPageState();
}

class _DeveloperPageState extends State<DeveloperPage> {
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    try {
      final launched = await launchUrl(uri);
      if (!launched) {
        throw "Could not launch $url";
      }
    } catch (e) {
      debugPrint("Launch error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  String appVersion = '1.0.0';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: customAppBar("About", onBack: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => HomeScreen(
              attendanceData: widget.attendanceDetails,
              subjectsData: widget.subjectsDetails,
            ),
          ),
        );
      }),
      body: Stack(
        children: [
          BackgroundWidget(),
          SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).viewInsets.top + 100,
                left: MediaQuery.of(context).viewInsets.left + 12,
              ),
              child: Column(
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                  Text(
                    "📱 About the App",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.008),
                  Text(
                    "This app helps students track attendance and visualize subject-wise details efficiently.",
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w300,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                  Text(
                    "🚫 Disclaimer",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.008),
                  Text(
                    "Bunkify does not promote or endorse class bunking. Students must take responsiblity for their actions.",
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.08),
                  Text(
                    "Developed by Abhiram A P\n\nFollow Here :)",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      //Linkedin
                      _buildGestureDetector("assets/linkedin-2.png",
                          "https://www.linkedin.com/in/abhiram-a-p-980044284/"),

                      //GitHub
                      _buildGestureDetector(
                          "assets/github.png", "https://github.com/ABHIRAM-AP"),

                      //Instagram
                      _buildGestureDetector("assets/insta.png",
                          "https://www.instagram.com/abhii0305/"),
                    ],
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.03),
                  Text(
                    "App Version: $appVersion",
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.white,
                    ),
                  ),
                  SizedBox(height: MediaQuery.of(context).size.height * 0.05),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: UtilTab(
          attendanceDetails: widget.attendanceDetails,
          subjectsDetails: widget.subjectsDetails,
          selectedIndex: 2,
        ),
      ),
    );
  }

  Widget _buildGestureDetector(String assetPath, String socialMediaPath) {
    return GestureDetector(
      onTap: () async {
        try {
          await _launchURL(socialMediaPath);
        } catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("Failed to launch link")),
          );
        }
      },
      child: ImageIcon(
        AssetImage(assetPath),
        size: 43,
        color: Colors.white,
      ),
    );
  }
}
