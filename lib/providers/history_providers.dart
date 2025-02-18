// import 'dart:convert';
// import 'dart:io';

// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:path_provider/path_provider.dart';

// class HistoryNotifier extends StateNotifier<Map> {
//   HistoryNotifier() : super({"data": null});

//   Future<void> readHistory() async {
//     try {
//       final file = await _localFile;
//       final contents = await file.readAsString();
//       final data = jsonDecode(contents);
//       state = data!;
//     } catch (e) {
//       print(e);
//     }
//   }

//   Future<void> addToFile(List history) async {
//     //read currrent file contents
//     //add new contents to the previous one
//     final file = await _localFile;
//     try {
//       final contents = await file.readAsString();
//       final oldData = jsonDecode(contents);
//       List histories = oldData!["histories"];
//       histories.add(history);
//       final NewData = {
//         "data": histories,
//       };
//       file.writeAsString(jsonEncode(NewData));
//       state = NewData;
//     } catch (e) {
//       print(e);
//     }
//   }
// }

// Future<String> get _localPath async {
//   final directory = await getApplicationDocumentsDirectory();

//   return directory.path;
// }

// Future<File> get _localFile async {
//   final path = await _localPath;
//   return File('$path/history.txt');
// }

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

  Future<void> addToFile(List history) async {
    final file = await _localFile;
    try {
      if (await file.exists()) {
        final contents = await file.readAsString();
        final oldData = jsonDecode(contents);
        List histories = oldData["data"] ?? [];
        if (histories.length < 5) {
          histories.add(history);
        } else {
          histories.removeAt(0);
          histories.add(history);
        }
        final newData = {
          "data": histories,
        };
        await file.writeAsString(jsonEncode(newData));
        state = newData;
      } else {
        List histories = [history];
        final newData = {
          "data": histories,
        };
        await file.writeAsString(jsonEncode(newData));
        state = newData;
      }
    } catch (e) {
      print(e);
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
