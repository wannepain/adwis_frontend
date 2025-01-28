import 'package:flutter/material.dart';
import 'package:adwis_frontend/pages/onboarding/sub_pages/template_page.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adwis',
      home: Scaffold(
        body: Container(
            padding: EdgeInsets.all(6), child: TemplatePage(type: 'purpose')),
      ),
    );
  }
}
