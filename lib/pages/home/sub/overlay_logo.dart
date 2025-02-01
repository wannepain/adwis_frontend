import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'dart:math' as math;

class OverlayLogo extends StatefulWidget {
  const OverlayLogo({super.key});

  @override
  State<OverlayLogo> createState() => _OverlayLogoState();
}

class _OverlayLogoState extends State<OverlayLogo> {
  OverlayEntry? _overlayEntry;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showOverlay();
    });
  }

  void _showOverlay() {
    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 30, // Adjust as needed
        left: MediaQuery.of(context).size.width / 2 - 54,
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color.fromRGBO(254, 254, 254, 1),
                Color.fromRGBO(254, 254, 254, 0),
              ],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
          ),
          child: SvgPicture.asset(
            "assets/icons/logo_text.svg",
            width: 109,
            height: 45,
            fit: BoxFit.contain,
            colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
          ),
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
