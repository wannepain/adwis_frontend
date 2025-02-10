import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SubscriptionDisplay extends StatelessWidget {
  const SubscriptionDisplay({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(51, 101, 138, 1),
            borderRadius: BorderRadius.all(
              Radius.circular(9),
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 4,
                spreadRadius: 0,
                offset: Offset(0, 0),
                color: Color.fromRGBO(0, 0, 0, 0.25),
              ),
            ],
          ),
          padding: EdgeInsets.all(12),
          child: ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(9),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 3.0,
                sigmaY: 3.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Subscription",
                        style: TextStyle(
                          fontSize: 16,
                          decoration: TextDecoration.none,
                          color: Color.fromRGBO(252, 254, 255, 0.7),
                          fontFamily: GoogleFonts.inter().fontFamily,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Text(
                        "type",
                        style: TextStyle(
                          fontSize: 24,
                          decoration: TextDecoration.none,
                          color: Color.fromRGBO(252, 254, 255, 1),
                          fontFamily: GoogleFonts.inter().fontFamily,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          "Cancel",
                          style: TextStyle(
                            color: Color.fromRGBO(252, 254, 255, 0.7),
                            fontFamily: GoogleFonts.inter().fontFamily,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            decoration: TextDecoration.none,
                          ),
                        ),
                        Icon(
                          Icons.close,
                          color: Color.fromRGBO(252, 254, 255, 0.7),
                          size: 30,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 3,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "will be charged at ",
              style: TextStyle(
                fontSize: 16,
                decoration: TextDecoration.none,
                fontFamily: GoogleFonts.inter().fontFamily,
                fontWeight: FontWeight.w300,
                color: Color.fromRGBO(51, 101, 138, 1),
                shadows: [
                  Shadow(
                    offset: Offset.zero,
                    blurRadius: 4,
                    color: Color.fromRGBO(0, 0, 0, 0.25),
                  ),
                ],
              ),
            ),
            Text(
              "2.6. 2025",
              style: TextStyle(
                fontSize: 16,
                decoration: TextDecoration.none,
                fontFamily: GoogleFonts.inter().fontFamily,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(51, 101, 138, 1),
                shadows: [
                  Shadow(
                    offset: Offset.zero,
                    blurRadius: 4,
                    color: Color.fromRGBO(0, 0, 0, 0.25),
                  ),
                ],
              ),
            ),
          ],
        )
      ],
    );
  }
}
