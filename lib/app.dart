// import 'dart:isolate';

// import 'package:adwis_frontend/providers/auth_providers.dart';
// import 'package:flutter/material.dart';
// import 'package:adwis_frontend/pages/onboarding/main_onboarding.dart';
// import 'package:adwis_frontend/pages/home/homepage.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:adwis_frontend/pages/auth/account_managment/account_managment_screen.dart';
// import 'package:adwis_frontend/pages/auth/unlimited/unlimited_popup.dart';
// import 'package:adwis_frontend/providers/popup_providers.dart';

// class App extends ConsumerStatefulWidget {
//   const App({super.key});

//   @override
//   ConsumerState<App> createState() => _AppState();
// }

// class _AppState extends ConsumerState<App> with WidgetsBindingObserver {
//   void initAsyncLogic() async {
//     await ref.read(authProvider.notifier).checkSignedIn();
//     await ref.read(popupProvider.notifier).checkFirstOpen();
//     final bool openOpUp = ref.read(popupProvider);
//     print(openOpUp);
//     final Map data = ref.read(authProvider);
//     if (openOpUp && !data["isUnlimited"] && mounted) {
//       Navigator.pushNamed(context, "/unlimited");
//     }
//   }

//   @override
//   void initState() {
//     super.initState();
//     WidgetsBinding.instance.addObserver(this);
//     initAsyncLogic();
//   }

//   @override
//   void dispose() {
//     WidgetsBinding.instance.removeObserver(this);
//     super.dispose();
//   }

//   @override
//   void didChangeAppLifecycleState(AppLifecycleState state) async {
//     if (state == AppLifecycleState.detached) {
//       ref.read(popupProvider.notifier).reset();
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final data = ref.watch(authProvider); //do only once when the app loads
//     return ProviderScope(
//       child: MaterialApp(
//         title: 'Adwis',
//         home: data["isSignedIn"] ? Homepage() : MainOnboarding(),
//         routes: {
//           "/homepage": (context) => Homepage(),
//           "/onboarding": (context) => MainOnboarding(),
//           "/account": (context) => AccountManagmentScreen(),
//           "/unlimited": (context) => UnlimitedPopup(),
//           '/signup': (context) => Homepage(forceOpenAuth: true)
//         },
//       ),
//     );
//   }
// }

// import 'dart:isolate';
// import 'package:adwis_frontend/providers/auth_providers.dart';
// import 'package:flutter/material.dart';
// import 'package:adwis_frontend/pages/onboarding/main_onboarding.dart';
// import 'package:adwis_frontend/pages/home/homepage.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:adwis_frontend/pages/auth/account_managment/account_managment_screen.dart';
// import 'package:adwis_frontend/pages/auth/unlimited/unlimited_popup.dart';
// import 'package:adwis_frontend/providers/popup_providers.dart';

// class App extends ConsumerStatefulWidget {
//   const App({super.key});

//   @override
//   ConsumerState<App> createState() => _AppState();
// }

// class _AppState extends ConsumerState<App> {
//   @override
//   void initState() {
//     super.initState();
//     ref.read(authProvider.notifier).checkSignedIn();
//     ref.read(popupProvider.notifier).checkFirstOpen();
//   }

//   @override
//   void dispose() {
//     ref.read(popupProvider.notifier).reset();
//     print("dispose has been run");
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final data = ref.watch(authProvider); //do only once when the app loads
//     return MaterialApp(
//       title: 'Adwis',
//       home: data["isSignedIn"] ? Homepage() : MainOnboarding(),
//       routes: {
//         "/homepage": (context) => Homepage(),
//         "/onboarding": (context) => MainOnboarding(),
//         "/account": (context) => AccountManagmentScreen(),
//         "/unlimited": (context) => UnlimitedPopup(),
//         '/signup': (context) => Homepage(forceOpenAuth: true)
//       },
//     );
//   }
// }

import 'dart:isolate';
import 'package:adwis_frontend/providers/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:adwis_frontend/pages/onboarding/main_onboarding.dart';
import 'package:adwis_frontend/pages/home/homepage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:adwis_frontend/pages/auth/account_managment/account_managment_screen.dart';
import 'package:adwis_frontend/pages/auth/unlimited/unlimited_popup.dart';
import 'package:adwis_frontend/providers/popup_providers.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> with WidgetsBindingObserver {
  // @override
  // void initState() {
  //   super.initState();
  //   WidgetsBinding.instance.addObserver(this);
  //   ref.read(authProvider.notifier).checkSignedIn();
  //   ref.read(popupProvider.notifier).checkFirstOpen();
  // }

  // @override
  // void dispose() {
  //   WidgetsBinding.instance.removeObserver(this);
  //   ref.read(popupProvider.notifier).reset();
  //   print("dispose has been run");
  //   super.dispose();
  // }

  // @override
  // void didChangeAppLifecycleState(AppLifecycleState state) {
  //   if (state == AppLifecycleState.detached) {
  // print("resetting notifier");
  // ref.read(popupProvider.notifier).reset();
  //   }
  // }

  AppLifecycleState? _lastLifecycleState;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.hidden) {
      print("resetting notifier, state: $state");
      ref.read(popupProvider.notifier).reset();
    }
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(authProvider); //do only once when the app loads
    return MaterialApp(
      title: 'Adwis',
      home: data["isSignedIn"] ? Homepage() : MainOnboarding(),
      routes: {
        "/homepage": (context) => Homepage(),
        "/onboarding": (context) => MainOnboarding(),
        "/account": (context) => AccountManagmentScreen(),
        "/unlimited": (context) => UnlimitedPopup(),
        '/signup': (context) => Homepage(forceOpenAuth: true)
      },
    );
  }
}
