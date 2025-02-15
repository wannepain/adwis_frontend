import 'package:flutter/material.dart';
import 'package:adwis_frontend/pages/home/sub/homepage_ui.dart';
import 'package:adwis_frontend/pages/auth/auth_card_overlay.dart';
import 'package:adwis_frontend/services/chatbot_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:adwis_frontend/utils/alert.dart';
import 'package:adwis_frontend/providers/auth_providers.dart';
import 'package:adwis_frontend/providers/popup_providers.dart';

class Homepage extends ConsumerStatefulWidget {
  bool forceOpenAuth;
  Homepage({super.key, this.forceOpenAuth = false});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<Homepage> {
  //final dio = Dio();
  final ScrollController _scrollController = ScrollController();
  List history = [];
  List usedQuestionIdx = [];
  int numOfRestarts = 1;
  bool showPopUp = false;

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

  void initAsyncLogic() async {
    final bool openOpUp = ref.read(popupProvider);
    print(openOpUp);
    final Map data = ref.read(authProvider);
    if (openOpUp && !data["isUnlimited"] && mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) {
          Navigator.pushReplacementNamed(context, "/unlimited");
        }
      });
    }
  }

  void restartConversation() {
    if (numOfRestarts < 5) {
      setState(() {
        history = [];
        usedQuestionIdx = [];
        numOfRestarts += 1;
      });
      setData();
    }
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
    initAsyncLogic();
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
                returnText: returnText,
                numOfRestarts: numOfRestarts,
              ),
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
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: numOfRestarts > 5
                  ? Center(
                      child: Alert(
                        type: "restarts",
                      ),
                    )
                  : SizedBox(),
            ),
          ],
        ),
      ),
    );
  }
}
