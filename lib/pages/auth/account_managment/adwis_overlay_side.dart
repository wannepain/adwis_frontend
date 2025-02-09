import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AdwisOverlaySide extends StatelessWidget {
  const AdwisOverlaySide({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 200,
      child: Container(
        decoration: BoxDecoration(
          color: Color.fromRGBO(180, 196, 209, 1),
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(9),
            bottomRight: Radius.circular(9),
          ),
        ),
        padding: EdgeInsets.fromLTRB(0, 10, 6, 10),
        child: RotatedBox(
          quarterTurns: 3,
          child: SvgPicture.asset(
            'assets/icons/logo_text.svg',
            width: 40,
            height: 37,
          ),
        ),
      ),
    );
  }
}
