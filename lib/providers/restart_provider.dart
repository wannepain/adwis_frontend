import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestartNotifier extends StateNotifier<Map<String, dynamic>> {
  RestartNotifier()
      : super({
          "restarts": 1,
          "career_declines": 1,
          "showing_snackbar": false,
        });

  void increment_restarts() {
    int? restarts = state["restarts"];

    if (restarts! < 5) {
      state = {
        "restarts": restarts + 1,
        "career_declines": state["career_declines"]!,
        "showing_snackbar": state["showing_snackbar"]!,
      };
    }
  }

  void reset_restarts() {
    state = {
      "restarts": 1,
      "career_declines": state["career_declines"]!,
      "showing_snackbar": state["showing_snackbar"]!,
    };
  }

  void increment_career_declines() {
    int? career_declines = state["career_declines"];

    state = {
      "restarts": state["restarts"]!,
      "career_declines": career_declines! + 1,
      "showing_snackbar": state["showing_snackbar"]!,
    };
  }

  void reset_career_declines() {
    state = {
      "restarts": state["restarts"]!,
      "career_declines": 1,
      "showing_snackbar": state["showing_snackbar"]!,
    };
  }

  void seShowingSnackBar(bool show) {
    state = {
      "restarts": state["restarts"]!,
      "career_declines": state["career_declines"]!,
      "showing_snackbar": show,
    };
  }
}

final restartProvider =
    StateNotifierProvider<RestartNotifier, Map<String, dynamic>>((ref) {
  return RestartNotifier();
});
