import 'package:adwis_frontend/utils/functions/hex_to_rgba.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PaymentButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.85,
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(
              vertical: 12,
            ),
            decoration: BoxDecoration(
              color: HexToRgba().convert("33658A", 1),
              boxShadow: [
                BoxShadow(
                  color: HexToRgba().convert("33658A", 1),
                  blurRadius: 4,
                  offset: Offset.zero,
                ),
              ],
              borderRadius: BorderRadius.all(Radius.circular(9)),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "7-day free trial",
                  style: TextStyle(
                    fontFamily: GoogleFonts.inter().fontFamily,
                    fontSize: 24,
                    color: HexToRgba().convert("FCFEFF", 1),
                    fontWeight: FontWeight.w400,
                    decoration: TextDecoration.none,
                  ),
                ),
              ],
            ),
          ),
          Text(
            "Billed \$2.50 thereafter",
            style: TextStyle(
              fontFamily: GoogleFonts.inter().fontFamily,
              fontSize: 12,
              color: HexToRgba().convert("33658A", 1),
              fontWeight: FontWeight.w400,
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }
}
