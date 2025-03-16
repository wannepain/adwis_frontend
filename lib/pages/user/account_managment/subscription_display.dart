import 'package:adwis_frontend/providers/user_provider.dart';
import 'package:adwis_frontend/utils/functions/hex_to_rgba.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class SubscriptionDisplay extends ConsumerStatefulWidget {
  @override
  ConsumerState<SubscriptionDisplay> createState() =>
      _SubscriptionDisplayState();
}

class _SubscriptionDisplayState extends ConsumerState<SubscriptionDisplay> {
  @override
  Widget build(BuildContext context) {
    final data = ref.watch(userProvider);
    final isUnlimited = data["isUnlimited"];
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      child: IntrinsicHeight(
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                color: HexToRgba().convert("33658A", 1),
                borderRadius: BorderRadius.all(Radius.circular(9)),
                boxShadow: [
                  BoxShadow(
                    color: HexToRgba().convert("080705", 0.25),
                    offset: Offset.zero,
                    blurRadius: 4,
                  ),
                ],
              ),
              padding: EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 6,
              ),
              child: isUnlimited
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Subscription",
                          style: TextStyle(
                            fontFamily: GoogleFonts.inter().fontFamily,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: HexToRgba().convert("FCFEFF", 1),
                          ),
                        ),
                        TextButton(
                          onPressed: () {},
                          child: Text(
                            "Cancel",
                            style: TextStyle(
                              fontFamily: GoogleFonts.inter().fontFamily,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: HexToRgba().convert("FCFEFF", 1),
                            ),
                          ),
                        ),
                      ],
                    )
                  : TextButton(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            "Free",
                            style: TextStyle(
                              fontFamily: GoogleFonts.inter().fontFamily,
                              fontWeight: FontWeight.w400,
                              fontSize: 24,
                              color: HexToRgba().convert("FCFEFF", 1),
                            ),
                          ),
                          Text(
                            "Go unlimited",
                            style: TextStyle(
                              fontFamily: GoogleFonts.inter().fontFamily,
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: HexToRgba().convert("FCFEFF", 1),
                            ),
                          ),
                        ],
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, "/unlimited");
                      },
                    ),
            ),
            SizedBox(
              height: 12,
            ),
          ],
        ),
      ),
    );
  }
}
