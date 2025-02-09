import 'package:flutter/material.dart';
import 'package:adwis_frontend/utils/action_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class TemplatePage extends StatelessWidget {
  const TemplatePage({super.key, required this.type});

  final String type;

  @override
  Widget build(BuildContext context) {
    Widget? paragraph;
    String title = '';
    String header = '';
    String illustration = '';
    String buttonText = '';

    switch (type.toLowerCase()) {
      case 'purpose':
        title = 'Purpose';
        header = 'Find Your';
        illustration = 'assets/illustrations/purpose_illustration.svg';
        buttonText = 'Try';
        paragraph = RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
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
        );
        break;
      case 'clarity':
        title = 'Clarity';
        header = 'Decide with';
        illustration = 'assets/illustrations/clarity_illustration.svg';
        buttonText = 'Ask';
        paragraph = RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(
              fontSize: 24,
              color: Colors.black,
              fontFamily: GoogleFonts.inter().fontFamily,
            ),
            children: <TextSpan>[
              TextSpan(text: 'Unsure about your '),
              TextSpan(
                  text: 'Future ',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: '?'),
            ],
          ),
        );
        break;
      case 'confidence':
        title = 'Confident';
        header = 'Be';
        illustration = 'assets/illustrations/confident_illustration.svg';
        buttonText = 'Try';
        paragraph = RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            style: TextStyle(
              fontSize: 24,
              color: Colors.black,
              fontFamily: GoogleFonts.inter().fontFamily,
            ),
            children: <TextSpan>[
              TextSpan(text: 'Adwis gives you all the '),
              TextSpan(
                  text: 'information ',
                  style: const TextStyle(fontWeight: FontWeight.bold)),
              TextSpan(text: 'you need to decide. '),
            ],
          ),
        );
        break;
      default:
    }

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
                  header,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: GoogleFonts.inter().fontFamily,
                  ),
                ),
                SizedBox(height: 30),
                Text(
                  title.toUpperCase(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 48,
                      fontFamily: GoogleFonts.acme().fontFamily,
                      fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 30),
                SvgPicture.asset(
                  illustration,
                  width: 300,
                  height: 300,
                  fit: BoxFit.contain,
                ),
                SizedBox(height: 30),
                paragraph ?? Text('Failed to load paragraph'),
              ],
            ),
          ),
          ActionButton(
            onPressed: () {
              Navigator.pushNamed(context, "/homepage");
            },
            text: buttonText,
          ),
        ],
      ),
    );
  }
}
