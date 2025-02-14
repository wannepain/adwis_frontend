// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:adwis_frontend/services/stripe_service.dart';
// import 'package:adwis_frontend/providers/auth_providers.dart';
// import 'package:adwis_frontend/pages/auth/auth_card_overlay.dart';

// class SubscriptionButton extends ConsumerWidget {
//   const SubscriptionButton({super.key});

//   void makePayemnt(WidgetRef ref) async {
//     //1. check if user is siigned in
//     //1.1 if not, sign in
//     //2 make payment
//     //3. update auth provider
//     final data = ref.read(authProvider);
//     if (data['isSignedIn']) {
//       await StripeService.instance.makePayment();
//       ref.read(authProvider.notifier).checkSignedIn();
//     } else {
//       // open sign in
//     }
//   }

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Column(
//       children: [
//         GestureDetector(
//           onTap: () {
//             makePayemnt(ref);
//           },
//           child: Container(
//             decoration: BoxDecoration(
//               color: Color.fromRGBO(51, 101, 138, 1),
//               borderRadius: BorderRadius.all(
//                 Radius.circular(9),
//               ),
//               boxShadow: [
//                 BoxShadow(
//                   blurRadius: 4,
//                   offset: Offset.zero,
//                   spreadRadius: 0,
//                   color: Color.fromRGBO(51, 101, 138, 1),
//                 ),
//               ],
//             ),
//             padding: EdgeInsets.all(10),
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   "7-day trial",
//                   style: TextStyle(
//                     fontFamily: GoogleFonts.inter().fontFamily,
//                     fontSize: 24,
//                     fontWeight: FontWeight.w400,
//                     color: Color.fromRGBO(252, 254, 255, 1),
//                   ),
//                 ),
//                 SizedBox(
//                   width: 6,
//                 ),
//                 Text(
//                   "Free",
//                   style: TextStyle(
//                     fontFamily: GoogleFonts.inter().fontFamily,
//                     fontSize: 30,
//                     fontWeight: FontWeight.bold,
//                     color: Color.fromRGBO(252, 254, 255, 1),
//                   ),
//                 )
//               ],
//             ),
//           ),
//         ),
//         Text(
//           "Billed \$2.50 thereafter",
//           style: TextStyle(
//             fontFamily: GoogleFonts.inter().fontFamily,
//             fontSize: 12,
//             fontWeight: FontWeight.normal,
//             color: Color.fromRGBO(51, 101, 138, 1),
//           ),
//         )
//       ],
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:adwis_frontend/services/stripe_service.dart';
import 'package:adwis_frontend/providers/auth_providers.dart';

class SubscriptionButton extends ConsumerStatefulWidget {
  Function openSignUp;
  SubscriptionButton({super.key, required this.openSignUp});

  @override
  _SubscriptionButtonState createState() => _SubscriptionButtonState();
}

class _SubscriptionButtonState extends ConsumerState<SubscriptionButton> {
  void makePayment() async {
    // 1. Check if user is signed in
    // 1.1 If not, sign in
    // 2. Make payment
    // 3. Update auth provider
    final data = ref.read(authProvider);
    if (data['isSignedIn']) {
      await StripeService.instance.makePayment();
      ref.read(authProvider.notifier).checkSignedIn();
    } else {
      // Open sign in
      widget.openSignUp();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: () {
            makePayment();
          },
          child: Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(51, 101, 138, 1),
              borderRadius: BorderRadius.all(
                Radius.circular(9),
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: 4,
                  offset: Offset.zero,
                  spreadRadius: 0,
                  color: Color.fromRGBO(51, 101, 138, 1),
                ),
              ],
            ),
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "7-day trial",
                  style: TextStyle(
                    fontFamily: GoogleFonts.inter().fontFamily,
                    fontSize: 24,
                    fontWeight: FontWeight.w400,
                    color: Color.fromRGBO(252, 254, 255, 1),
                  ),
                ),
                SizedBox(
                  width: 6,
                ),
                Text(
                  "Free",
                  style: TextStyle(
                    fontFamily: GoogleFonts.inter().fontFamily,
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Color.fromRGBO(252, 254, 255, 1),
                  ),
                )
              ],
            ),
          ),
        ),
        Text(
          "Billed \$2.50 thereafter",
          style: TextStyle(
            fontFamily: GoogleFonts.inter().fontFamily,
            fontSize: 12,
            fontWeight: FontWeight.normal,
            color: Color.fromRGBO(51, 101, 138, 1),
          ),
        )
      ],
    );
  }
}
