import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:adwis_frontend/services/api_service.dart';
import 'package:adwis_frontend/providers/auth_providers.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:adwis_frontend/pages/auth/unlimited/utils/unlimited_logo.dart';

class SubscriptionDisplay extends ConsumerStatefulWidget {
  const SubscriptionDisplay({super.key});

  @override
  ConsumerState<SubscriptionDisplay> createState() =>
      _SubscriptionDisplayState();
}

class _SubscriptionDisplayState extends ConsumerState<SubscriptionDisplay> {
  String? subscriptionType;
  String? nextChargeDate;
  String? nextChargeTime;

  void cancelSubscription() {
    final cancelResult = ApiService().cancelSubscription();
    //force refresh
    ref.read(authProvider.notifier).checkSignedIn();
    print(cancelResult);
    initLogic();
  }

  void initLogic() async {
    final subscription = await ApiService().getSubscriptionData();
    final subscriptionData = subscription["data"];
    print(subscription);
    setState(() {
      if (subscriptionData != null &&
          subscriptionData["free_trial"] != null &&
          subscriptionData["free_trial"] > subscriptionData["nextCharge"]) {
        subscriptionType = "Free-trial";
      } else {
        subscriptionType = subscription["subscription_type"];
      }
      if (subscriptionData != null && subscriptionData["next_charge"] != null) {
        final date = DateTime.fromMillisecondsSinceEpoch(
                subscriptionData["next_charge"] * 1000)
            .toLocal();
        final day = date.day;
        final month = date.month;
        final hour = date.hour;
        final minute = date.minute;

        nextChargeDate = "$day.$month.";
        nextChargeTime = "$hour:$minute";
      } else {
        nextChargeDate = "";
        nextChargeTime = "";
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initLogic();
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(authProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(51, 101, 138, 1),
            borderRadius: BorderRadius.all(
              Radius.circular(9),
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 4,
                spreadRadius: 0,
                offset: Offset(0, 0),
                color: Color.fromRGBO(0, 0, 0, 0.25),
              ),
            ],
          ),
          padding: EdgeInsets.all(12),
          child: ClipRRect(
            borderRadius: BorderRadius.all(
              Radius.circular(9),
            ),
            child: BackdropFilter(
              filter: ImageFilter.blur(
                sigmaX: 3.0,
                sigmaY: 3.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Subscription",
                        style: TextStyle(
                          fontSize: 16,
                          decoration: TextDecoration.none,
                          color: Color.fromRGBO(252, 254, 255, 0.7),
                          fontFamily: GoogleFonts.inter().fontFamily,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      subscriptionType != null
                          ? Row(
                              children: [
                                SizedBox(
                                  width: 6,
                                ),
                                Text(
                                  subscriptionType ?? "",
                                  style: TextStyle(
                                    fontSize: 24,
                                    decoration: TextDecoration.none,
                                    color: Color.fromRGBO(252, 254, 255, 1),
                                    fontFamily: GoogleFonts.inter().fontFamily,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            )
                          : Container(
                              padding: EdgeInsets.all(2),
                              child: LoadingAnimationWidget.waveDots(
                                color: Color.fromRGBO(252, 254, 255, 1),
                                size: 20,
                              ),
                            )
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      if (data != null) {
                        if (data["isUnlimited"]) {
                          cancelSubscription();
                        } else {
                          Navigator.pushNamed(context, "/unlimited");
                        }
                      }
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: data!["isUnlimited"]
                          ? [
                              Text(
                                "Cancel",
                                style: TextStyle(
                                  color: Color.fromRGBO(252, 254, 255, 0.7),
                                  fontFamily: GoogleFonts.inter().fontFamily,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                              Icon(
                                Icons.close,
                                color: Color.fromRGBO(252, 254, 255, 0.7),
                                size: 30,
                              ),
                            ]
                          : [
                              Text(
                                "Go ",
                                style: TextStyle(
                                  color: Color.fromRGBO(252, 254, 255, 0.5),
                                  fontFamily: GoogleFonts.inter().fontFamily,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 24,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                              UnlimitedLogo(
                                size: 36,
                                textColor: Color.fromRGBO(184, 225, 255, 1),
                                textSize: 12,
                                logoColor: Color.fromRGBO(252, 254, 255, 0.7),
                              ),
                              SizedBox(
                                width: 6,
                              )
                            ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 3,
        ),
        if (nextChargeDate != "" && nextChargeTime != "")
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "will be charged the ",
                style: TextStyle(
                  fontSize: 16,
                  decoration: TextDecoration.none,
                  fontFamily: GoogleFonts.inter().fontFamily,
                  fontWeight: FontWeight.w300,
                  color: Color.fromRGBO(51, 101, 138, 1),
                  shadows: [
                    Shadow(
                      offset: Offset.zero,
                      blurRadius: 4,
                      color: Color.fromRGBO(0, 0, 0, 0.25),
                    ),
                  ],
                ),
              ),
              nextChargeDate == null
                  ? LoadingAnimationWidget.waveDots(
                      color: Color.fromRGBO(51, 101, 138, 1),
                      size: 16,
                    )
                  : Text(
                      nextChargeDate ?? "",
                      style: TextStyle(
                        fontSize: 16,
                        decoration: TextDecoration.none,
                        fontFamily: GoogleFonts.inter().fontFamily,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(51, 101, 138, 1),
                        shadows: [
                          Shadow(
                            offset: Offset.zero,
                            blurRadius: 4,
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                          ),
                        ],
                      ),
                    ),
              Text(
                " at ",
                style: TextStyle(
                  fontSize: 16,
                  decoration: TextDecoration.none,
                  fontFamily: GoogleFonts.inter().fontFamily,
                  fontWeight: FontWeight.w300,
                  color: Color.fromRGBO(51, 101, 138, 1),
                  shadows: [
                    Shadow(
                      offset: Offset.zero,
                      blurRadius: 4,
                      color: Color.fromRGBO(0, 0, 0, 0.25),
                    ),
                  ],
                ),
              ),
              nextChargeTime == null
                  ? LoadingAnimationWidget.waveDots(
                      color: Color.fromRGBO(51, 101, 138, 1),
                      size: 16,
                    )
                  : Text(
                      nextChargeTime ?? "",
                      style: TextStyle(
                        fontSize: 16,
                        decoration: TextDecoration.none,
                        fontFamily: GoogleFonts.inter().fontFamily,
                        fontWeight: FontWeight.bold,
                        color: Color.fromRGBO(51, 101, 138, 1),
                        shadows: [
                          Shadow(
                            offset: Offset.zero,
                            blurRadius: 4,
                            color: Color.fromRGBO(0, 0, 0, 0.25),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
      ],
    );
  }
}
