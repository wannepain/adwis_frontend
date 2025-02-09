import 'package:adwis_frontend/providers/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:adwis_frontend/pages/auth/utils/sign_up_card.dart';
import 'package:adwis_frontend/pages/auth/utils/account_button.dart';
import 'package:adwis_frontend/services/api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthCardOverlay extends ConsumerStatefulWidget {
  const AuthCardOverlay({super.key});

  @override
  ConsumerState<AuthCardOverlay> createState() => _AuthCardOverlayState();
}

class _AuthCardOverlayState extends ConsumerState<AuthCardOverlay> {
  bool isOpen = false;
  bool isUnlimited = false;
  String userImgUrl = "";
  final ApiService apiService = ApiService();

  void signUpLogic() async {
    ref.read(authProvider.notifier).signIn();
  }

  void onTap() {
    signUpLogic();
  }

  void close() {
    setState(() {
      isOpen = !isOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(authProvider);
    return Stack(
      children: [
        isOpen
            ? data["isSignedIn"] == false
                ? SignUpCard(
                    close: close,
                    onTap: onTap,
                  )
                : Positioned(
                    //implement user managment screen
                    top: 200,
                    left: 100,
                    child: Text("User is signed in"),
                  )
            : AccountButton(
                close: close,
              ),
      ],
    );
  }
}
