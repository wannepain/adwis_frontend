import 'dart:async';
import 'package:adwis_frontend/providers/user_provider.dart';
import 'package:adwis_frontend/utils/snackbar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:in_app_purchase/in_app_purchase.dart';

class PaymentsService {
  late StreamSubscription<List<PurchaseDetails>> _subscription;
  final InAppPurchase _inAppPurchase = InAppPurchase.instance;
  List<ProductDetails> _products = [];
  final Set<String> _variants = {"adwis_unlimited"};

  /// Initializes the payment service
  void init(BuildContext context, WidgetRef ref) {
    final Stream<List<PurchaseDetails>> purchaseUpdated =
        _inAppPurchase.purchaseStream;
    _subscription = purchaseUpdated.listen(
      (purchaseDetailsList) {
        _listenToPurchaseUpdated(purchaseDetailsList, context, ref);
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
  Future<void> buy(ProductDetails productDetails) async {
    final PurchaseParam purchaseParam =
        PurchaseParam(productDetails: productDetails);
    await _inAppPurchase.buyNonConsumable(purchaseParam: purchaseParam);
  }

  /// Handles purchase updates
  void _listenToPurchaseUpdated(List<PurchaseDetails> purchaseDetailsList,
      BuildContext context, WidgetRef ref) {
    for (var purchaseDetails in purchaseDetailsList) {
      switch (purchaseDetails.status) {
        case PurchaseStatus.pending:
          showCustomSnackBar("Your purchase is pending");
          break;
        case PurchaseStatus.purchased:
          _verifyPurchase(purchaseDetails, context);
          final purchaseToken =
              purchaseDetails.verificationData.serverVerificationData;
          final productId = purchaseDetails.productID;
          final userId = FirebaseAuth.instance.currentUser?.uid;

          // Store in Firebase
          _storeSubscriptionInFirebase(userId, productId, purchaseToken, ref);
          break;
        case PurchaseStatus.restored:
          showCustomSnackBar("Your purchase has been restored");
          break;
        case PurchaseStatus.error:
          showCustomSnackBar("Error processing purchase");
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
    showCustomSnackBar("Purchase successful!");
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
    String? userId,
    String productId,
    String purchaseToken,
    WidgetRef ref,
  ) async {
    if (userId == null) return;

    final docRef = FirebaseFirestore.instance.collection('users').doc(userId);
    ref.read(userProvider.notifier).updateToken(purchaseToken);
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
