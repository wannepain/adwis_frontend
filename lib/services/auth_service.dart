import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:adwis_frontend/services/firebase_service.dart';

class AuthService {
  Future<Map> singInGoogle() async {
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();

    final GoogleSignInAuthentication googleAuth = await gUser!.authentication;

    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );
    final user = await FirebaseService().signInWithCredential(credential);

    // await FirebaseService().initNotifications();

    print(user);
    return {
      "uid": user!.uid,
      "email": user.email,
      "displayName": user.displayName,
      "photoURL": user.photoURL,
      "isUnlimited": false,
    };
  }

  Future<Map> getUserData() async {
    final User? user = await FirebaseService().getUserData();
    final Map? subscription =
        await FirebaseService().getSubscription(user!.uid);
    final isUnlimited = subscription != null
        ? subscription["subscriptionActive"] != null
            ? subscription["subscriptionActive"]
            : false
        : false;

    // Map? subscriptionData = {
    //   "subcriptionActive": subscription!["subscriptionActive"],
    //   "nextCharge": subscription!["nextCharge"],
    //   "subscriptionType": subscription!["subscriptionType"],
    // };
    String? purchaseToken = subscription!["purchaseToken"];
    print("purchaseToken: $purchaseToken");
    if (user != null) {
      return {
        "uid": user.uid,
        "email": user.email,
        "displayName": user.displayName,
        "photoURL": user.photoURL,
        "isUnlimited": isUnlimited,
        "purchaseToken": purchaseToken,
        // "subscriptionData": subscriptionData,
      };
    }
    return {
      "uid": null,
      "email": null,
      "displayName": null,
      "photoURL": null,
      "isUnlimited": null,
    };
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
