import 'package:adwis_frontend/pages/unlimited/utils/adwis_unlimited_logo.dart';
import 'package:adwis_frontend/pages/unlimited/utils/benefits.dart';
import 'package:adwis_frontend/pages/unlimited/utils/header.dart';
import 'package:adwis_frontend/pages/unlimited/utils/payment_button.dart';
import 'package:adwis_frontend/utils/functions/hex_to_rgba.dart';
import 'package:flutter/material.dart';

class GoUnlimited extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: HexToRgba().convert("F3F8FC", 1),
      body: Stack(
        children: [
          Positioned(
            top: 90,
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                AdwisUnlimitedLogo(),
                SizedBox(
                  height: 50,
                ),
                Header(),
                SizedBox(
                  height: 50,
                ),
                PaymentButton(),
                SizedBox(
                  height: 42,
                ),
                Benefits(),
                SizedBox(
                  height: 42,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
