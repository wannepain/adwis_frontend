import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:adwis_frontend/providers/auth_providers.dart';
import 'package:adwis_frontend/pages/auth/unlimited/utils/unlimited_logo.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:adwis_frontend/pages/auth/unlimited/utils/subscription_button.dart';
import 'package:adwis_frontend/pages/auth/unlimited/utils/close_button.dart';

class UnlimitedPopup extends ConsumerStatefulWidget {
  const UnlimitedPopup({super.key});

  @override
  ConsumerState<UnlimitedPopup> createState() => _UnlimitedPopupState();
}

class _UnlimitedPopupState extends ConsumerState<UnlimitedPopup> {
  bool _hasNavigated = false;
  bool openSignUp = false;

  void setOpenSignUp() {
    //navigate to homepage with the open sign up, after that come back to the payment screen
    Navigator.pushNamed(context, "/signup");
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(authProvider);
    if (data['isUnlimited'] != null && data["isUnlimited"]) {
      _hasNavigated = true; // Set flag to prevent infinite loop
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.pushNamed(context, "/account").then((onReturn) {
          _hasNavigated = false;
        });
      });
    }
    return Scaffold(
      backgroundColor: Color.fromRGBO(243, 248, 252, 1),
      body: Stack(
        children: [
          Positioned(
            bottom: 24,
            left: 12,
            right: 12,
            top: MediaQuery.sizeOf(context).height / 3,
            child: Column(
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      UnlimitedLogo(),
                      IntrinsicHeight(
                        child: Column(
                          children: [
                            Text(
                              "Choose your",
                              style: TextStyle(
                                fontFamily: GoogleFonts.inter().fontFamily,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              "Subscription",
                              style: TextStyle(
                                fontFamily: GoogleFonts.inter().fontFamily,
                                fontSize: 32,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SubscriptionButton(
                        openSignUp: setOpenSignUp,
                      ),
                      SizedBox(
                        height: 24,
                      )
                    ],
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Why go ",
                          style: TextStyle(
                            color: Color.fromRGBO(8, 7, 5, 1),
                            fontSize: 30,
                            fontFamily: GoogleFonts.inter().fontFamily,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          "unlimited ",
                          style: TextStyle(
                            color: Color.fromRGBO(51, 101, 138, 1),
                            fontSize: 30,
                            fontFamily: GoogleFonts.inter().fontFamily,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        Text(
                          "?",
                          style: TextStyle(
                            color: Color.fromRGBO(8, 7, 5, 1),
                            fontSize: 30,
                            fontFamily: GoogleFonts.inter().fontFamily,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.check_rounded,
                                  size: 36,
                                  color: Color.fromRGBO(51, 101, 138, 1),
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Text(
                                  "100% Add free",
                                  style: TextStyle(
                                    color: Color.fromRGBO(8, 7, 5, 1),
                                    fontSize: 30,
                                    fontFamily: GoogleFonts.inter().fontFamily,
                                    fontWeight: FontWeight.normal,
                                  ),
                                )
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Icon(
                                  Icons.check_rounded,
                                  size: 36,
                                  color: Color.fromRGBO(51, 101, 138, 1),
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Unlimited ",
                                      style: TextStyle(
                                        color: Color.fromRGBO(8, 7, 5, 1),
                                        fontSize: 30,
                                        fontFamily:
                                            GoogleFonts.inter().fontFamily,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                    Text(
                                      "Restarts",
                                      style: TextStyle(
                                        color: Color.fromRGBO(8, 7, 5, 1),
                                        fontSize: 30,
                                        fontFamily:
                                            GoogleFonts.inter().fontFamily,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                )
              ],
            ),
          ),
          Positioned(
            top: 30,
            right: 12,
            child: CloseButtonTimer(),
          ),
        ],
      ),
    );
  }
}
