import 'package:adwis_frontend/providers/auth_providers.dart';
import 'package:flutter/material.dart';
import 'package:adwis_frontend/pages/onboarding/main_onboarding.dart';
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
        },
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:adwis_frontend/pages/onboarding/main_onboarding.dart';
// import 'package:adwis_frontend/pages/home/homepage.dart';
// import 'package:adwis_frontend/providers/auth_providers.dart';

// class App extends ConsumerWidget {
//   const App({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // Watch the state of signUpStateProvider
//     final signUpState = ref.watch(signUpStateProvider);

//     // If the sign-up state is still loading, show a loading indicator.
//     if (signUpState == null) {
//       return MaterialApp(
//         title: 'Adwis',
//         home: const Scaffold(body: Center(child: CircularProgressIndicator())),
//       );
//     }

//     // If an error occurred, show the error message.
//     if (signUpState.containsKey('error')) {
//       return MaterialApp(
//         title: 'Adwis',
//         home: Scaffold(
//             body: Center(child: Text('Error: ${signUpState['error']}'))),
//       );
//     }

//     // Check if the user is signed in, and show the appropriate page.
//     return MaterialApp(
//       title: 'Adwis',
//       home: signUpState['isSignedIn'] == true
//           ? const Homepage()
//           : const MainOnboarding(),
//       routes: {
//         '/homepage': (context) => const Homepage(),
//         '/onboarding': (context) => const MainOnboarding(),
//       },
//     );
//   }
// }
