import 'package:adwis_frontend/providers/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:adwis_frontend/pages/onboarding/main_onboarding.dart';
import 'package:adwis_frontend/pages/home/homepage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:adwis_frontend/pages/auth/account_managment/account_managment_screen.dart';
import 'package:adwis_frontend/pages/auth/unlimited/unlimited_popup.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  @override
  void initState() {
    super.initState();
    ref.read(authProvider.notifier).checkSignedIn();
  }

  @override
  Widget build(BuildContext context) {
    final data = ref.watch(authProvider); //do only once when the app loads
    return ProviderScope(
      child: MaterialApp(
        title: 'Adwis',
        home: data["isSignedIn"] ? Homepage() : MainOnboarding(),
        routes: {
          "/homepage": (context) => Homepage(),
          "/onboarding": (context) => MainOnboarding(),
          "/account": (context) => AccountManagmentScreen(),
          "/unlimited": (context) => UnlimitedPopup(),
          '/signup': (context) => Homepage(forceOpenAuth: true)
        },
      ),
    );
  }
}
