// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:dio/dio.dart';
// import 'package:adwis_frontend/pages/home/sub/homepage_ui.dart';
// import 'package:adwis_frontend/pages/auth/auth_card_overlay.dart';

// class Homepage extends StatefulWidget {
//   const Homepage({super.key});

//   @override
//   _HomepageState createState() => _HomepageState();
// }

// class _HomepageState extends State<Homepage> {
//   //fix Bad state: No Element error
//   final dio = Dio();
//   final ScrollController _scrollController = ScrollController();

//   List history = [];
//   List usedQuestionIdx = [];

//   @override
//   void dispose() {
//     _scrollController.dispose();
//     super.dispose();
//   }

//   void _scrollToBottom() {
//     if (_scrollController.hasClients) {
//       _scrollController.animateTo(
//         _scrollController.position.maxScrollExtent,
//         duration: Duration(milliseconds: 300),
//         curve: Curves.easeOut,
//       );
//     }
//   }

//   void returnText(String text) {
//     if (history.isEmpty) {
//       return;
//     }
//     setState(() {
//       history[history.length - 1]['client'] = text;
//     });
//     setData();
//   }

//   void restartConversation() {
//     setState(() {
//       history = [];
//       usedQuestionIdx = [];
//     });
//     setData();
//   }

//   void setData() async {
//     if (history.length > 1) {
//       //logic here is that there will be a special last log appended to history]
//       history.add({"end": true});
//     } else {
//       Map result = await postHttp();
//       setState(() {
//         history = result["history"] ?? [];
//         usedQuestionIdx = result["usedQuestionIdx"] ?? [];
//       });
//       WidgetsBinding.instance.addPostFrameCallback((_) {
//         _scrollToBottom();
//       });
//     }
//   }

//   Future<Map> postHttp() async {
//     try {
//       print("history: $history");
//       print("used idxs: $usedQuestionIdx");
//       final response = await dio.post(
//           "https://4615-45-84-122-21.ngrok-free.app/respond",
//           data: {"history": history, "used_question_idx": usedQuestionIdx});

//       return {
//         "history": jsonDecode(response.data)['history'],
//         "usedQuestionIdx": jsonDecode(response.data)['used_question_idx'],
//         "error": false,
//       };
//     } catch (e) {
//       print('Error: $e');
//       return {"history": null, "usedQuestionIdx": null, "error": e};
//     }
//   }

//   @override
//   void initState() {
//     setData();
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Stack(
//       children: [
//         Positioned.fill(
//           child: HomepageUi(
//               scrollController: _scrollController,
//               history: history,
//               restartConversation: restartConversation,
//               returnText: returnText),
//         ),
//         AuthCardOverlay(),
//       ],
//     );
//   }
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:adwis_frontend/pages/home/sub/homepage_ui.dart';
import 'package:adwis_frontend/pages/auth/auth_card_overlay.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final dio = Dio();
  final ScrollController _scrollController = ScrollController();

  List history = [];
  List usedQuestionIdx = [];

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void returnText(String text) {
    if (history.isEmpty) {
      return;
    }
    setState(() {
      history[history.length - 1]['client'] = text;
    });
    setData();
  }

  void restartConversation() {
    setState(() {
      history = [];
      usedQuestionIdx = [];
    });
    setData();
  }

  void setData() async {
    if (history.length > 1) {
      history.add({"end": true});
    } else {
      Map result = await postHttp();
      setState(() {
        history = result["history"] ?? [];
        usedQuestionIdx = result["usedQuestionIdx"] ?? [];
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToBottom();
      });
    }
  }

  Future<Map> postHttp() async {
    try {
      print("history: $history");
      print("used idxs: $usedQuestionIdx");
      final response = await dio.post(
          "https://4615-45-84-122-21.ngrok-free.app/respond",
          data: {"history": history, "used_question_idx": usedQuestionIdx});

      return {
        "history": jsonDecode(response.data)['history'],
        "usedQuestionIdx": jsonDecode(response.data)['used_question_idx'],
        "error": false,
      };
    } catch (e) {
      print('Error: $e');
      return {"history": null, "usedQuestionIdx": null, "error": e};
    }
  }

  @override
  void initState() {
    setData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: HomepageUi(
              scrollController: _scrollController,
              history: history,
              restartConversation: restartConversation,
              returnText: returnText),
        ),
        AuthCardOverlay(),
      ],
    );
  }
}
