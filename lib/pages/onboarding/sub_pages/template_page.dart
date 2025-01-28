import 'package:flutter/material.dart';
import 'package:adwis_frontend/utils/action_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class TemplatePage extends StatelessWidget {
  const TemplatePage({super.key, required this.type});

  final String type;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Expanded(
            child: Column(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  'Find Your',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: GoogleFonts.inter().fontFamily,
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  'Purpose'.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 48,
                      fontFamily: GoogleFonts.acme().fontFamily,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30),
                SvgPicture.asset(
                  "assets/illustrations/purpose_illustration.svg",
                  width: 300,
                  height: 300,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 30),
                // Text(
                //   "Discover your purpose through meaningful dialogue",
                //   textAlign: TextAlign.center,
                //   style: TextStyle(
                //     fontSize: 24,
                //     fontFamily: GoogleFonts.inter().fontFamily,
                //   ),
                // )
                RichText(
                  text: TextSpan(
                    // Note: Styles for TextSpans must be explicitly defined.
                    // Child text spans will inherit styles from parent
                    style: TextStyle(
                      fontSize: 24,
                      color: Colors.black,
                      fontFamily: GoogleFonts.inter().fontFamily,
                    ),

                    children: <TextSpan>[
                      TextSpan(text: 'Discover your '),
                      TextSpan(
                          text: 'Purpose ',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                      TextSpan(text: 'through '),
                      TextSpan(
                          text: 'meaningful dialogue',
                          style: const TextStyle(fontWeight: FontWeight.bold)),
                    ],
                  ),
                )
              ],
            ),
          ),
          ActionButton(
            onPressed: () {
              // Navigator.pushNamed(context, '/onboarding/step1');
            },
            text: 'Try',
          ),
        ],
      ),
    );
  }
}
