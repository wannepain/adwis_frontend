import 'package:adwis_frontend/pages/onboarding/main_onboarding.dart';
import 'package:flutter/material.dart';
import 'package:adwis_frontend/pages/home/sub/career/career_card.dart';

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
          // child: MainOnboarding(),
          child: CareerCard(
              title: "Career Card",
              description:
                  "Lorem ipsum dolor sit amet, consectetur.  Lorem ipsum dolor sit amet, consectetur",
              salary: "10 000"),
        ),
      ),
    );
  }
}
