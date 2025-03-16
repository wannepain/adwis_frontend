import 'package:flutter/material.dart';

class HexToRgba {
  Color convert(String hex, double opacity) {
    hex = hex.replaceAll("#", ""); // Remove '#' if present
    if (hex.length == 6) {
      hex = "ff" + hex; // Add full opacity if alpha is missing
    }

    int colorValue = int.parse(hex, radix: 16); // Convert hex to int
    return Color(colorValue)
        .withAlpha((opacity * 255).round()); // Return color with opacity
  }
}
