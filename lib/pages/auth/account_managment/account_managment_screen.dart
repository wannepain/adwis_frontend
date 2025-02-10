import 'dart:ui';
import 'package:adwis_frontend/pages/auth/account_managment/user_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:adwis_frontend/providers/auth_providers.dart';
import 'package:adwis_frontend/pages/auth/account_managment/subscription_display.dart';
import 'package:adwis_frontend/pages/auth/account_managment/email_display.dart';
import 'package:adwis_frontend/pages/auth/account_managment/top_careers.dart';

class AccountManagmentScreen extends ConsumerWidget {
  const AccountManagmentScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(authProvider);
    return Scaffold(
      backgroundColor: Color.fromRGBO(180, 196, 209, 1),
      body: Stack(
        children: [
          Positioned.fill(
            child: Stack(
              children: [
                Positioned(
                  top: 30,
                  left: 0,
                  right: 0,
                  child: UserImage(
                    imageUrl: data["userImage"],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 12,
                  right: 12,
                  top: MediaQuery.sizeOf(context).width - 30,
                  child: Column(
                    children: [
                      EmailDisplay(),
                      SizedBox(
                        height: 16,
                      ),
                      SubscriptionDisplay(),
                      SizedBox(
                        height: 16,
                      ),
                      TopCareers(),
                    ],
                  ),
                )
              ],
            ),
          ),
          Positioned(
            top: 36,
            right: 24,
            child: ClipRRect(
              // borderRadius: BorderRadius.all(Radius.circular()),
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 0.5, sigmaY: 0.5),
                child: IconButton(
                  style: ButtonStyle(
                    padding: WidgetStateProperty.all(
                      EdgeInsets.zero,
                    ),
                  ),
                  onPressed: () {
                    Navigator.pushReplacementNamed(context, "/homepage");
                  },
                  icon: Icon(
                    size: 48,
                    Icons.close,
                    color: Color.fromRGBO(8, 7, 5, 0.7),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
