// import 'package:flutter/material.dart';
// import 'package:in_app_purchase/in_app_purchase.dart';
// import 'dart:async';

// class PaymentsService {
//   late StreamSubscription<dynamic> _subscription;
//   InAppPurchase _inAppPurchase = InAppPurchase.instance;
//   List<ProductDetails> _products = [];
//   final _variants = {"Adwis unlimited"};

//   void init(BuildContext context) {
//     final Stream purchaseUpdated = InAppPurchase.instance.purchaseStream;
//     _subscription = purchaseUpdated.listen((purchaseDetailsList) {
//       _listenToPurchaseUpdated(purchaseDetailsList, context);
//     }, onDone: () {
//       _subscription.cancel();
//     }, onError: (error) {
//       // handle error here.
//       print(error);
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("Error"),
//         ),
//       );
//     });
//     _initStore();
//   }

//   void dispose() {
//     _subscription.cancel();
//   }

//   void buy() {
//     final PurchaseParam param = PurchaseParam(productDetails: _products[0]);
//     _inAppPurchase.buyConsumable(purchaseParam: param);
//   }

//   void _initStore() async {
//     ProductDetailsResponse productDetailsResponse =
//         await _inAppPurchase.queryProductDetails(_variants);
//     if (productDetailsResponse.error == null) {
//       _products = productDetailsResponse.productDetails;
//     }
//   }

//   void _listenToPurchaseUpdated(
//       List<PurchaseDetails> purchaseDetailsList, BuildContext context) {
//     purchaseDetailsList.forEach(
//       (PurchaseDetails purchaseDetails) {
//         if (purchaseDetails.status == PurchaseStatus.pending) {
//           // pending execution
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text("Pedning"),
//             ),
//           );
//         } else if (purchaseDetails.status == PurchaseStatus.error) {
//           //handle error
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text("Oops! An error occured"),
//             ),
//           );
//         } else if (purchaseDetails.status == PurchaseStatus.purchased) {
//           // success
//           ScaffoldMessenger.of(context).showSnackBar(
//             const SnackBar(
//               content: Text("Success!"),
//             ),
//           );
//         }
//       },
//     );
//   }
// }
import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class PaymentsService {
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  List<ProductDetails> _products = [];
  final Set<String> _variants = {"adwis_unlimited"};

  /// Initializes the payment service
  void init(BuildContext context) {
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        _inAppPurchase.purchaseStream;
    _subscription = purchaseUpdated.listen(
      (purchaseDetailsList) {
        _listenToPurchaseUpdated(purchaseDetailsList, context);
      },
      onDone: () {
        _subscription.cancel();
      },
      onError: (error) {
        print("Error in purchase stream: $error");
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Error processing purchase")),
        );
      },
    );
    _initStore();
  }

  /// Fetches available subscription products
  Future<void> _initStore() async {
    final bool available = await _inAppPurchase.isAvailable();
    if (!available) {
      print("Store not available");
      return;
    }

    ProductDetailsResponse response =
        await _inAppPurchase.queryProductDetails(_variants);
    if (response.error != null) {
      print("Error fetching product details: ${response.error}");
      return;
    }
    if (response.productDetails.isEmpty) {
      print("No products found.");
      return;
    }

    _products = response.productDetails;
  }

  /// Initiates a purchase of a subscription
  void buy(ProductDetails productDetails) {
    final PurchaseParam purchaseParam =
        PurchaseParam(productDetails: productDetails);
    _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
  }

  /// Handles purchase updates
  void _listenToPurchaseUpdated(
      List<PurchaseDetails> purchaseDetailsList, BuildContext context) {
    for (var purchaseDetails in purchaseDetailsList) {
      switch (purchaseDetails.status) {
        case PurchaseStatus.pending:
          ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Purchase Pending...")));
          break;
        case PurchaseStatus.purchased:
          _verifyPurchase(purchaseDetails, context);
          final purchaseToken =
              purchaseDetails.verificationData.serverVerificationData;
          final productId = purchaseDetails.productID;
          final userId = FirebaseAuth.instance.currentUser?.uid;

          // Store in Firebase
          _storeSubscriptionInFirebase(userId, productId, purchaseToken);
          break;
        case PurchaseStatus.restored:
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Purchase Restored")));
          break;
        case PurchaseStatus.error:
          ScaffoldMessenger.of(context)
              .showSnackBar(const SnackBar(content: Text("Purchase Error!")));
          break;
        default:
          break;
      }
      if (purchaseDetails.pendingCompletePurchase) {
        _inAppPurchase.completePurchase(purchaseDetails);
      }
    }
  }

  /// Verifies the purchase (server-side verification recommended)
  void _verifyPurchase(PurchaseDetails purchaseDetails, BuildContext context) {
    // Here, you should verify the purchase on your backend server.
    // For testing purposes, we assume it’s valid.
    ScaffoldMessenger.of(context)
        .showSnackBar(const SnackBar(content: Text("Purchase Successful!")));
  }

  /// Restores previous purchases (useful for subscriptions)
  void restorePurchases() {
    _inAppPurchase.restorePurchases();
  }

  /// Dispose the subscription listener
  void dispose() {
    _subscription.cancel();
  }

  Future<void> _storeSubscriptionInFirebase(
      String? userId, String productId, String purchaseToken) async {
    if (userId == null) return;

    final docRef = FirebaseFirestore.instance.collection('users').doc(userId);
    await docRef.update({
      'productId': productId,
      'purchaseToken': purchaseToken,
      'timestamp': FieldValue.serverTimestamp(),
      'subscriptionActive': true
    });
  }

  /// Get the list of available products
  List<ProductDetails> get products => _products;
}
