import 'package:adwis_frontend/utils/functions/hex_to_rgba.dart';
import 'package:flutter/material.dart';

class Line extends StatelessWidget {
  final bool isCompleted;
  final bool inProgress;

  const Line({
    this.isCompleted = false,
    this.inProgress = false,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.25,
      height: 3,
      decoration: BoxDecoration(
        color: inProgress
            ? null
            : isCompleted
                ? HexToRgba().convert("8FC6EE", 1)
                : HexToRgba().convert("EBEAEA", 1),
        borderRadius: BorderRadius.circular(1),
        gradient: inProgress
            ? LinearGradient(
                colors: [
                  HexToRgba().convert("8FC6EE", 1),
                  HexToRgba().convert("EBEAEA", 1),
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              )
            : null,
      ),
    );
  }
}
