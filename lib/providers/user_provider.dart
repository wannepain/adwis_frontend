import 'package:adwis_frontend/services/api_service.dart';
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
            "subscriptionData": null,
            "purhcaseToken": null,
          },
        );
  Future<void> signInWithGoogle() async {
    Map userData = await AuthService().singInGoogle();

    state = userData;
  }

  Future<void> getUserDataNoUpdate() async {
    Map userData = await AuthService().getUserData();

    state = {...userData, "subscriptionData": state["subscriptionData"]};
  }

  Future<void> getUserData() async {
    //make request to api for latest data on payments
    if (state["purhcaseToken"] == null) {
      Map userData = await AuthService().getUserData();
      //get purchase token from firebase, check whether is valid with api
      final Map? apiResult = await ApiService().checkSubscription(
        uid: userData["uid"],
        token: userData["purchaseToken"],
      );
      state = {
        ...userData,
        "subscriptionData": apiResult!["subscriptionActive"] ? apiResult : null,
        "purhcaseToken": state["purhcaseToken"],
      };
      return;
    } else {
      final Map? apiResult = await ApiService().checkSubscription(
        uid: state["uid"],
        token: state["purhcaseToken"],
      );
      print(apiResult);
      Map userData = await AuthService().getUserData();
      state = {
        ...userData,
        "subscriptionData": apiResult,
        "purhcaseToken": state["purhcaseToken"],
      };
    }
  }

  Future<void> signOut() async {
    AuthService().signOut();
    state = {
      "uid": null,
      "email": null,
      "displayName": null,
      "photoURL": null,
      "isUnlimited": false,
      "subscriptionData": null,
      "purhcaseToken": null,
    };
  }

  Future<void> updateToken(String token) async {
    state = {
      ...state,
      "purhcaseToken": token,
    };
  }
}

final userProvider = StateNotifierProvider<UserNotifier, Map>((ref) {
  return UserNotifier();
});
