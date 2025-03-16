import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:adwis_frontend/services/auth_service.dart';

class UserNotifier extends StateNotifier<Map> {
  UserNotifier()
      : super(
          {
            "uid": null,
            "email": null,
            "displayName": null,
            "photoURL": null,
            "isUnlimited": false,
          },
        );
  Future<void> signInWithGoogle() async {
    Map userData = await AuthService().singInGoogle();
    state = userData;
  }

  Future<void> getUserData() async {
    Map userData = await AuthService().getUserData();
    state = userData;
  }

  Future<void> signOut() async {
    AuthService().signOut();
    state = {
      "uid": null,
      "email": null,
      "displayName": null,
      "photoURL": null,
      "isUnlimited": false,
    };
  }
}

final userProvider = StateNotifierProvider<UserNotifier, Map>((ref) {
  return UserNotifier();
});
