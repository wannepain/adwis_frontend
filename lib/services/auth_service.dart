import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:adwis_frontend/services/api_service.dart';

Future<void> storeUserData(User user) async {
  await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
    'email': user.email,
    'name': user.displayName,
    'uid': user.uid,
    'createdAt': FieldValue.serverTimestamp(),
  }, SetOptions(merge: true));
}

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Check if user is already signed in
  User? get currentUser => _auth.currentUser;

  Future<UserCredential?> signInWithGoogle() async {
    if (currentUser != null) {
      print("User already signed in: ${currentUser!.email}");
      return null; // No need to sign in again
    }

    // Start Google Sign-In
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    if (gUser == null) return null; // User canceled sign-in

    // Get auth details
    final GoogleSignInAuthentication gAuth = await gUser.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    // Sign in with Firebase
    final UserCredential userCredential =
        await _auth.signInWithCredential(credential);

    // Store user data
    await storeUserData(userCredential.user!);

    print("User signed in: ${userCredential.user!.email}");
    return userCredential;
  }

  // Check if user has an active subscription
  Future<bool> isUnlimited({required String uid}) async {
    DocumentSnapshot userDoc =
        await FirebaseFirestore.instance.collection('users').doc(uid).get();

    if (userDoc.exists) {
      Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;

      return userData?["subscriptionId"] != null &&
          userData?["subscriptionActive"] == true;
    }
    return false;
  }

  // Check if user is already signed in, else prompt login
  Future<Map<String, dynamic>> signIn() async {
    User? user = _auth.currentUser;

    if (user == null) {
      final userCredential = await signInWithGoogle();
      if (userCredential == null) return {"isSignedIn": false};

      user = userCredential.user;
      await ApiService().signUp(user: user!);
    }

    final uid = user!.uid;
    final userImage = user.photoURL;
    final unlimited = await isUnlimited(uid: uid);

    return {
      "isUnlimited": unlimited,
      "userImage": userImage,
      "isSignedIn": true,
      "userData": user!,
    };
  }

  Future<Map<String, dynamic>> isSignedIn() async {
    User? user = _auth.currentUser;

    if (user == null) {
      return {
        "isUnlimited": false,
        "userImage": "",
        "isSignedIn": false,
        "userData": "",
      };
    }

    final uid = user!.uid;
    final userImage = user.photoURL;
    final unlimited = await isUnlimited(uid: uid);

    return {
      "isUnlimited": unlimited,
      "userImage": userImage,
      "isSignedIn": true,
      "userData": user,
    };
  }

  // Sign out the user
  Future<Map> signOut() async {
    await FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
    return {
      "isUnlimited": false,
      "userImage": "",
      "isSignedIn": false,
      "userData": ""
    };
  }

  String getUid() {
    return currentUser!.uid;
  }
}
