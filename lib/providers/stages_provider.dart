import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

class StagesNotifier extends StateNotifier<Map<String, dynamic>> {
  //store stage in file,
  StagesNotifier()
      : super({
          "current_stage": 1,
        });

  Future<void> load() async {
    //loads stored values from file
    // try {
    //   final file = await _localFile;
    //   if (await file.exists()) {
    //     final contents = await file.readAsString();
    //     final data = jsonDecode(contents);
    //     state = data ?? {"current_stage": 1};
    //   } else {
    //     state = {"current_stage": 1};
    //   }
    // } catch (e) {
    //   print(e);
    //   state = {"current_stage": 1};
    // }
  }

  Future<void> set() async {
    final file = await _localFile;
    int currentStage = state["current_stage"] ?? 1;
    int? storedStage;
    try {
      // if (await file.exists()) {
      //   final contents = await file.readAsString();
      //   final data = jsonDecode(contents);
      //   storedStage = data["current_stage"];
      // }
      if (storedStage != null && storedStage >= currentStage) {
        currentStage = storedStage;
      }
      final data = {
        "current_stage": currentStage + 1,
      };

      state = data;

      // **Await the file write operation**
      // await file.writeAsString(jsonEncode(data));

      // // **Confirm that file was written before updating state**
      // final writtenContents = await file.readAsString();
      // print("Stored Data: $writtenContents");

      // // **Now update the state after confirming the file is correct**
      // state = jsonDecode(writtenContents);
    } catch (e) {
      // print("Error storing career result: $e");
    }
  }

  Future<void> clean() async {
    final file = await _localFile;
    try {
      if (await file.exists()) {
        await file.delete();
      }
      state = {"current_stage": 1};
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
  return File('$path/stages.txt');
}

final stagesProvider =
    StateNotifierProvider<StagesNotifier, Map<String, dynamic>>((ref) {
  return StagesNotifier();
});
