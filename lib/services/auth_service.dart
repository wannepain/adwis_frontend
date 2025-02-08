import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> storeUserData(User user) async {
  await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
    'email': user.email,
    'name': user.displayName,
    'uid': user.uid,
    'createdAt': FieldValue.serverTimestamp(),
  }, SetOptions(merge: true));
}

class AuthService {
  //Google sign in
  Future<UserCredential> signInWithGoogle() async {
    // Begin interactive sign in
    final GoogleSignInAccount? gUser = await GoogleSignIn().signIn();
    if (gUser == null) return Future.error("Sign-in failed");

    // Obtain auth details from request
    final GoogleSignInAuthentication gAuth = await gUser.authentication;

    // Create a new credential for the user
    final credential = GoogleAuthProvider.credential(
      accessToken: gAuth.accessToken,
      idToken: gAuth.idToken,
    );

    // Sign in with Firebase
    final UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);

    // Store user data in Firestore
    await storeUserData(userCredential.user!);

    print("User signed in: ${userCredential.user!.email}");
    return userCredential;
  }
}
