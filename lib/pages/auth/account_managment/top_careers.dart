import 'package:flutter/material.dart';

class TopCareers extends StatelessWidget {
  const TopCareers({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          "Top 5 careers:",
          style: TextStyle(
            fontSize: 24,
            decoration: TextDecoration.none,
          ),
        ),
        Row(
          children: [
            Text(
              "display five career cards here",
              style: TextStyle(
                fontSize: 16,
                decoration: TextDecoration.none,
              ),
            ),
          ],
        )
      ],
    );
  }
}
