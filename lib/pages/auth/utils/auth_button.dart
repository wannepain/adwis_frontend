import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AuthButton extends StatelessWidget {
  final Function onTap;
  final String type;
  const AuthButton({super.key, required this.onTap, required this.type});

  @override
  Widget build(BuildContext context) {
    return IntrinsicHeight(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              onTap();
            },
            child: Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(9)),
                  color: Color.fromRGBO(252, 254, 255, 1),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: 4,
                      spreadRadius: 0,
                      offset: Offset(0, 0),
                      color: Color.fromRGBO(51, 101, 138, 1),
                    ),
                  ]),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Image.asset(
                    "assets/images/$type.png",
                  ),
                  SizedBox(
                    width: 12.0,
                  ),
                  Text(
                    "Continue with ",
                    style: TextStyle(
                      fontSize: 24.0,
                      fontFamily: GoogleFonts.inter().fontFamily,
                      fontWeight: FontWeight.w300,
                      color: Color.fromRGBO(8, 7, 5, 1),
                      decoration: TextDecoration.none,
                    ),
                  ),
                  Text(
                    type,
                    style: TextStyle(
                      fontSize: 24.0,
                      fontFamily: GoogleFonts.inter().fontFamily,
                      fontWeight: FontWeight.bold,
                      color: Color.fromRGBO(8, 7, 5, 1),
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
