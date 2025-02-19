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
  double signOpactity = 0.0;
  double buttonOpacity = 0.0;

  void _changeButtonOpacity() {
    setState(() {
      buttonOpacity = buttonOpacity == 0.0 ? 1.0 : 0.0;
    });
  }

  void _changeSignOpacity() {
    setState(() {
      signOpactity = signOpactity == 0.0 ? 1.0 : 0.0;
    });
  }

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

    // First, fade out the button
    _changeButtonOpacity();

    // Then, after a short delay, fade in the sign-up card
    Future.delayed(Duration(milliseconds: 200), _changeSignOpacity);
  }

  @override
  void initState() {
    super.initState();
    isOpen = widget.forceOpen;

    // Ensure the button appears only after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        setState(() {
          buttonOpacity = 1.0;
        });
      }
    });
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
            ? Positioned(
                bottom: 36,
                left: 6,
                right: 6,
                child: AnimatedOpacity(
                  opacity: signOpactity,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOutCirc,
                  child: SignUpCard(
                    close: close,
                    onTap: onTap,
                  ),
                ),
              )
            : Positioned(
                top: (MediaQuery.of(context).size.height / 5) * 2,
                right: 12,
                child: AnimatedOpacity(
                  opacity: buttonOpacity,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeInOutCirc,
                  child: AccountButton(
                    close: close,
                  ),
                ),
              ),
      ],
    );
  }
}
