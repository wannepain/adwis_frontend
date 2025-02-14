import 'package:flutter/material.dart';
import 'package:adwis_frontend/pages/home/sub/homepage_ui.dart';
import 'package:adwis_frontend/pages/auth/auth_card_overlay.dart';
import 'package:adwis_frontend/services/chatbot_service.dart';

class Homepage extends StatefulWidget {
  bool forceOpenAuth;
  Homepage({super.key, this.forceOpenAuth = false});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  //final dio = Dio();
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
      Map result = await ChatbotService().chatbotRespond(
        history: history,
        usedQuestionIdx: usedQuestionIdx,
      );
      print("result in history \n $result");
      setState(() {
        history = result["history"] ?? [];
        usedQuestionIdx = result["usedQuestionIdx"] ?? [];
      });
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _scrollToBottom();
      });
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
      body: Container(
        padding: EdgeInsets.all(6),
        child: Stack(
          children: [
            Positioned.fill(
              child: HomepageUi(
                  scrollController: _scrollController,
                  history: history,
                  restartConversation: restartConversation,
                  returnText: returnText),
            ),
            AuthCardOverlay(
              forceOpen: widget.forceOpenAuth,
              navigateAfter: widget.forceOpenAuth,
            ),
            Positioned(
              top: 200,
              left: 100,
              child: TextButton(
                onPressed: () {
                  setState(() {
                    Navigator.pushReplacementNamed(context, "/unlimited");
                  });
                },
                child: Text("show overlay"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
