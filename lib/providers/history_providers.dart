import 'dart:convert';
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';

class HistoryNotifier extends StateNotifier<Map> {
  HistoryNotifier() : super({"data": []});

  Future<void> readHistory() async {
    try {
      final file = await _localFile;
      if (await file.exists()) {
        final contents = await file.readAsString();
        final data = jsonDecode(contents);
        state = data ?? {"data": []};
      } else {
        state = {"data": []};
      }
    } catch (e) {
      print(e);
      state = {"data": []};
    }
  }

  // Future<void> addToFile(Map career_result) async {
  //   final file = await _localFile;
  //   try {
  //     if (await file.exists()) {
  //       final contents = await file.readAsString();
  //       final oldData = jsonDecode(contents);
  //       List careers = oldData["data"] ?? [];
  //       if (careers.length < 5) {
  //         careers.add(career_result);
  //       } else {
  //         careers.removeAt(0);
  //         careers.add(career_result);
  //       }
  //       final newData = {
  //         "data": careers,
  //       };
  //       await file.writeAsString(jsonEncode(newData));
  //       state = newData;
  //     } else {
  //       List careers = [career_result];
  //       final newData = {
  //         "data": careers,
  //       };
  //       await file.writeAsString(jsonEncode(newData));
  //       state = newData;
  //     }
  //   } catch (e) {
  //     print(e);
  //   }
  // }
  Future<void> addToFile(Map career_result) async {
    final file = await _localFile;
    try {
      Map<String, dynamic> newData;

      if (await file.exists()) {
        final contents = await file.readAsString();
        final oldData = jsonDecode(contents);
        List careers = oldData["data"] ?? [];

        if (careers.length < 5) {
          careers.add(career_result);
        } else {
          careers.removeAt(0);
          careers.add(career_result);
        }

        newData = {"data": careers};
      } else {
        newData = {
          "data": [career_result]
        };
      }

      // **Await the file write operation**
      await file.writeAsString(jsonEncode(newData));

      // **Confirm that file was written before updating state**
      final writtenContents = await file.readAsString();
      print("Stored Data: $writtenContents");

      // **Now update the state after confirming the file is correct**
      state = jsonDecode(writtenContents);
    } catch (e) {
      print("Error storing career result: $e");
    }
  }

  Future<void> clean() async {
    final file = await _localFile;
    try {
      if (await file.exists()) {
        await file.delete();
      }
      state = {"data": []};
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
  return File('$path/history.txt');
}

final historyProvider = StateNotifierProvider<HistoryNotifier, Map>((ref) {
  return HistoryNotifier();
});
