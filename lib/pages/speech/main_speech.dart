import 'package:adwis_frontend/utils/functions/hex_to_rgba.dart';
import 'package:flutter/material.dart';

class MainSpeech extends StatefulWidget {
  @override
  _MainSpeechState createState() => _MainSpeechState();
}

class _MainSpeechState extends State<MainSpeech> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexToRgba().convert("FCFEFF", 1),
      body: Center(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                HexToRgba().convert("DFF2FF", 1),
                HexToRgba().convert("FCFEFF", 1),
                HexToRgba().convert("DFF2FF", 1),
              ],
              stops: [
                0.0,
                0.41,
                1.0,
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                child: IntrinsicHeight(
                  child: Column(
                    children: [
                      Text("Press to start"),
                      Container(
                        color: HexToRgba().convert("33658A", 1),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          boxShadow: [
                            BoxShadow(
                              color: HexToRgba().convert("FFFFFF", 0.7),
                              offset: Offset.zero,
                              blurRadius: 4,
                              spreadRadius: -4,
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
