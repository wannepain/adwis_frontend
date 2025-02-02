import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class RestartConvButton extends StatelessWidget {
  final Function restart;
  const RestartConvButton({super.key, required this.restart});

  @override
  Widget build(BuildContext context) {
    double cWidth = MediaQuery.of(context).size.width * 0.9;
    return IntrinsicHeight(
      child: Center(
        child: Container(
          width: cWidth,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(9),
            boxShadow: [
              BoxShadow(
                color:
                    Color.fromRGBO(0, 0, 0, 0.15), // Shadow color with opacity
                spreadRadius: 0, // How much the shadow spreads
                blurRadius: 4, // Blurriness
                offset: Offset(0, 0), // Shadow position (X, Y)
              ),
            ],
          ),
          child: ElevatedButton(
            style: ButtonStyle(
              backgroundColor: WidgetStateProperty.all(
                Color.fromRGBO(237, 243, 248, 1),
              ),
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(9),
                ),
              ),
              padding: WidgetStateProperty.all(EdgeInsets.all(12)),
            ),
            onPressed: () {
              restart();
            },
            child: Row(
              mainAxisSize: MainAxisSize.min, // Ensures Row wraps its content
              children: [
                Text(
                  "Restart Conversation",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontFamily: GoogleFonts.inter().fontFamily,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(8, 7, 5, 1),
                  ),
                ),
                SizedBox(width: 8), // Spacing between text and icon
                Icon(
                  Icons.refresh,
                  color: Color.fromRGBO(8, 7, 5, 1),
                  size: 30,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
