import 'package:flutter/material.dart';
import 'package:adwis_frontend/services/auth_service.dart';
import 'package:adwis_frontend/pages/auth/utils/sign_up_card.dart';
import 'package:adwis_frontend/pages/auth/utils/account_button.dart';
import 'package:adwis_frontend/services/api_service.dart';

class AuthCardOverlay extends StatefulWidget {
  const AuthCardOverlay({super.key});

  @override
  State<AuthCardOverlay> createState() => _AuthCardOverlayState();
}

class _AuthCardOverlayState extends State<AuthCardOverlay> {
  bool isOpen = false;
  final ApiService authService = ApiService(
    url: "https://145e-45-84-122-3.ngrok-free.app",
  );

  void onTap() async {
    final userCredential = await AuthService().signInWithGoogle();
    final result = await authService.signUp(user: userCredential.user);
    print(result);
  }

  void close() {
    setState(() {
      isOpen = !isOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        isOpen
            ? SignUpCard(
                close: close,
                onTap: onTap,
              )
            : AccountButton(
                close: close,
              ),
      ],
    );
  }
}
