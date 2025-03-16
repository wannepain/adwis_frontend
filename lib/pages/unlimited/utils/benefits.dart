import 'package:adwis_frontend/utils/functions/hex_to_rgba.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class Benefits extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Why go ",
                textAlign:
                    TextAlign.center, // Ensures multiline text is centered
                style: TextStyle(
                  fontFamily: GoogleFonts.inter().fontFamily,
                  fontSize: 32,
                  color: HexToRgba().convert("080705", 1),
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.none,
                ),
              ),
              Text(
                "unlimited ",
                textAlign:
                    TextAlign.center, // Ensures multiline text is centered
                style: TextStyle(
                  fontFamily: GoogleFonts.inter().fontFamily,
                  fontSize: 32,
                  color: HexToRgba().convert("33658A", 1),
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.none,
                ),
              ),
              Text(
                "?",
                textAlign:
                    TextAlign.center, // Ensures multiline text is centered
                style: TextStyle(
                  fontFamily: GoogleFonts.inter().fontFamily,
                  fontSize: 32,
                  color: HexToRgba().convert("080705", 1),
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 6,
          ),
          Row(
            children: [
              SizedBox(
                width: 12,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/infinity.svg",
                        width: 40,
                        height: 40,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        "Longer Conversations",
                        textAlign: TextAlign
                            .center, // Ensures multiline text is centered
                        style: TextStyle(
                          fontFamily: GoogleFonts.inter().fontFamily,
                          fontSize: 24,
                          color: HexToRgba().convert("080705", 1),
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/infinity.svg",
                        width: 40,
                        height: 40,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        "Tailored Advice",
                        textAlign: TextAlign
                            .center, // Ensures multiline text is centered
                        style: TextStyle(
                          fontFamily: GoogleFonts.inter().fontFamily,
                          fontSize: 24,
                          color: HexToRgba().convert("080705", 1),
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      SvgPicture.asset(
                        "assets/icons/infinity.svg",
                        width: 40,
                        height: 40,
                      ),
                      SizedBox(
                        width: 6,
                      ),
                      Text(
                        "Exclusive Features",
                        textAlign: TextAlign
                            .center, // Ensures multiline text is centered
                        style: TextStyle(
                          fontFamily: GoogleFonts.inter().fontFamily,
                          fontSize: 24,
                          color: HexToRgba().convert("080705", 1),
                          fontWeight: FontWeight.w500,
                          decoration: TextDecoration.none,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          )
        ],
      ),
    );
  }
}
