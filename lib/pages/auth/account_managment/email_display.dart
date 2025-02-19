import 'dart:ui';
import 'package:adwis_frontend/providers/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class EmailDisplay extends ConsumerStatefulWidget {
  const EmailDisplay({super.key});

  @override
  _EmailDisplayState createState() => _EmailDisplayState();
}

class _EmailDisplayState extends ConsumerState<EmailDisplay> {
  double opacityLevel = 0.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, _changeOpacity);
  }

  void _changeOpacity() {
    setState(() {
      opacityLevel = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(authProvider); //get email
    return AnimatedOpacity(
      opacity: opacityLevel,
      duration: const Duration(seconds: 1),
      child: ClipRRect(
        borderRadius: BorderRadius.all(
          Radius.circular(9),
        ),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 10.0,
            sigmaY: 10.0,
          ),
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: 12,
              vertical: 6,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(9),
              ),
              color: Color.fromRGBO(252, 254, 255, 0.2),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "username:",
                        style: TextStyle(
                          fontSize: 16,
                          decoration: TextDecoration.none,
                          fontFamily: GoogleFonts.inter().fontFamily,
                          color: Color.fromRGBO(51, 101, 138, 0.7),
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            data != null ? data["userData"]!.email : "",
                            style: TextStyle(
                              fontSize: 20,
                              decoration: TextDecoration.none,
                              fontFamily: GoogleFonts.inter().fontFamily,
                              color: Color.fromRGBO(51, 101, 138, 1),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton(
                    onPressed: () {
                      ref.read(authProvider.notifier).signOut();
                      Navigator.pushReplacementNamed(context, "/homepage");
                    },
                    padding: EdgeInsets.all(0),
                    icon: Icon(
                      Icons.logout,
                      size: 36,
                      color: Color.fromRGBO(51, 101, 138, 0.7),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
