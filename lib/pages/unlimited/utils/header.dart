import 'package:adwis_frontend/utils/functions/hex_to_rgba.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,
      child: Center(
        // Centers the text inside the SizedBox
        child: Text(
          "Choose your Subscription",
          textAlign: TextAlign.center, // Ensures multiline text is centered
          style: TextStyle(
            fontFamily: GoogleFonts.inter().fontFamily,
            fontSize: 40,
            color: HexToRgba().convert("080705", 1),
            fontWeight: FontWeight.w700,
            decoration: TextDecoration.none,
          ),
        ),
      ),
    );
  }
}
