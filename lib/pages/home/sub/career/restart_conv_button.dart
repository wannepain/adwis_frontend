import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:adwis_frontend/providers/auth_providers.dart';

class RestartConvButton extends ConsumerWidget {
  final Function restart;
  final int numOfRestarts;
  const RestartConvButton(
      {super.key, required this.restart, required this.numOfRestarts});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    double cWidth = MediaQuery.of(context).size.width * 0.9;
    final data = ref.watch(authProvider);
    final restartsLeft = 5 - numOfRestarts;
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
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(8, 7, 5, 1),
                  ),
                ),
                SizedBox(width: 8), // Spacing between text and icon
                SizedBox(
                  height: 42,
                  width: 42,
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: Center(
                          child: data != null && data["isUnlimited"]
                              ? RotatedBox(
                                  quarterTurns: 1,
                                  child: Text(
                                    "8",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily:
                                          GoogleFonts.inter().fontFamily,
                                      color: Color.fromRGBO(8, 7, 5, 1),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              : Text(
                                  restartsLeft.toString(),
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: GoogleFonts.inter().fontFamily,
                                    color: Color.fromRGBO(8, 7, 5, 1),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                        ),
                      ),
                      Positioned.fill(
                        child: Icon(
                          Icons.refresh,
                          color: Color.fromRGBO(8, 7, 5, 1),
                          size: 42,
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
