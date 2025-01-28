import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class TextWithIcon extends StatelessWidget {
  ///Creates a text with Adwis icon on the right side
  ///Args:
  ///- text: The text to display
  final String text;

  const TextWithIcon({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          text,
          style: TextStyle(
            color: Color.fromARGB(255, 8, 7, 5),
            fontSize: 20,
          ),
        ),
        SizedBox(width: 8),
        SvgPicture.asset(
          "assets/icons/logo_text.svg",
          width: 109,
          height: 45,
          fit: BoxFit.contain,
          colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
        ),
      ],
    );
  }
}
