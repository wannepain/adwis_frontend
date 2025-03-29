// import 'package:adwis_frontend/utils/functions/hex_to_rgba.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';

// class CareerButton extends StatelessWidget {
//   final String type;
//   final Function onPressed;
//   const CareerButton({super.key, required this.type, required this.onPressed});

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: () {
//         onPressed();
//       },
//       child: Container(
//         decoration: BoxDecoration(
//           color: type == "yes" ? HexToRgba().convert("5F9CC9", 1) : null,
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(
//             color: HexToRgba().convert("5F9CC9", 1),
//             width: 1,
//             style: BorderStyle.solid,
//           ),
//           boxShadow: [
//             BoxShadow(
//               color: Color.fromRGBO(143, 198, 238, 0.5),
//               offset: Offset(0, 0),
//               blurRadius: 10,
//               spreadRadius: 0,
//             ),
//           ],
//         ),
//         padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
//         child: Row(
//           children: [
//             Text(
//               type == "yes" ? "accept" : "decline",
//               style: TextStyle(
//                 color: type == "yes"
//                     ? HexToRgba().convert("FCFEFF", 1)
//                     : HexToRgba().convert("5F9CC9", 1),
//                 fontSize: 20,
//                 fontWeight: FontWeight.w500,
//                 fontFamily: GoogleFonts.inter().fontFamily,
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'package:adwis_frontend/utils/functions/hex_to_rgba.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CareerButton extends StatelessWidget {
  final String type;
  final Function onPressed;
  const CareerButton({super.key, required this.type, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onPressed();
      },
      child: Container(
        width: double.infinity, // Make sure it expands fully
        decoration: BoxDecoration(
          color: type == "yes" ? HexToRgba().convert("5F9CC9", 1) : null,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: HexToRgba().convert("5F9CC9", 1),
            width: 1,
            style: BorderStyle.solid,
          ),
          // boxShadow: [
          //   BoxShadow(
          //     color: Color.fromRGBO(143, 198, 238, 0.5),
          //     offset: Offset(0, 0),
          //     blurRadius: 10,
          //     spreadRadius: 0,
          //   ),
          // ],
        ),
        padding: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
        child: Center(
          // Center the text inside
          child: Text(
            type == "yes" ? "accept" : "decline",
            style: TextStyle(
              color: type == "yes"
                  ? HexToRgba().convert("FCFEFF", 1)
                  : HexToRgba().convert("5F9CC9", 1),
              fontSize: 20,
              fontWeight: FontWeight.w500,
              fontFamily: GoogleFonts.inter().fontFamily,
            ),
          ),
        ),
      ),
    );
  }
}
