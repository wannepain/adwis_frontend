import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:adwis_frontend/pages/home/sub/chat_buble.dart';
import 'package:adwis_frontend/pages/home/sub/text_input.dart';
import 'package:adwis_frontend/pages/home/sub/overlay_logo.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:adwis_frontend/utils/loader_center.dart';

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

  void setData() async {
    Map result = await postHttp();
    print(result);
    setState(() {
      history = result["history"] ?? [];
      usedQuestionIdx = result["usedQuestionIdx"] ?? [];
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToBottom();
    });
  }

  Future<Map> postHttp() async {
    try {
      print("history: $history");
      print("used idxs: $usedQuestionIdx");
      final response = await dio.post(
          "https://918a-45-84-122-28.ngrok-free.app/respond",
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
    return Scaffold(
      backgroundColor: Color.fromRGBO(252, 254, 255, 1),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 18),
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                controller: _scrollController,
                padding: EdgeInsets.symmetric(vertical: 18.0),
                itemCount: history.isEmpty ? 1 : history.length,
                itemBuilder: (context, index) {
                  if (history.isEmpty) {
                    return LoaderCenter();
                  }

                  String bot = history[index]['bot']['Question_Text'] ?? "";
                  String client = history[index]['client'] ?? "";

                  List<Widget> toReturn = [];
                  if (bot.isNotEmpty) {
                    toReturn.add(ChatBuble(text: bot, isMe: false));
                  }
                  if (client.isNotEmpty) {
                    toReturn.add(ChatBuble(text: client, isMe: true));
                  }

                  return Padding(
                    padding: EdgeInsets.symmetric(vertical: 8.0),
                    child: Column(children: toReturn),
                  );
                },
              ),
            ),
            TextInput(returnText: returnText),
            OverlayLogo(),
          ],
        ),
      ),
    );
  }
}
