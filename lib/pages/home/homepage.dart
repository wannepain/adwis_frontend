import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:adwis_frontend/pages/home/sub/chat_buble.dart';
import 'package:adwis_frontend/pages/home/sub/text_input.dart';
import 'package:adwis_frontend/pages/home/sub/overlay_logo.dart';
import 'package:adwis_frontend/utils/loader_center.dart';
import 'package:adwis_frontend/pages/home/sub/career/career_card.dart';
import 'package:adwis_frontend/pages/home/sub/career/restart_conv_button.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  //fix Bad state: No Element error
  final dio = Dio();
  final url = "https://361c-45-84-122-5.ngrok-free.app";
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
      //logic here is that there will be a special last log appended to history]
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
      final response = await dio.post("$url/respond",
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
                itemCount: history.isNotEmpty && history.last["end"] == true
                    ? history.length + 1 // Extra item for CareerCard
                    : history.length,
                itemBuilder: (context, index) {
                  // If this is the last item and history.last["end"] == true, show CareerCard
                  if (index == history.length && history.last["end"] == true) {
                    return CareerCard(
                        history: history.sublist(0, history.length - 1));
                  }

                  // Normal chat bubbles
                  var bot = history[index]['bot'] == null
                      ? ""
                      : history[index]['bot']['Question_Text'];
                  var client = history[index]['client'] ?? "";

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
            // Restart button OR text input below CareerCard
            history.isNotEmpty && history.last["end"] == true
                ? RestartConvButton(restart: restartConversation)
                : TextInput(returnText: returnText),
            OverlayLogo(),
          ],
        ),
      ),
    );
  }
}
