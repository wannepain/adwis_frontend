import 'package:adwis_frontend/utils/functions/hex_to_rgba.dart';
import 'package:flutter/material.dart';
import "package:flutter_svg/flutter_svg.dart";

class OpenSpeechButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return IconButton(
      onPressed: () {
        Navigator.pushNamed(context, "/speech");
      },
      icon: SvgPicture.asset(
        "assets/icons/speech_icon.svg",
        width: 56,
        height: 56,
        colorFilter: ColorFilter.mode(
          HexToRgba().convert("33658A", 1),
          BlendMode.srcIn,
        ),
      ),
    );
  }
}
