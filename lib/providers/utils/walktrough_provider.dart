import "dart:convert";
import "dart:io";

import "package:flutter_riverpod/flutter_riverpod.dart";
import "package:path_provider/path_provider.dart";

class WalkthroughNotifier extends StateNotifier<int> {
  WalkthroughNotifier() : super(0) {
    _initialize(); // Load saved progress on creation
  }

  Future<void> _initialize() async {
    await retrieveIncrement();
  }

  void increment() {
    state = state + 1;
    storeIncrement(); // Save immediately when incrementing
  }

  Future<void> storeIncrement() async {
    final file = await _localFile;
    try {
      final newData = jsonEncode({"data": state});
      await file.writeAsString(newData);
    } catch (e) {
      print("Error writing walkthrough progress: $e");
    }
  }

  Future<void> retrieveIncrement() async {
    final file = await _localFile;
    try {
      if (await file.exists()) {
        final contents = await file.readAsString();
        final parsedContents = jsonDecode(contents);
        state = parsedContents["data"] ?? 0;
      }
    } catch (e) {
      print("Error reading walkthrough progress: $e");
    }
  }
}

Future<String> get _localPath async {
  final directory = await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<File> get _localFile async {
  final path = await _localPath;
  return File('$path/walkthrough.json'); // Use JSON instead of .txt for clarity
}

final walkthroughProvider =
    StateNotifierProvider<WalkthroughNotifier, int>((ref) {
  return WalkthroughNotifier();
});
