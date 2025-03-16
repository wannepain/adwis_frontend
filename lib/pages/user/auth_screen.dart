import 'dart:ui';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import "package:google_fonts/google_fonts.dart";
import 'package:adwis_frontend/pages/user/utils/login_button.dart';
import 'package:adwis_frontend/utils/functions/hex_to_rgba.dart';
import 'package:adwis_frontend/providers/user_provider.dart';

class AuthScreen extends ConsumerStatefulWidget {
  @override
  ConsumerState<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends ConsumerState<AuthScreen> {
  void googleLoginFunction() async {
    await ref.read(userProvider.notifier).signInWithGoogle();
    Navigator.pop(context);
  }

  void facebookLoginFunction() async {
    // await ref.read(userProvider.notifier).signInWithFacebook();
  }

  void closeFunction() {
    //do any necessarry work before close here
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexToRgba().convert("#FCFEFF", 1),
      body: Stack(
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    HexToRgba().convert("4884B1", 0.05),
                    HexToRgba().convert("EDF3F8", 0.4),
                    HexToRgba().convert("EDF3F8", 0.4),
                    HexToRgba().convert("4884B1", 0.3),
                  ],
                  stops: [0.0, 0.3, 0.6, 1.0],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Stack(
                    children: [
                      Opacity(
                          child: Image.asset(
                            "assets/images/adwis_logo.png",
                            color: Colors.black,
                            width: 300,
                            height: 300,
                            fit: BoxFit.contain,
                          ),
                          opacity: 0.2),
                      ClipRect(
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                          child: Image.asset(
                            "assets/images/adwis_logo.png",
                            width: 300,
                            height: 300,
                            fit: BoxFit.contain,
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 24,
                  ),
                  Text(
                    "Sign up",
                    style: TextStyle(
                      fontSize: 48,
                      fontFamily: GoogleFonts.acme().fontFamily,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: Divider(
                      color: HexToRgba().convert("080705", 0.6),
                      thickness: 1,
                    ),
                  ),
                  SizedBox(
                    height: 12,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      LoginButton(
                        onPressed: googleLoginFunction,
                        type: "google",
                      ),
                      LoginButton(
                        onPressed: facebookLoginFunction,
                        type: "facebook",
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 36,
                  )
                ],
              ),
            ),
          ),
          Positioned(
              top: 80,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () {
                      closeFunction();
                    },
                    icon: Icon(
                      Icons.close_rounded,
                      size: 60,
                      color: HexToRgba().convert("080705", 1),
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
