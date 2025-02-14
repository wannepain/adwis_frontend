import 'package:flutter/material.dart';
import 'package:adwis_frontend/pages/onboarding/sub_pages/template_page.dart';
import 'dart:async';

class MainOnboarding extends StatefulWidget {
  const MainOnboarding({super.key});

  @override
  _MainOnboardingState createState() => _MainOnboardingState();
}

class _MainOnboardingState extends State<MainOnboarding> {
  var currentPage = 1;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        if (currentPage == 3) {
          currentPage = 1;
        } else {
          currentPage++;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (currentPage == 1) {
      return TemplatePage(type: "purpose");
    } else if (currentPage == 2) {
      return TemplatePage(type: "clarity");
    } else {
      return TemplatePage(type: "confidence");
    }
  }
}
