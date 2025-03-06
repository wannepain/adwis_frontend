import 'package:flutter/material.dart';
import 'package:adwis_frontend/pages/home/homepage.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class App extends ConsumerStatefulWidget {
  const App({super.key});

  @override
  ConsumerState<App> createState() => _AppState();
}

class _AppState extends ConsumerState<App> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adwis',
      home: Homepage(),
      routes: {"/homepage": (context) => Homepage()},
    );
  }
}
