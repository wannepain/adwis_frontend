import 'package:adwis_frontend/pages/home/sub/Stages/stage_advance_screen.dart';
import 'package:adwis_frontend/pages/speech/main_speech.dart';
import 'package:adwis_frontend/pages/unlimited/go_unlimited.dart';
import 'package:adwis_frontend/providers/history_providers.dart';
import 'package:adwis_frontend/providers/stages_provider.dart';
import 'package:adwis_frontend/services/payments_service.dart';
import 'package:adwis_frontend/utils/go_unlimited_snack_bar/go_unlimited_snack_bar.dart';
//import 'package:adwis_frontend/utils/compliment_snack_bar.dart';
import 'package:flutter/material.dart';
import 'package:adwis_frontend/pages/home/homepage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:adwis_frontend/pages/user/auth_screen.dart';
import 'package:adwis_frontend/providers/user_provider.dart';
import 'package:adwis_frontend/pages/user/account_managment.dart';

import 'services/navigation_service.dart';

class App extends ConsumerStatefulWidget {
  final snackBarKey;
  const App({super.key, required this.snackBarKey});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  void initFunction() async {
    await ref.read(userProvider.notifier).getUserData();
    await ref.read(historyProvider.notifier).clean();
    await ref.read(stagesProvider.notifier).load();
  }

  @override
  void initState() {
    super.initState();
    initFunction();
    PaymentsService().init(context, ref);
  }

  @override
  void dispose() {
    PaymentsService().dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final userData = ref.watch(userProvider);
    final isAuth = userData["uid"] != null;
    final isUnlimited = userData["isUnlimited"];
    final currentStage = ref.watch(stagesProvider)["current_stage"];
    // return MaterialApp(
    //   title: 'Adwis',
    //   scaffoldMessengerKey: widget.snackBarKey,
    //   navigatorKey: navigatorKey,
    //   navigatorObservers: [SnackBarDismissObserver()],
    //   home: Homepage(
    //     stage: currentStage,
    //   ),
    //   routes: {
    //     "/homepage": (context) => Homepage(
    //           stage: currentStage,
    //         ),
    //     // "/homepage/2": (context) => Homepage(
    //     //       stage: 2,
    //     //     ),
    //     // "/homepage/3": (context) => Homepage(
    //     //       stage: 3,
    //     // ),
    //     "/congratulations": (context) => StageAdvanceScreen(),
    //     "/auth": (context) => isAuth ? AccountManagment() : AuthScreen(),
    //     "/unlimited": (context) =>
    //         isUnlimited ? AccountManagment() : GoUnlimited(),
    //     "/speech": (context) =>
    //         MainSpeech(), //only for unlimited users, add a check here
    //   },
    // );
    return MaterialApp(
      initialRoute: '/homepage',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/homepage':
            final int? stage = settings.arguments as int?;
            return MaterialPageRoute(
              builder: (context) => Homepage(stage: stage),
            );

          case '/congratulations':
            return MaterialPageRoute(
              builder: (context) => StageAdvanceScreen(),
            );

          case '/auth':
            return MaterialPageRoute(
              builder: (context) => isAuth ? AccountManagment() : AuthScreen(),
            );

          case '/unlimited':
            final String? returnTo = settings.arguments as String?;
            return MaterialPageRoute(
              builder: (context) => isUnlimited
                  ? AccountManagment()
                  : GoUnlimited(
                      returnTo: returnTo,
                    ),
            );

          case '/speech':
            return MaterialPageRoute(
              builder: (context) => MainSpeech(),
            );

          default:
            return null;
        }
      },
    );
  }
}
