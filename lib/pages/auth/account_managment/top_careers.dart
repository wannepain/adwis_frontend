import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:adwis_frontend/pages/home/sub/career/career_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:adwis_frontend/providers/history_providers.dart';

class TopCareers extends ConsumerWidget {
  TopCareers({super.key});

  final placeholderHistory = [
    {
      "bot": {
        "ID": "1",
        "Question_Text":
            "Hi! I’m here to help you explore your skills and interests. Ready to start?"
      },
      "client": "Yes I am "
    },
    {
      "bot": {
        "ID": "28",
        "Question_Text":
            "Do you see your work as a means to an end, or do you want it to reflect your passion and purpose?"
      },
      "client": "It must reflect my purpose"
    },
    {
      "bot": {
        "ID": "4",
        "Question_Text":
            "Have you ever been told you’re good at something? If so, what is it?"
      },
      "client": "I would probably do martial arts"
    }
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(historyProvider);
    final histories = data["data"];
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              width: 12,
            ),
            Text(
              "Your Top 5 careers:",
              style: TextStyle(
                fontSize: 24,
                decoration: TextDecoration.none,
                fontFamily: GoogleFonts.inter().fontFamily,
                color: Color.fromRGBO(51, 101, 138, 1),
                shadows: [
                  Shadow(
                    color: Colors.black,
                    offset: Offset.zero,
                    blurRadius: 2,
                  ),
                ],
              ),
            ),
          ],
        ),
        Container(
          height: (MediaQuery.sizeOf(context).height / 10) * 3,
          width: MediaQuery.sizeOf(context).width,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: histories.length < 5
                ? histories.length
                : 5, // Assuming you want to show top 5 careers
            itemBuilder: (context, index) {
              if (histories.length > 0) {
                print(histories[index]);
                return CareerCard(
                  history: histories[index],
                  size: (MediaQuery.sizeOf(context).height / 12) * 2,
                );
              }
            },
          ),
        ),
      ],
    );
  }
}
