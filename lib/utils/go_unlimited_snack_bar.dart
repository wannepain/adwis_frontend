import 'dart:async';

import 'package:adwis_frontend/utils/functions/hex_to_rgba.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../services/navigation_service.dart';

// Future<void> showGoUnlimitedSnackBar(String message) {
//   OverlayState? overlayState = navigatorKey.currentState?.overlay;
//   if (overlayState == null) return Future.value(null);

//   late OverlayEntry overlayEntry;

//   final AnimationController controller = AnimationController(
//     vsync: navigatorKey.currentState!,
//     duration: const Duration(milliseconds: 300),
//   );

//   final Animation<Offset> slideAnimation = Tween<Offset>(
//     begin: const Offset(0, -1), // Start off-screen at the top
//     end: Offset.zero, // Slide into position
//   ).animate(CurvedAnimation(
//     parent: controller,
//     curve: Curves.easeOut,
//   ));

//   final Animation<double> opacityAnimation = Tween<double>(
//     begin: 0.0, // Fully transparent
//     end: 1.0, // Fully visible
//   ).animate(CurvedAnimation(
//     parent: controller,
//     curve: Curves.easeIn,
//   ));

//   overlayEntry = OverlayEntry(
//     builder: (context) => Positioned(
//       top: 80, // Adjust this to control how far from the top
//       left: MediaQuery.of(context).size.width * 0.1,
//       width: MediaQuery.of(context).size.width * 0.8,
//       child: Material(
//         color: Colors.transparent,
//         child: AnimatedBuilder(
//           animation: controller,
//           builder: (context, child) => Opacity(
//             opacity: opacityAnimation.value,
//             child: SlideTransition(
//               position: slideAnimation,
//               child: Stack(
//                 alignment: Alignment.topCenter, // Align confetti at the top
//                 children: [
//                   // Snack Bar
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.pushNamed(context, "/unlimited");
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 12, horizontal: 16),
//                       decoration: BoxDecoration(
//                         color: HexToRgba().convert("EDF3F8", 1),
//                         borderRadius: BorderRadius.circular(18),
//                         boxShadow: [
//                           BoxShadow(
//                             color: HexToRgba().convert("B4C4D1", 0.50),
//                             blurRadius: 10,
//                           ),
//                         ],
//                       ),
//                       child: IntrinsicHeight(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Flexible(
//                                   // Allows text to wrap
//                                   child: Text(
//                                     message,
//                                     style: TextStyle(
//                                       color: HexToRgba().convert("080705", 1),
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w500,
//                                       fontFamily:
//                                           GoogleFonts.inter().fontFamily,
//                                     ),
//                                     softWrap: true, // Ensures wrapping
//                                     textAlign: TextAlign.center,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Flexible(
//                                   // Allows text to wrap
//                                   child: Text(
//                                     "Go ",
//                                     style: TextStyle(
//                                       color: HexToRgba().convert("080705", 1),
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.bold,
//                                       fontFamily:
//                                           GoogleFonts.inter().fontFamily,
//                                     ),
//                                     softWrap: true, // Ensures wrapping
//                                     textAlign: TextAlign.center,
//                                   ),
//                                 ),
//                                 Flexible(
//                                   // Allows text to wrap
//                                   child: Text(
//                                     "unlimited",
//                                     style: TextStyle(
//                                       color: HexToRgba().convert("33658A", 1),
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.bold,
//                                       fontFamily:
//                                           GoogleFonts.inter().fontFamily,
//                                     ),
//                                     softWrap: true, // Ensures wrapping
//                                     textAlign: TextAlign.center,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     ),
//   );

//   // Insert the overlay entry
//   overlayState.insert(overlayEntry);

//   // Start the animation and confetti
//   controller.forward();

//   // Remove after 3 seconds with slide-up and fade-out animation
//   Future.delayed(const Duration(seconds: 3), () {
//     controller.reverse().then((_) {
//       overlayEntry.remove();
//       controller.dispose();
//       return Future.value();
//     });
//   });
// }

// Future<void> showGoUnlimitedSnackBar(String message) {
//   OverlayState? overlayState = navigatorKey.currentState?.overlay;
//   if (overlayState == null) return Future.value();

//   final completer = Completer<void>();
//   late OverlayEntry overlayEntry;

//   final AnimationController controller = AnimationController(
//     vsync: navigatorKey.currentState!,
//     duration: const Duration(milliseconds: 300),
//   );

//   final Animation<Offset> slideAnimation = Tween<Offset>(
//     begin: const Offset(0, -1),
//     end: Offset.zero,
//   ).animate(CurvedAnimation(
//     parent: controller,
//     curve: Curves.easeOut,
//   ));

//   final Animation<double> opacityAnimation = Tween<double>(
//     begin: 0.0,
//     end: 1.0,
//   ).animate(CurvedAnimation(
//     parent: controller,
//     curve: Curves.easeIn,
//   ));

//   overlayEntry = OverlayEntry(
//     builder: (context) => Positioned(
//       top: 80,
//       left: MediaQuery.of(context).size.width * 0.1,
//       width: MediaQuery.of(context).size.width * 0.8,
//       child: Material(
//         color: Colors.transparent,
//         child: AnimatedBuilder(
//           animation: controller,
//           builder: (context, child) => Opacity(
//             opacity: opacityAnimation.value,
//             child: SlideTransition(
//               position: slideAnimation,
//               child: Stack(
//                 alignment: Alignment.topCenter,
//                 children: [
//                   GestureDetector(
//                     onTap: () {
//                       Navigator.pushNamed(context, "/unlimited");
//                     },
//                     child: Container(
//                       padding: const EdgeInsets.symmetric(
//                           vertical: 12, horizontal: 16),
//                       decoration: BoxDecoration(
//                         color: HexToRgba().convert("EDF3F8", 1),
//                         borderRadius: BorderRadius.circular(18),
//                         boxShadow: [
//                           BoxShadow(
//                             color: HexToRgba().convert("B4C4D1", 0.50),
//                             blurRadius: 10,
//                           ),
//                         ],
//                       ),
//                       child: IntrinsicHeight(
//                         child: Column(
//                           mainAxisAlignment: MainAxisAlignment.center,
//                           children: [
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Flexible(
//                                   child: Text(
//                                     message,
//                                     style: TextStyle(
//                                       color: HexToRgba().convert("080705", 1),
//                                       fontSize: 16,
//                                       fontWeight: FontWeight.w500,
//                                       fontFamily:
//                                           GoogleFonts.inter().fontFamily,
//                                     ),
//                                     softWrap: true,
//                                     textAlign: TextAlign.center,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                             Row(
//                               mainAxisAlignment: MainAxisAlignment.center,
//                               children: [
//                                 Flexible(
//                                   child: Text(
//                                     "Go ",
//                                     style: TextStyle(
//                                       color: HexToRgba().convert("080705", 1),
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.bold,
//                                       fontFamily:
//                                           GoogleFonts.inter().fontFamily,
//                                     ),
//                                     softWrap: true,
//                                     textAlign: TextAlign.center,
//                                   ),
//                                 ),
//                                 Flexible(
//                                   child: Text(
//                                     "unlimited",
//                                     style: TextStyle(
//                                       color: HexToRgba().convert("33658A", 1),
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.bold,
//                                       fontFamily:
//                                           GoogleFonts.inter().fontFamily,
//                                     ),
//                                     softWrap: true,
//                                     textAlign: TextAlign.center,
//                                   ),
//                                 ),
//                               ],
//                             ),
//                           ],
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     ),
//   );

//   overlayState.insert(overlayEntry);
//   controller.forward();

//   Future.delayed(const Duration(seconds: 3), () async {
//     await controller.reverse();
//     overlayEntry.remove();
//     controller.dispose();
//     completer.complete(); // 🎯 Completes the future
//   });

//   return completer.future;
// }

class SnackBarController {
  final void Function() dismiss;

  SnackBarController({required this.dismiss});
}

SnackBarController showGoUnlimitedSnackBar(String message) {
  OverlayState? overlayState = navigatorKey.currentState?.overlay;
  if (overlayState == null) {
    throw Exception("No OverlayState available");
  }

  late OverlayEntry overlayEntry;

  final AnimationController controller = AnimationController(
    vsync: navigatorKey.currentState!,
    duration: const Duration(milliseconds: 300),
  );

  final Animation<Offset> slideAnimation = Tween<Offset>(
    begin: const Offset(0, -1),
    end: Offset.zero,
  ).animate(CurvedAnimation(
    parent: controller,
    curve: Curves.easeOut,
  ));

  final Animation<double> opacityAnimation = Tween<double>(
    begin: 0.0,
    end: 1.0,
  ).animate(CurvedAnimation(
    parent: controller,
    curve: Curves.easeIn,
  ));

  overlayEntry = OverlayEntry(
    builder: (context) => Positioned(
      top: 80,
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
              child: GestureDetector(
                onTap: () {
                  Navigator.pushNamed(context, "/unlimited");
                },
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  decoration: BoxDecoration(
                    color: HexToRgba().convert("EDF3F8", 1),
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: HexToRgba().convert("B4C4D1", 0.50),
                        blurRadius: 10,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        message,
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: HexToRgba().convert("080705", 1),
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          fontFamily: GoogleFonts.inter().fontFamily,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            "Go ",
                            style: TextStyle(
                              color: HexToRgba().convert("080705", 1),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: GoogleFonts.inter().fontFamily,
                            ),
                          ),
                          Text(
                            "unlimited",
                            style: TextStyle(
                              color: HexToRgba().convert("33658A", 1),
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              fontFamily: GoogleFonts.inter().fontFamily,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    ),
  );

  overlayState.insert(overlayEntry);
  controller.forward();

  void dismiss() async {
    await controller.reverse();
    overlayEntry.remove();
    controller.dispose();
  }

  return SnackBarController(dismiss: dismiss);
}
