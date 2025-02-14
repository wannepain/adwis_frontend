import 'package:adwis_frontend/services/api_service.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class StripeService {
  StripeService._();

  static final StripeService instance = StripeService._();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  // Check if user is already signed in
  User? get currentUser => _auth.currentUser;

  Future<void> makePayment() async {
    try {
      // String customerId = await _getCustomerId(); // Corrected function call
      // if (customerId.isEmpty) {
      //   print("Error: Customer ID not found");
      //   return;
      // }
      var uid = currentUser?.uid as String;

      final clientSecret = await ApiService().createPaymentIntent(uid);
      if (clientSecret == null) {
        print("Error: Payment Intent failed");
        return;
      }

      await Stripe.instance.initPaymentSheet(
        paymentSheetParameters: SetupPaymentSheetParameters(
          paymentIntentClientSecret: clientSecret,
          merchantDisplayName: "Adwis",
        ),
      );
      await _processPayment();
    } catch (e) {
      print("Payment error: $e");
    }
  }

  Future<void> _processPayment() async {
    try {
      await Stripe.instance.presentPaymentSheet(); // Corrected method
    } catch (e) {
      print("Payment processing error: $e");
    }
  }

  // Future<String> _getCustomerId() async {
  //   final uid = currentUser?.uid;
  //   if (uid == null) {
  //     print("Error: User not authenticated");
  //     return "";
  //   }

  //   DocumentSnapshot userDoc =
  //       await FirebaseFirestore.instance.collection('users').doc(uid).get();

  //   if (userDoc.exists) {
  //     Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;

  //     return userData?["stripeCustomerId"] ?? ""; // Use correct field name
  //   } else {
  //     print("Error: User document not found");
  //     return "";
  //   }
  // }
}
