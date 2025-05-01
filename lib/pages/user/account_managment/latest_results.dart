import 'package:adwis_frontend/pages/user/account_managment/career_card/career_card.dart';
import 'package:adwis_frontend/providers/history_providers.dart';
import 'package:adwis_frontend/utils/functions/hex_to_rgba.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class LatestResults extends ConsumerStatefulWidget {
  @override
  ConsumerState<LatestResults> createState() => _LatestResultsState();
}

class _LatestResultsState extends ConsumerState<LatestResults> {
  @override
  Widget build(BuildContext context) {
    final careers = ref.watch(historyProvider)["data"];
    print("careers: $careers");
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start, // Aligns text properly
        children: [
          Text(
            "Your latest results:",
            style: TextStyle(
              fontFamily: GoogleFonts.inter().fontFamily,
              fontWeight: FontWeight.w500,
              color: HexToRgba().convert("33658A", 1),
              fontSize: 24,
            ),
          ),
          SizedBox(height: 6),

          /// Wrapping ListView in a SizedBox to prevent infinite height issue
          SizedBox(
            height: MediaQuery.of(context).size.width *
                0.5, // Adjust this as needed
            child: ListView.builder(
              itemCount: careers.length,
              physics: BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return CareerCard(career_data: careers[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
