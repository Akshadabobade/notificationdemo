import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class HeaderWidget extends StatelessWidget {
  const HeaderWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Text(
              "Notification Demo",
              style: GoogleFonts.roboto(
                fontSize: 27.0,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
          ),
          SizedBox(height: 10.0),
          Text(
            "Subtitle",
            style: GoogleFonts.roboto(fontSize: 16.0, color: Colors.black54),
          ),
          SizedBox(height: 20.0),
        ],
      ),
    );
  }
}