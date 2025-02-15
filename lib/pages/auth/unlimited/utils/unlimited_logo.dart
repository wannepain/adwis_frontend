// import 'package:flutter/material.dart';
// import 'package:flutter_svg/flutter_svg.dart';
// import 'package:google_fonts/google_fonts.dart';

// class UnlimitedLogo extends StatelessWidget {
//   final int size;
//   final Color textColor;
//   final Color logoColor;

//   UnlimitedLogo({
//     super.key,
//     this.size = 64,
//     this.textColor = const Color.fromRGBO(51, 101, 138, 1),
//     this.logoColor = const Color.fromRGBO(0, 0, 0, 1),
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         children: [
//           SvgPicture.asset(
//             "assets/icons/logo_text.svg",
//             colorFilter: ColorFilter.mode(logoColor, BlendMode.srcIn),
//             width: size.toDouble(),
//             height: size.toDouble(),

//           ),
//           Text(
//             "unlimited",
//             style: TextStyle(
//               decoration: TextDecoration.none,
//               fontSize: 20,
//               fontFamily: GoogleFonts.inter().fontFamily,
//               color: textColor,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class UnlimitedLogo extends StatelessWidget {
  final int size;
  final int textSize;
  final Color textColor;
  final Color logoColor;

  UnlimitedLogo({
    super.key,
    this.size = 64,
    this.textSize = 24,
    this.textColor = const Color.fromRGBO(51, 101, 138, 1),
    this.logoColor = const Color.fromRGBO(0, 0, 0, 1),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          LayoutBuilder(
            builder: (context, constraints) {
              final aspectRatio =
                  109 / 45; // Assuming the original aspect ratio of the SVG
              final width = size * aspectRatio;

              return SvgPicture.asset(
                "assets/icons/logo_text.svg",
                colorFilter: ColorFilter.mode(logoColor, BlendMode.srcIn),
                width: width,
                height: size.toDouble(),
              );
            },
          ),
          Text(
            "unlimited",
            style: TextStyle(
                decoration: TextDecoration.none,
                fontSize: textSize.toDouble(),
                fontFamily: GoogleFonts.inter().fontFamily,
                color: textColor,
                fontWeight:
                    textSize > 16 ? FontWeight.normal : FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
