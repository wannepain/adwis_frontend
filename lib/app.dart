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
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    ref.read(authProvider.notifier).checkSignedIn();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.hidden) {
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
