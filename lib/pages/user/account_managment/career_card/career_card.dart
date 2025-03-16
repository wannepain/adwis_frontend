import 'package:adwis_frontend/utils/functions/hex_to_rgba.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CareerCard extends StatelessWidget {
  final career_data;
  CareerCard({super.key, required this.career_data});

  String truncateText(String text, int maxLength) {
    if (text.length <= maxLength) {
      return text;
    }
    return text.substring(0, maxLength) + '...';
  }

  @override
  Widget build(BuildContext context) {
    final starting_salary =
        career_data != null ? career_data["Starting_Salary"] : "";
    return Container(
      height: MediaQuery.of(context).size.width * 0.6,
      padding: EdgeInsets.symmetric(
        horizontal: 12,
        vertical: 12,
      ),
      margin: EdgeInsets.only(
        right: 6,
        top: 6,
        bottom: 6,
      ),
      width: (MediaQuery.of(context).size.width * 0.6) * 0.9,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/images/degree_2.jpg"),
          colorFilter: ColorFilter.mode(
            Colors.black.withAlpha(100),
            BlendMode.srcATop,
          ),
          fit: BoxFit.cover,
        ),
        borderRadius: BorderRadius.all(
          Radius.circular(9),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 4,
            color: HexToRgba().convert("080705", 0.25),
            offset: Offset.zero,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Flexible(
                child: Text(
                  career_data != null ? career_data["Career_Name"] : "",
                  style: TextStyle(
                    color: HexToRgba().convert("FCFEFF", 1),
                    fontWeight: FontWeight.bold,
                    fontFamily: GoogleFonts.inter().fontFamily,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              /// Removed `IntrinsicHeight` to prevent constraints issues
              SizedBox(
                width: ((MediaQuery.of(context).size.width * 0.6) * 0.9) * 0.5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize:
                      MainAxisSize.min, // Keeps it from expanding unnecessarily
                  children: [
                    Flexible(
                      // Ensures text wraps inside Column
                      child: Text(
                        career_data != null
                            ? truncateText(career_data["Description"], 50)
                            : "",
                        overflow: TextOverflow.fade,
                        style: TextStyle(
                          color: HexToRgba().convert("FCFEFF", 0.7),
                          fontWeight: FontWeight.w400,
                          fontFamily: GoogleFonts.inter().fontFamily,
                          fontSize: 12,
                        ),
                        textAlign: TextAlign.start,
                        softWrap: true, // Ensures text wraps
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "\$$starting_salary",
                    style: TextStyle(
                      color: HexToRgba().convert("FCFEFF", 1),
                      fontWeight: FontWeight.bold,
                      fontFamily: GoogleFonts.inter().fontFamily,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    "/year",
                    style: TextStyle(
                      color: HexToRgba().convert("FCFEFF", 1),
                      fontWeight: FontWeight.w400,
                      fontFamily: GoogleFonts.inter().fontFamily,
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
