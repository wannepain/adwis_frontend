import 'package:flutter/material.dart';
import 'package:adwis_frontend/pages/home/sub/homepage_ui.dart';
import 'package:adwis_frontend/pages/auth/auth_card_overlay.dart';
import 'package:adwis_frontend/services/chatbot_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:adwis_frontend/utils/alert.dart';
import 'package:adwis_frontend/providers/auth_providers.dart';
import 'package:adwis_frontend/providers/popup_providers.dart';
import 'package:adwis_frontend/providers/restart_provider.dart';
import 'package:adwis_frontend/providers/history_providers.dart';

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
    ref.read(historyProvider.notifier).readHistory();
    //ref.read(historyProvider.notifier).clean();
    final bool openOpUp = ref.read(popupProvider);
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
    final numOfRestarts = ref.read(restartProvider);
    ref
        .read(historyProvider.notifier)
        .addToFile(history.sublist(0, history.length - 1));
    if (numOfRestarts < 5) {
      setState(() {
        history = [];
        usedQuestionIdx = [];
      });
      ref.read(restartProvider.notifier).increment();
      setData();
    }
  }

  void setData() async {
    if (history.length > 15) {
      history.add({"end": true});
    } else {
      Map result = await ChatbotService().chatbotRespond(
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

  void resetFunction() {
    ref.read(restartProvider.notifier).reset();
  }

  @override
  void initState() {
    setData();
    super.initState();
    initAsyncLogic();
  }

  @override
  Widget build(BuildContext context) {
    final numOfRestarts = ref.watch(restartProvider);
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
            if (numOfRestarts >= 5)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Center(
                  child: Alert(
                    type: "restarts",
                    function: () {
                      resetFunction();
                    },
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
