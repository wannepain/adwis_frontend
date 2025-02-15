import "package:flutter_riverpod/flutter_riverpod.dart";
import 'package:is_first_run/is_first_run.dart';

class OpenNotifier extends StateNotifier<bool> {
  OpenNotifier() : super(
            //sets initial data
            true);
  Future<void> checkFirstOpen() async {
    state = await IsFirstRun.isFirstRun();
    print("result in checkFirtOpen: $state");
  }

  void setTo({required value}) {
    state = value;
  }

  reset() {
    state = true;
    IsFirstRun.reset();
    print(state);
  }
}

final popupProvider = StateNotifierProvider<OpenNotifier, bool>((ref) {
  return OpenNotifier();
});
