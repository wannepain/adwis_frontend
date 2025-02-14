import 'package:adwis_frontend/providers/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:adwis_frontend/pages/auth/utils/sign_up_card.dart';
import 'package:adwis_frontend/pages/auth/utils/account_button.dart';
import 'package:adwis_frontend/services/api_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AuthCardOverlay extends ConsumerStatefulWidget {
  final bool forceOpen;
  final bool navigateAfter;
  const AuthCardOverlay(
      {super.key, this.forceOpen = false, this.navigateAfter = false});

  @override
  ConsumerState<AuthCardOverlay> createState() => _AuthCardOverlayState();
}

class _AuthCardOverlayState extends ConsumerState<AuthCardOverlay> {
  bool isOpen = false;
  bool isUnlimited = false;
  String userImgUrl = "";
  bool _hasNavigated = false;
  final ApiService apiService = ApiService();

  void signUpLogic() async {
    await ref.read(authProvider.notifier).signIn();
    if (widget.navigateAfter) {
      Navigator.pushReplacementNamed(context, "/unlimited");
    }
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
  void initState() {
    // TODO: implement initState
    super.initState();
    isOpen = widget.forceOpen;
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(authProvider);

    if (isOpen &&
        data["isSignedIn"] &&
        !_hasNavigated &&
        !widget.navigateAfter) {
      _hasNavigated = true; // Set flag to prevent infinite loop
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          Navigator.pushReplacementNamed(context, "/account").then((onReturn) {
            _hasNavigated = false;
          });
        }
      });
    }

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
