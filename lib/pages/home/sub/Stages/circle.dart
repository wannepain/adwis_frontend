import 'package:adwis_frontend/utils/functions/hex_to_rgba.dart';
import 'package:flutter/material.dart';

class Circle extends StatelessWidget {
  final bool isCompleted;
  final bool isUnlocked;
  final bool inProgress;
  final int stage;

  const Circle({
    this.isCompleted = false,
    this.isUnlocked = false,
    this.inProgress = false,
    required this.stage,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: inProgress
            ? null
            : isCompleted
                ? HexToRgba().convert("8FC6EE", 1)
                : HexToRgba().convert("EBEAEA", 1),
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
      child: Center(
        child: isUnlocked
            ? Text(
                stage.toString(),
                style: TextStyle(
                  color: HexToRgba().convert("080705", 1),
                  fontSize: 16,
                ),
              )
            : Icon(
                Icons.lock,
                color: HexToRgba().convert("080705", 1),
                size: 16,
              ),
      ),
    );
  }
}
