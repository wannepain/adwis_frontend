import 'dart:math'; // Import for blast direction constants
import 'package:adwis_frontend/utils/functions/hex_to_rgba.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void showComplimentSnackBar(String message) {
  OverlayState? overlayState = navigatorKey.currentState?.overlay;
  if (overlayState == null) return;

  final ConfettiController _confettiController =
      ConfettiController(duration: const Duration(seconds: 2));
  late OverlayEntry overlayEntry;

  final AnimationController controller = AnimationController(
    vsync: navigatorKey.currentState!,
    duration: const Duration(milliseconds: 300),
  );

  final Animation<Offset> slideAnimation = Tween<Offset>(
    begin: const Offset(0, -1), // Start off-screen at the top
    end: Offset.zero, // Slide into position
  ).animate(CurvedAnimation(
    parent: controller,
    curve: Curves.easeOut,
  ));

  final Animation<double> opacityAnimation = Tween<double>(
    begin: 0.0, // Fully transparent
    end: 1.0, // Fully visible
  ).animate(CurvedAnimation(
    parent: controller,
    curve: Curves.easeIn,
  ));

  overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: 80, // Adjust this to control how far from the top
      left: MediaQuery.of(context).size.width * 0.1,
      width: MediaQuery.of(context).size.width * 0.8,
      child: Material(
        color: Colors.transparent,
        child: AnimatedBuilder(
          animation: controller,
          builder: (context, child) => Opacity(
            opacity: opacityAnimation.value,
            child: SlideTransition(
              position: slideAnimation,
              child: Stack(
                alignment: Alignment.topCenter, // Align confetti at the top
                children: [
                  // Confetti
                  ConfettiWidget(
                    confettiController: _confettiController,
                    blastDirection: pi / 2, // Make confetti fall down
                    emissionFrequency: 0.02, // Adjust for a natural flow
                    numberOfParticles: 15,
                    gravity: 0.1, // Increase to make it fall naturally
                    colors: [
                      Colors.red,
                      Colors.blue,
                      Colors.green,
                      Colors.orange,
                      Colors.purple,
                    ],
                  ),

                  // Snack Bar
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 16),
                    decoration: BoxDecoration(
                      color: HexToRgba().convert("080705", 1),
                      borderRadius: BorderRadius.circular(18),
                      boxShadow: [
                        BoxShadow(
                          color: HexToRgba().convert("080705", 0.25),
                          blurRadius: 10,
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Flexible(
                          // Allows text to wrap
                          child: Text(
                            message,
                            style: TextStyle(
                              color: HexToRgba().convert("FCFEFF", 1),
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              fontFamily: GoogleFonts.acme().fontFamily,
                            ),
                            softWrap: true, // Ensures wrapping
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );

  // Insert the overlay entry
  overlayState.insert(overlayEntry);

  // Start the animation and confetti
  controller.forward();
  _confettiController.play();

  // Remove after 3 seconds with slide-up and fade-out animation
  Future.delayed(const Duration(seconds: 3), () {
    controller.reverse().then((_) {
      _confettiController.stop();
      overlayEntry.remove();
      _confettiController.dispose();
      controller.dispose();
    });
  });
}
