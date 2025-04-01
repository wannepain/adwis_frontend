import 'package:flutter_riverpod/flutter_riverpod.dart';

class HistoryManagmentNotifier extends StateNotifier<Map> {
  HistoryManagmentNotifier()
      : super({
          "show_history": [],
          "send_history": [],
        });

  Map updateHistory({required List show_history}) {
    final List<dynamic> sendHistory = List.from(show_history); // Copy the list

    sendHistory.removeWhere((record) =>
        record["show_career"] != null || record["declined"] != null);

    state = {
      "show_history": show_history,
      "send_history": sendHistory,
    };
    return {
      "show_history": show_history,
      "send_history": sendHistory,
    };
  }

  Map updateSendHistory({required List send_history}) {
    final newHistory = List.from(send_history); // Create a copy

    // Step 1: Remove all career suggestion cards & store their indexes
    final showHistory =
        List.from(state["show_history"]); // Copy existing history
    List<int> whereToShowCareer = [];

    int indexOfCareer =
        showHistory.indexWhere((element) => element["show_career"] == true);
    while (indexOfCareer != -1) {
      whereToShowCareer.add(indexOfCareer);
      showHistory.removeAt(indexOfCareer);
      indexOfCareer =
          showHistory.indexWhere((element) => element["show_career"] == true);
    }

    // Step 2: Insert the career suggestion at the **latest position**
    if (whereToShowCareer.isNotEmpty) {
      int lastCareerIndex = whereToShowCareer.last;
      newHistory.insert(lastCareerIndex, {"show_career": true});
    }

    // Step 3: Call `updateHistory` to update the provider
    return updateHistory(show_history: newHistory);
  }

  void addToHistory({required content}) {
    final List<dynamic> showHistory = state["show_history"];
    showHistory.add(content);
    this.updateHistory(show_history: showHistory);
  }

  void clean() {
    state = {
      "show_history": [],
      "send_history": [],
    };
  }
}

final historyManagmentProvider =
    StateNotifierProvider<HistoryManagmentNotifier, Map>((ref) {
  return HistoryManagmentNotifier();
});
