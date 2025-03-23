import 'package:firebase_core/firebase_core.dart';
import 'package:adwis_frontend/firebase_options.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class FirebaseService {
  Future<void> inicializeFirebase() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }

  Future<User?> getUserData() async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    final User? user = _auth.currentUser;
    if (user != null) {
      return user;
    }
    return null;
  }

  Future<Map?> getSubscription(String uid) async {
    final FirebaseFirestore _firestore = FirebaseFirestore.instance;
    final DocumentSnapshot<Map<String, dynamic>> snapshot =
        await _firestore.collection("users").doc(uid).get();
    if (snapshot.exists) {
      return snapshot.data()!;
    } else {
      return null;
    }
  }

  // Future<String?> getPurchaseToken(String uid) async {
  //   final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  //   final DocumentSnapshot<Map<String, dynamic>> snapshot =
  //       await _firestore.collection("users").doc(uid).get();
  //   if (snapshot.exists) {
  //     return snapshot.data()!["purchaseToken"];
  //   } else {
  //     return null;
  //   }
  // }

  Future<User?> signInWithCredential(AuthCredential credential) async {
    final FirebaseAuth _auth = FirebaseAuth.instance;
    try {
      final UserCredential userCredential =
          await _auth.signInWithCredential(credential);
      final User? user = userCredential.user;
      return user;
    } catch (e) {
      print(e);
      return null;
    }
  }
}
