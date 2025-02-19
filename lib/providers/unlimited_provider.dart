import "package:flutter_riverpod/flutter_riverpod.dart";

class UnlimitedNotifier extends StateNotifier<Map<String, dynamic>> {
  UnlimitedNotifier()
      : super({
          "resetTime": 0,
          "reset": false,
        });

  // Should store the time when the restarts reset
  void storeTime(int timeInUnix) {
    final currentTime = DateTime.now().millisecondsSinceEpoch;
    final isReset = currentTime >= timeInUnix;
    state = {
      "resetTime": timeInUnix,
      "reset": isReset,
    };
  }

  void checkReset() {
    final currentTime = DateTime.now().millisecondsSinceEpoch;

    final oldTime = state["resetTime"];
    final isReset = currentTime > oldTime;
    state = {
      "resetTime": oldTime,
      "reset": isReset,
    };
  }
}

final unlimitedProvider =
    StateNotifierProvider<UnlimitedNotifier, Map<String, dynamic>>((ref) {
  return UnlimitedNotifier();
});
