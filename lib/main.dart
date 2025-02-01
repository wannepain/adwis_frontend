//import 'package:adwis_frontend/pages/home/homepage.dart';
import 'package:adwis_frontend/pages/home/homepage.dart';
import 'package:adwis_frontend/pages/onboarding/main_onboarding.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
// import 'package:adwis_frontend/pages/onboarding/main_onboarding.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});
  final dio = Dio();

  void testHttp() async {
    try {
      final response =
          await dio.get("https://918a-45-84-122-28.ngrok-free.app");
      print(response);
    } catch (e) {
      print(e);
    }
  }

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
