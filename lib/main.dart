import 'package:adwis_frontend/pages/onboarding/main_onboarding.dart';
import 'package:flutter/material.dart';
// import 'package:adwis_frontend/pages/auth/auth_card_overlay.dart';

import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  MainApp({super.key});

  final history = [
    {
      "bot": {
        "ID": 1,
        "Question_Text":
            "Hi! I’m here to help you explore your skills and interests. Ready to start?"
      },
      "client": "yes"
    },
    {
      "bot": {
        "ID": 16,
        "Question_Text":
            "Do you thrive in a competitive or collaborative work environment?"
      },
      "client": "both"
    },
    {
      "bot": {
        "ID": 2,
        "Question_Text":
            "What’s something you really enjoy doing in your free time?"
      },
      "client": "coding"
    },
    {
      "bot": {
        "ID": 11,
        "Question_Text": "How do you prefer to learn new things?"
      },
      "client": "by doing them and failing"
    },
    {
      "bot": {
        "ID": 28,
        "Question_Text":
            "Do you see your work as a means to an end, or do you want it to reflect your passion and purpose?"
      },
      "client": "purpose"
    },
    {
      "bot": {
        "ID": 9,
        "Question_Text":
            "If you could choose any job without thinking about money, what would it be?"
      },
      "client": "it would be to be leader of a movement"
    },
    {
      "bot": {
        "ID": 7,
        "Question_Text":
            "Do you have any goals for your future? If yes, can you describe one?"
      },
      "client": "its to become rich"
    },
    {
      "bot": {
        "ID": 29,
        "Question_Text":
            "Would you prefer a job with flexible working hours or one that is more traditional?"
      },
      "client": "it doesn't matter."
    }
  ];

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
