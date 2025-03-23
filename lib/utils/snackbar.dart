import 'package:adwis_frontend/main.dart';
import 'package:adwis_frontend/utils/functions/hex_to_rgba.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void showCustomSnackBar(String message) {
  snackbarKey.currentState?.showSnackBar(
    SnackBar(
      backgroundColor: HexToRgba().convert("C4D3DE", 1),
      behavior: SnackBarBehavior.floating,
      margin: const EdgeInsets.all(12),
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            message,
            style: TextStyle(
              color: HexToRgba().convert("080705", 1),
              fontSize: 20,
              fontWeight: FontWeight.w500,
              fontFamily: GoogleFonts.inter().fontFamily,
            ),
          ),
        ],
      ),
    ),
  );
}
