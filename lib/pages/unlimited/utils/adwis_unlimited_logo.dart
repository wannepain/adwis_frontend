import 'package:adwis_frontend/utils/functions/hex_to_rgba.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class AdwisUnlimitedLogo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        children: [
          SvgPicture.asset(
            "assets/icons/logo_text.svg",
            width: 135,
            height: 70,
            fit: BoxFit.contain,
            colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
          ),
          Text(
            "unlimited",
            style: TextStyle(
              fontFamily: GoogleFonts.inter().fontFamily,
              fontSize: 20,
              color: HexToRgba().convert("33658A", 1),
              fontWeight: FontWeight.w500,
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }
}
