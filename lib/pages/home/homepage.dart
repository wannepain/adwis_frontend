import 'package:flutter/material.dart';
import 'package:adwis_frontend/pages/home/sub/homepage_ui.dart';
import 'package:adwis_frontend/pages/auth/auth_card_overlay.dart';
import 'package:adwis_frontend/services/api_service.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  //final dio = Dio();
  final ScrollController _scrollController = ScrollController();
  final apiService = ApiService(
    url: "https://145e-45-84-122-3.ngrok-free.app",
  );

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
      Map result = await apiService.chatbotRespond(
        history: history,
        usedQuestionIdx: usedQuestionIdx,
      );
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
