import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:adwis_frontend/pages/auth/utils/auth_button.dart';

class SignUpCard extends StatelessWidget {
  final Function close;
  final Function onTap;
  const SignUpCard({super.key, required this.close, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 36,
      left: 6,
      right: 6,
      child: IntrinsicWidth(
        child: Container(
          decoration: BoxDecoration(
            color: Color.fromRGBO(243, 248, 252, 1),
            borderRadius: BorderRadius.all(
              Radius.circular(9),
            ),
            boxShadow: [
              BoxShadow(
                blurRadius: 4,
                offset: Offset(0, 1),
                spreadRadius: 0,
                color: Color.fromRGBO(8, 7, 5, 1),
              ),
            ],
          ),
          padding: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                children: [
                  SizedBox(
                    width: 6,
                  ),
                  IconButton(
                    onPressed: () {
                      close();
                    },
                    icon: Icon(
                      Icons.close,
                      color: Colors.black,
                      size: 36,
                    ),
                  ),
                ],
              ),
              Icon(
                Icons.account_circle_rounded,
                size: 64,
              ),
              SizedBox(
                height: 12,
              ),
              Text(
                "Sign up to",
                style: TextStyle(
                  fontFamily: GoogleFonts.inter().fontFamily,
                  fontSize: 24.0,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(8, 7, 5, 1),
                  decoration: TextDecoration.none,
                ),
              ),
              SvgPicture.asset(
                "assets/icons/logo_text.svg",
                width: 109,
                height: 45,
                fit: BoxFit.contain,
                colorFilter: ColorFilter.mode(Colors.black, BlendMode.srcIn),
              ),
              SizedBox(
                height: 12,
              ),
              AuthButton(
                onTap: onTap,
                type: "Google",
              ),
              SizedBox(
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
