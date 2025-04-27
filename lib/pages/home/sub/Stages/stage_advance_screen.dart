import 'dart:math';
import 'package:adwis_frontend/providers/stages_provider.dart';
import 'package:adwis_frontend/providers/user_provider.dart';
import 'package:adwis_frontend/utils/functions/hex_to_rgba.dart';
import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class StageAdvanceScreen extends ConsumerStatefulWidget {
  const StageAdvanceScreen({super.key});

  @override
  _StageAdvanceScreenState createState() => _StageAdvanceScreenState();
}

class _StageAdvanceScreenState extends ConsumerState<StageAdvanceScreen>
    with SingleTickerProviderStateMixin {
  late final ConfettiController _confettiController =
      ConfettiController(duration: const Duration(seconds: 1));

  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  late Animation<Offset> _slideAnimation;

  void onTap(isUnlimited) async {
    print("isunlimited :$isUnlimited");
    if (true) {
      await ref.read(stagesProvider.notifier).set();
      Navigator.pushNamed(
        context,
        "/homepage",
      );
    } else {
      Navigator.pushNamed(
        context,
        "/unlimited",
      );
    }
  }

  @override
  void initState() {
    super.initState();

    _confettiController.play(); // Start the confetti animation

    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    _slideAnimation =
        Tween<Offset>(begin: const Offset(0, 0.1), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeOut,
      ),
    );

    _animationController.forward(); // Start the fade & slide animation
  }

  @override
  void dispose() {
    _confettiController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentStage = ref.watch(stagesProvider)["current_stage"];
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(6),
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: SlideTransition(
            position: _slideAnimation,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Congratulations!',
                  style: TextStyle(
                    fontSize: 42,
                    fontFamily: GoogleFonts.acme().fontFamily,
                    fontWeight: FontWeight.w500,
                    decoration: TextDecoration.none,
                  ),
                ),
                const SizedBox(height: 24),
                SvgPicture.asset(
                  'assets/illustrations/congratulations_illustration_adwis.svg',
                  height: 315,
                ),
                const SizedBox(height: 38),
                Column(
                  children: [
                    Text(
                      "You have completed",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: GoogleFonts.inter().fontFamily,
                        fontWeight: FontWeight.w400,
                        decoration: TextDecoration.none,
                      ),
                    ),
                    ConfettiWidget(
                      confettiController: _confettiController,
                      blastDirection: -pi / 2,
                      emissionFrequency: 0.01,
                      numberOfParticles: 60,
                      gravity: 0.6,
                      blastDirectionality: BlastDirectionality.explosive,
                      colors: [
                        Colors.red,
                        Colors.blue,
                        Colors.green,
                        Colors.orange,
                        Colors.purple,
                      ],
                    ),
                    Text(
                      "Stage $currentStage",
                      style: TextStyle(
                        fontSize: 42,
                        fontFamily: GoogleFonts.acme().fontFamily,
                        fontWeight: FontWeight.w700,
                        decoration: TextDecoration.none,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () {
                    final isUnlimited = ref.watch(userProvider)["isUnlimited"];
                    onTap(isUnlimited);
                  },
                  child: Container(
                    width: MediaQuery.of(context).size.width * 0.9,
                    decoration: BoxDecoration(
                      color: HexToRgba().convert("8FC6EE", 1),
                      borderRadius: BorderRadius.circular(9),
                      boxShadow: [
                        BoxShadow(
                          color: HexToRgba().convert("080705", 0.6),
                          blurRadius: 4,
                          offset: const Offset(0, 0),
                        ),
                      ],
                    ),
                    padding:
                        const EdgeInsets.symmetric(horizontal: 9, vertical: 12),
                    child: Row(
                      children: [
                        Expanded(
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.max,
                            children: [
                              Text(
                                "go to ",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: GoogleFonts.inter().fontFamily,
                                  fontWeight: FontWeight.w400,
                                  decoration: TextDecoration.none,
                                  color: HexToRgba().convert("FCFEFF", 1),
                                ),
                              ),
                              Text(
                                "next stage",
                                style: TextStyle(
                                  fontSize: 20,
                                  fontFamily: GoogleFonts.inter().fontFamily,
                                  fontWeight: FontWeight.bold,
                                  decoration: TextDecoration.none,
                                  color: HexToRgba().convert("FCFEFF", 1),
                                ),
                              )
                            ],
                          ),
                        ),
                        Icon(
                          Icons.workspace_premium_outlined,
                          color: HexToRgba().convert("FCFEFF", 1),
                          size: 25,
                        )
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  "to continue you must have",
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: GoogleFonts.inter().fontFamily,
                    fontWeight: FontWeight.w200,
                    fontStyle: FontStyle.italic,
                    decoration: TextDecoration.none,
                    color: HexToRgba().convert("080705", 0.75),
                  ),
                ),
                Text(
                  "adwis unlimited",
                  style: TextStyle(
                    fontSize: 12,
                    fontFamily: GoogleFonts.inter().fontFamily,
                    fontWeight: FontWeight.w300,
                    decoration: TextDecoration.none,
                    fontStyle: FontStyle.italic,
                    color: HexToRgba().convert("080705", 0.75),
                  ),
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
