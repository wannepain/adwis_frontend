import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:adwis_frontend/pages/home/sub/career/career_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:adwis_frontend/providers/history_providers.dart';

class TopCareers extends ConsumerStatefulWidget {
  TopCareers({super.key});

  @override
  _TopCareersState createState() => _TopCareersState();
}

class _TopCareersState extends ConsumerState<TopCareers> {
  double opacityLevel = 0.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, _changeOpacity);
  }

  void _changeOpacity() {
    setState(() {
      opacityLevel = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
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
        AnimatedOpacity(
          opacity: opacityLevel,
          duration: const Duration(seconds: 1),
          child: Container(
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
                } else {
                  return Container(); // Return an empty container if histories is empty
                }
              },
            ),
          ),
        ),
      ],
    );
  }
}
