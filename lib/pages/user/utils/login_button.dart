import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class LoginButton extends StatelessWidget {
  final void Function() onPressed;
  final String type;
  LoginButton({super.key, required this.onPressed, required this.type});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        children: [
          GestureDetector(
            onTap: () {
              onPressed();
            },
            child: Container(
              padding: EdgeInsets.all(24),
              decoration: BoxDecoration(
                color: Color.fromRGBO(252, 254, 255, 1),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromRGBO(51, 101, 138, 1),
                    blurRadius: 4,
                    offset: Offset.zero,
                  ),
                ],
                borderRadius: BorderRadius.circular(18),
              ),
              child: Image.asset(
                type == "facebook"
                    ? "assets/images/Facebook_Logo_Primary.png"
                    : type == "google"
                        ? "assets/images/Google.png"
                        : "",
                height: 120,
                width: 120,
              ),
            ),
          ),
          Text(
            type == "facebook"
                ? "Facebook"
                : type == "google"
                    ? "Google"
                    : "",
            style: TextStyle(
              fontSize: 24,
              fontFamily: GoogleFonts.inter().fontFamily,
              color: Color.fromRGBO(51, 101, 138, 1),
            ),
          )
        ],
      ),
    );
  }
}
