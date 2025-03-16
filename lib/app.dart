import 'package:adwis_frontend/pages/unlimited/go_unlimited.dart';
import 'package:adwis_frontend/services/payments_service.dart';
import 'package:flutter/material.dart';
import 'package:adwis_frontend/pages/home/homepage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:adwis_frontend/pages/user/auth_screen.dart';
import 'package:adwis_frontend/providers/user_provider.dart';
import 'package:adwis_frontend/pages/user/account_managment.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  void initFunction() async {
    await ref.read(userProvider.notifier).getUserData();
  }

  @override
  void initState() {
    super.initState();
    initFunction();
    PaymentsService().init(context);
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
    return MaterialApp(
      title: 'Adwis',
      home: Homepage(),
      routes: {
        "/homepage": (context) => Homepage(),
        "/auth": (context) => isAuth ? AccountManagment() : AuthScreen(),
        "/unlimited": (context) =>
            isUnlimited ? AccountManagment() : GoUnlimited(),
      },
    );
  }
}
