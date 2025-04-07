import 'package:adwis_frontend/utils/go_unlimited_snack_bar/go_unlimited_snack_bar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// A Riverpod provider that holds the current [SnackBarController].
/// This allows you to show or dismiss the snackbar from anywhere in the app.
final snackBarControllerProvider =
    StateProvider<SnackBarController?>((ref) => null);
