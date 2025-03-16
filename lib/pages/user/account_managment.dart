import 'package:adwis_frontend/pages/user/account_managment/email_display.dart';
import 'package:adwis_frontend/pages/user/account_managment/latest_results.dart';
import 'package:adwis_frontend/pages/user/account_managment/subscription_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:adwis_frontend/providers/user_provider.dart';

class AccountManagment extends ConsumerStatefulWidget {
  @override
  ConsumerState<AccountManagment> createState() => _AccountManagmentState();
}

class _AccountManagmentState extends ConsumerState<AccountManagment> {
  void logout() async {
    await ref.read(userProvider.notifier).signOut();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final userData = ref.watch(userProvider);

    return Scaffold(
        body: Stack(
      children: [
        Positioned(
          top: 90,
          left: 0,
          right: 0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: Image.network(
                  userData["photoURL"],
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.width * 0.9,
                  fit: BoxFit.cover,
                ),
              ),
            ],
          ),
        ),
        Positioned(
          top: (MediaQuery.of(context).size.width * 0.9) + 50,
          left: 0,
          right: 0,
          bottom: 0,
          child: Column(
            children: [
              EmailDisplay(logout: logout),
              SizedBox(
                height: 12,
              ),
              SubscriptionDisplay(),
              SizedBox(
                height: 12,
              ),
              LatestResults(),
            ],
          ),
        ),
      ],
    ));
  }
}
