import 'package:adwis_frontend/pages/onboarding/main_onboarding.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adwis',
      home: Scaffold(
        body: Container(
          padding: EdgeInsets.all(6),
          child: MainOnboarding(),
        ),
      ),
    );
  }
}
