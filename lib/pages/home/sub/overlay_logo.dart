import 'package:adwis_frontend/pages/home/sub/Stages/stages.dart';
import 'package:adwis_frontend/providers/user_provider.dart';
import 'package:adwis_frontend/utils/functions/hex_to_rgba.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

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
    final isUnlimited = ref.read(userProvider)["isUnlimited"];

    _overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        top: 0, // Adjust as needed
        left: 0,
        right: 0,
        child: Column(
          children: [
            Container(
              color: HexToRgba().convert("FCFEFF", 1),
              child: Column(
                children: [
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    child: isUnlimited
                        ? Column(
                            children: [
                              SvgPicture.asset(
                                "assets/icons/logo_text.svg",
                                width: 100,
                                height: 35,
                                fit: BoxFit.contain,
                                colorFilter: ColorFilter.mode(
                                    Colors.black, BlendMode.srcIn),
                              ),
                              Text(
                                "unlimited",
                                style: TextStyle(
                                  fontFamily: GoogleFonts.inter().fontFamily,
                                  fontSize: 10,
                                  color: HexToRgba().convert("33658A", 1),
                                  fontWeight: FontWeight.w500,
                                  decoration: TextDecoration.none,
                                ),
                              ),
                            ],
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
                  SizedBox(
                    height: 6,
                  ),
                  SizedBox(
                    width: double.infinity,
                    child: Stages(),
                  ),
                  SizedBox(
                    height: 6,
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    HexToRgba().convert("FCFEFF", 1),
                    HexToRgba().convert("FCFEFF", 0),
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
