import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

class StageHistoryNotifier extends StateNotifier<Map<String, dynamic>> {
  // saves both histories for all stages in a file
  StageHistoryNotifier()
      : super({
          "stage_1": {
            "show_history": [],
            "send_history": [],
          },
          "stage_2": {
            "show_history": [],
            "send_history": [],
          },
          "stage_3": {
            "show_history": [],
            "send_history": [],
          },
        });

  void updateHistory({
    required List showHistory,
    required String stage,
  }) {
    final List<dynamic> sendHistory = List.from(showHistory); // Copy the list

    sendHistory.removeWhere((record) =>
        record["show_career"] != null || record["declined"] != null);

    state = {
      ...state,
      stage: {
        "send_history": sendHistory,
        "show_history": showHistory,
      },
    };
  }

  void updateSendHistory({required List sendHistory, required String stage}) {
    if (sendHistory.isEmpty) {
      print("Warning: sendHistory is empty!");
    }

    final newHistory = List.from(sendHistory); // Create a copy

    // Step 1: Remove all career suggestion cards & store their indexes
    final showHistory =
        List.from(state[stage]["show_history"]); // Copy existing history
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
    updateHistory(showHistory: newHistory, stage: stage);
  }

  void addToHistory({required content, required String stage}) {
    final List<dynamic> showHistory = state[stage]["show_history"];
    showHistory.add(content);
    updateHistory(showHistory: showHistory, stage: stage);
  }

  void clean() {
    state = {
      "stage_1": {
        "show_history": [],
        "send_history": [],
      },
      "stage_2": {
        "show_history": [],
        "send_history": [],
      },
      "stage_3": {
        "show_history": [],
        "send_history": [],
      },
    };
  }

  Future<void> save() async {
    final file = await _localFile;
    Map<String, dynamic> previousData = {};

    try {
      if (await file.exists()) {
        final contents = await file.readAsString();
        previousData = jsonDecode(contents) ?? {};
      }

      // Merge non-null previous values into the current state
      final Map<String, dynamic> mergedState = {};

      for (final stageKey in state.keys) {
        final currentStage = state[stageKey] ?? {};
        final previousStage = previousData[stageKey] ?? {};

        mergedState[stageKey] = {
          "show_history": (currentStage["show_history"]?.isNotEmpty ?? false)
              ? currentStage["show_history"]
              : previousStage["show_history"] ?? [],
          "send_history": (currentStage["send_history"]?.isNotEmpty ?? false)
              ? currentStage["send_history"]
              : previousStage["send_history"] ?? [],
        };
      }

      await file.writeAsString(jsonEncode(mergedState));

      final writtenContents = await file.readAsString();
      print("Stored Data: $writtenContents");
    } catch (e) {
      print("Error storing career result: $e");
    }
  }

  Future<void> load() async {
    try {
      final file = await _localFile;
      if (await file.exists()) {
        final contents = await file.readAsString();
        final data = jsonDecode(contents);
        state = data ?? state;
      }
    } catch (e) {
      print(e);
    }
  }
}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/stages_history.txt');
}

final stagesHistoryProvider =
    StateNotifierProvider<StageHistoryNotifier, Map<String, dynamic>>((ref) {
  return StageHistoryNotifier();
});
