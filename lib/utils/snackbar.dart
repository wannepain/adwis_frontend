import 'package:adwis_frontend/main.dart';
import 'package:adwis_frontend/utils/functions/hex_to_rgba.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showCustomSnackBar(String message) {
  snackbarKey.currentState?.showSnackBar(
    SnackBar(
      backgroundColor: HexToRgba().convert("FCFEFF", 1),
      padding: EdgeInsets.symmetric(
        vertical: 6,
        horizontal: 16,
      ),
      duration: Duration(seconds: 2),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            style: TextStyle(
              color: HexToRgba().convert("080705", 1),
              fontSize: 20,
              fontWeight: FontWeight.w400,
              fontFamily: GoogleFonts.inter().fontFamily,
            ),
          ),
        ],
      ),
    ),
  );
}
