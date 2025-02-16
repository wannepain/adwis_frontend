import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestartNotifier extends StateNotifier<int> {
  RestartNotifier() : super(1);

  void increment() {
    if (state < 5) {
      state++;
    }
  }

  void reset() {
    state = 1;
  }
}

final restartProvider = StateNotifierProvider<RestartNotifier, int>((ref) {
  return RestartNotifier();
});
