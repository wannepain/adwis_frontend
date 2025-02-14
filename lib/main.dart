// import 'package:flutter/material.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'firebase_options.dart';
// import 'package:adwis_frontend/app.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';

// const stripePublishableKey = "pk_test_51QpkBuGg7dfr3NgwNbbGJXQ8aJH9JrL8OIF8wXVvxE8y25soDdtnqUc26S7IqLSqeV8KCbk1OrrjHkZfxxhkikZS00PmavGBFg";

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   await Stripe.publishableKey = stripePublishableKey;
//   await Firebase.initializeApp(
//     options: DefaultFirebaseOptions.currentPlatform,
//   );
//   runApp(MainApp());
// }

// class MainApp extends StatelessWidget {
//   const MainApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return ProviderScope(child: App());
//   }
// }
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'firebase_options.dart';
import 'package:adwis_frontend/app.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

const stripePublishableKey =
    "pk_test_51QpkBuGg7dfr3NgwNbbGJXQ8aJH9JrL8OIF8wXVvxE8y25soDdtnqUc26S7IqLSqeV8KCbk1OrrjHkZfxxhkikZS00PmavGBFg";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Stripe.publishableKey = stripePublishableKey;

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const ProviderScope(child: App());
  }
}
