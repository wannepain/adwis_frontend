import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class UnlimitedLogo extends StatelessWidget {
  UnlimitedLogo({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          SvgPicture.asset(
            "assets/icons/logo_text.svg",
          ),
          Text(
            "unlimited",
            style: TextStyle(
              decoration: TextDecoration.none,
              fontSize: 20,
              fontFamily: GoogleFonts.inter().fontFamily,
              color: Color.fromRGBO(51, 101, 138, 1),
            ),
          )
        ],
      ),
    );
  }
}
