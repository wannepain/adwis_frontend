import 'dart:ui';

import 'package:adwis_frontend/providers/user_provider.dart';
import 'package:adwis_frontend/utils/functions/hex_to_rgba.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class EmailDisplay extends ConsumerStatefulWidget {
  final void Function() logout;
  EmailDisplay({super.key, required this.logout});

  @override
  ConsumerState<EmailDisplay> createState() => _EmailDisplayState();
}

class _EmailDisplayState extends ConsumerState<EmailDisplay> {
  @override
  Widget build(BuildContext context) {
    final userData = ref.watch(userProvider);
    return Container(
      width: MediaQuery.of(context).size.width * 0.85,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: HexToRgba().convert("#080705", 0.25),
            blurRadius: 4,
            offset: Offset.zero,
          ),
        ],
      ),
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
              color: HexToRgba().convert("#FCFEFF", 0.6),
            ),
            child: Row(
              children: [
                Column(
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
                          userData["email"] != null ? userData["email"] : "",
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
                IconButton(
                    onPressed: () {
                      widget.logout();
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
