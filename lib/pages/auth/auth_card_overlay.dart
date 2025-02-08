// import 'package:flutter/material.dart';
// import 'package:adwis_frontend/services/auth_service.dart';
// import 'package:adwis_frontend/pages/auth/utils/sign_up_card.dart';
// import 'package:adwis_frontend/pages/auth/utils/account_button.dart';

// class AuthCardOverlay extends StatefulWidget {
//   const AuthCardOverlay({super.key});

//   @override
//   State<AuthCardOverlay> createState() => _AuthCardOverlayState();
// }

// class _AuthCardOverlayState extends State<AuthCardOverlay> {
//   bool isOpen = false;

//   void onTap() {
//     AuthService().signInWithGoogle();
//   }

//   void close() {
//     setState(() {
//       isOpen = !isOpen;
//     });
//   }

//   @override // make the content overlay existing elements in ui
//   Widget build(BuildContext context) {
//     // return Column(
//     //   mainAxisAlignment:
//     //       isOpen ? MainAxisAlignment.end : MainAxisAlignment.start,
//     //   crossAxisAlignment: CrossAxisAlignment.stretch,
//     //   children: [
//     // isOpen
//     //     ? SignUpCard(
//     //         close: close,
//     //         onTap: onTap,
//     //       )
//     //     : AccountButton(
//     //         close: close,
//     //       ),
//     //     SizedBox(
//     //       height: 36,
//     //     )
//     //   ],
//     // );
//     return Positioned(
//       top: 0,
//       child: isOpen
//           ? SignUpCard(
//               close: close,
//               onTap: onTap,
//             )
//           : AccountButton(
//               close: close,
//             ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:adwis_frontend/services/auth_service.dart';
import 'package:adwis_frontend/pages/auth/utils/sign_up_card.dart';
import 'package:adwis_frontend/pages/auth/utils/account_button.dart';

class AuthCardOverlay extends StatefulWidget {
  const AuthCardOverlay({super.key});

  @override
  State<AuthCardOverlay> createState() => _AuthCardOverlayState();
}

class _AuthCardOverlayState extends State<AuthCardOverlay> {
  bool isOpen = false;

  void onTap() {
    AuthService().signInWithGoogle();
  }

  void close() {
    setState(() {
      isOpen = !isOpen;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        isOpen
            ? SignUpCard(
                close: close,
                onTap: onTap,
              )
            : AccountButton(
                close: close,
              ),
      ],
    );
  }
}
