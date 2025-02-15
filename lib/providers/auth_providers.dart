import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:adwis_frontend/services/auth_service.dart";

class AuthNotifier extends StateNotifier<Map> {
  AuthNotifier()
      : super(
          //sets initial data
          {
            "isUnlimited": false,
            "userImage": "",
            "isSignedIn": false,
            "userData": "",
          },
        );
  Future<void> checkSignedIn() async {
    final result = await AuthService().isSignedIn();
    print(result);
    state = result;
  }

  Future<void> signIn() async {
    final result = await AuthService().signIn();
    state = result;
  }

  void signOut() async {
    final result = await AuthService().signOut();
    state = result;
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, Map>((ref) {
  return AuthNotifier();
});
