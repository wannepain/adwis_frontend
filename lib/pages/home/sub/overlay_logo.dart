import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:adwis_frontend/providers/auth_providers.dart';
import 'package:adwis_frontend/pages/auth/unlimited/utils/unlimited_logo.dart';

class OverlayLogo extends ConsumerStatefulWidget {
  const OverlayLogo({super.key});

  @override
  ConsumerState<OverlayLogo> createState() => _OverlayLogoState();
}

class _OverlayLogoState extends ConsumerState<OverlayLogo> {
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showOverlay();
    });
  }

  void _showOverlay() {
    final Map data = ref.watch(authProvider);
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 0, // Adjust as needed
        left: 0,
        right: 0,
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(top: 10),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color.fromRGBO(252, 254, 255, 1),
              ),
              child: data!["isUnlimited"]
                  ? UnlimitedLogo(
                      size: 32,
                      textSize: 12,
                    )
                  : SvgPicture.asset(
                      "assets/icons/logo_text.svg",
                      width: 109,
                      height: 45,
                      fit: BoxFit.contain,
                      colorFilter:
                          ColorFilter.mode(Colors.black, BlendMode.srcIn),
                    ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color.fromRGBO(252, 254, 255, 1),
                    Color.fromRGBO(252, 254, 255, 0),
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
              child: SizedBox(
                width: 10,
                height: 20,
              ),
            )
          ],
        ),
      ),
    );

    Overlay.of(context).insert(_overlayEntry!);
  }

  @override
  void dispose() {
    _overlayEntry?.remove();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return const SizedBox(); // Empty widget since overlay is separate
  }
}
