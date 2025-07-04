import 'package:attendance/screens/home_screen.dart';
import 'package:attendance/widgets/background_widget.dart';
import 'package:attendance/widgets/customAppBar.dart';
import 'package:attendance/widgets/util_tab.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DeveloperPage extends StatefulWidget {
  final Map<String, dynamic> attendanceDetails;
  const DeveloperPage({super.key, required this.attendanceDetails});

  @override
  State<DeveloperPage> createState() => _DeveloperPageState();
}

class _DeveloperPageState extends State<DeveloperPage> {
  String appVersion = '';

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
            ),
          ),
        );
      }),
      body: Stack(
        children: [
          BackgroundWidget(),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const CircleAvatar(
                    radius: 60,
                    // backgroundImage: AssetImage('assets/abhiram.jpg'), // your photo
                  ),
                  const SizedBox(height: 16),
                  Text(
                    "Abhiram A P",
                    style: GoogleFonts.poppins(
                      fontSize: 29,
                      fontWeight: FontWeight.w400,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "\"Tech fuels my passion beyond what any self-proclaimed tech enthusiast could understand.\"",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w400,
                      color: Colors.white70,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // IconButton(
                      //   icon: const Icon(Icons.link),
                      //   onPressed: () => _launchURL('https://github.com/abhiram-ap'),
                      // ),
                      // IconButton(
                      //   icon: const Icon(Icons.email),
                      //   onPressed: () => _launchURL('mailto:abhiram@example.com'),
                      // ),
                      // IconButton(
                      //   icon: const Icon(Icons.account_box),
                      //   onPressed: () => _launchURL('https://linkedin.com/in/abhiram-ap'),
                      // ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Text("App Version: $appVersion"),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: SafeArea(
        child: UtilTab(attendanceDetails: widget.attendanceDetails),
      ),
    );
  }
}
