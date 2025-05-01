import 'package:adwis_frontend/pages/unlimited/utils/adwis_unlimited_logo.dart';
import 'package:adwis_frontend/pages/unlimited/utils/benefits.dart';
import 'package:adwis_frontend/pages/unlimited/utils/header.dart';
import 'package:adwis_frontend/pages/unlimited/utils/payment_button.dart';
import 'package:adwis_frontend/providers/user_provider.dart';
import 'package:adwis_frontend/services/payments_service.dart';
import 'package:adwis_frontend/utils/functions/hex_to_rgba.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class GoUnlimited extends ConsumerStatefulWidget {
  String? returnTo;
  GoUnlimited({
    super.key,
    this.returnTo = "/homepage",
  });

  @override
  ConsumerState<GoUnlimited> createState() => _GoUnlimitedState();
}

class _GoUnlimitedState extends ConsumerState<GoUnlimited> {
  void onTap() async {
    final userData = ref.read(userProvider);
    if (userData["uid"] == null) {
      Navigator.pushNamed(
        context,
        "/auth",
      );
    } else {
      if (_paymentsService.products.isNotEmpty) {
        await _paymentsService.buy(_paymentsService.products[0]);
        await ref.read(userProvider.notifier).getUserDataNoUpdate();
        //should manually set unlimited to true
        ref.read(userProvider.notifier).setUnlimited(
            unlimited:
                true); //manually set unlimited to true (only for current session)
        Navigator.pop(context);
      }
    }
  }

  final PaymentsService _paymentsService = PaymentsService();

  @override
  void initState() {
    super.initState();
    _paymentsService.init(context, ref);
  }

  @override
  void dispose() {
    _paymentsService.dispose();
    super.dispose();
  }

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
                PaymentButton(
                  onTap: onTap,
                ),
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
