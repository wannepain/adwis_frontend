import 'package:adwis_frontend/providers/user_provider.dart';
import 'package:adwis_frontend/utils/functions/hex_to_rgba.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:url_launcher/url_launcher.dart';

class SubscriptionDisplay extends ConsumerStatefulWidget {
  @override
  ConsumerState<SubscriptionDisplay> createState() =>
      _SubscriptionDisplayState();
}

class _SubscriptionDisplayState extends ConsumerState<SubscriptionDisplay> {
  String date = "";
  bool isLoading = true;

  Future<void> initAsyncLogic() async {
    await ref.read(userProvider.notifier).getUserData();
    setState(() {
      isLoading = false;
    });
  }

  _launchURL() async {
    final Uri _url = Uri.parse(
      'https://play.google.com/store/account/subscriptions',
    );
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initAsyncLogic();
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(userProvider);
    final isUnlimited = data["isUnlimited"];
    final subscriptionData = data["subscriptionData"];
    if (subscriptionData != null) {
      final unixTimeStamp = subscriptionData["nextCharge"];
      if (unixTimeStamp != null) {
        final date = DateTime.fromMillisecondsSinceEpoch(unixTimeStamp * 1000);
        final day = date.day;
        final month = date.month;
        final year = date.year;
        this.date = "$day. $month. $year";
      }
    }
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
              child: isLoading
                  ? Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        LoadingAnimationWidget.waveDots(
                          color: HexToRgba().convert("FCFEFF", 1),
                          size: 24,
                        ),
                        SizedBox(
                          height: 26,
                        )
                      ],
                    )
                  : isUnlimited
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            subscriptionData != null
                                ? Text(
                                    subscriptionData["subscriptionType"],
                                    style: TextStyle(
                                      fontFamily:
                                          GoogleFonts.inter().fontFamily,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                      color: HexToRgba().convert("FCFEFF", 1),
                                    ),
                                  )
                                : LoadingAnimationWidget.waveDots(
                                    color: HexToRgba().convert("FCFEFF", 1),
                                    size: 24,
                                  ),
                            TextButton(
                              onPressed: () {
                                //cancel subscription
                                _launchURL();
                              },
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
            if (!isUnlimited && date == "")
              SizedBox(
                height: 12,
              ),
            if (isUnlimited && date != "")
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "will be charded at ",
                    style: TextStyle(
                      fontFamily: GoogleFonts.inter().fontFamily,
                      fontWeight: FontWeight.w400,
                      fontSize: 18,
                      color: HexToRgba().convert("33658A", 1),
                    ),
                  ),
                  Text(
                    date,
                    style: TextStyle(
                      fontFamily: GoogleFonts.inter().fontFamily,
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                      color: HexToRgba().convert("33658A", 1),
                    ),
                  )
                ],
              ),
          ],
        ),
      ),
    );
  }
}
