import 'package:adwis_frontend/pages/home/walktrough_home/walktrough_home.dart';
import 'package:adwis_frontend/providers/history_managment_provider.dart';
import 'package:adwis_frontend/providers/stages_provider.dart';
import 'package:adwis_frontend/providers/user_provider.dart';
import 'package:adwis_frontend/providers/utils/walktrough_provider.dart';
import 'package:adwis_frontend/services/dopamine_service.dart';
import 'package:adwis_frontend/utils/go_unlimited_snack_bar/snack_bar_provider.dart';
import 'package:flutter/material.dart';
import 'package:adwis_frontend/pages/home/sub/homepage_ui.dart';
import 'package:adwis_frontend/services/chatbot_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:adwis_frontend/utils/alert.dart';
import 'package:adwis_frontend/providers/restart_provider.dart';
import 'package:adwis_frontend/providers/history_providers.dart';
import 'package:adwis_frontend/pages/user/user_buton.dart';

class Homepage extends ConsumerStatefulWidget {
  bool forceOpenAuth;
  final int stage;
  Homepage({super.key, this.forceOpenAuth = false, required this.stage});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends ConsumerState<Homepage> {
  final ScrollController _scrollController = ScrollController();
  bool showRestartBtn = false;

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  void returnText(String text) async {
    final history = ref.watch(historyManagmentProvider)["show_history"];
    history[history.length - 1]['client'] = text;
    ref
        .watch(historyManagmentProvider.notifier)
        .updateHistory(show_history: history);
    bool showingSnackBar = ref.read(restartProvider)["showing_snackbar"];
    if (!showingSnackBar) {
      DopamineService().showCompliment(history: history);
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollToBottom();
    });

    setData();
  }

  void initAsyncLogic() async {
    ref.read(historyProvider.notifier).readHistory();
    //ref.read(historyProvider.notifier).clean();
  }

  void restartConversation() {
    // final numOfRestarts = ref.read(restartProvider)["restarts"];
    // if (numOfRestarts! < 2) {
    //   setState(() {
    //     showRestartBtn = false;
    //   });
    //   final controler = ref.read(
    //       snackBarControllerProvider); // Get the current SnackBarController
    //   controler?.dismiss(); //close unlimited snackbar if open
    //   ref.read(snackBarControllerProvider.notifier).state =
    //       null; //reset the controller
    //   ref.read(historyManagmentProvider.notifier).clean();
    //   ref.read(restartProvider.notifier).increment_restarts();
    //   setData();
    // }
    // final currentStage = ref.read(stagesProvider)["current_stage"];
    // final isUnlimited = ref.read(userProvider)["isUnlimited"];
    setState(() {
      showRestartBtn = false;
    });
    final controler = ref
        .read(snackBarControllerProvider); // Get the current SnackBarController
    controler?.dismiss(); //close unlimited snackbar if open
    Navigator.pushNamedAndRemoveUntil(
      context,
      "/congratulations",
      (route) => false,
    );
    // ref.read(snackBarControllerProvider.notifier).state =
    //     null; //reset the controller
    // ref.read(historyManagmentProvider.notifier).clean();
    // ref.read(restartProvider.notifier).increment_restarts();
    // setData();
  }

  void setData() async {
    final List<dynamic> sendHistory =
        ref.read(historyManagmentProvider)["send_history"];
    final bool? isUnlimited = ref.read(userProvider)["isUnlimited"];
    final int stage = ref.read(stagesProvider)["current_stage"];
    late Map result;
    if (isUnlimited == true) {
      switch (stage) {
        case 1:
          result = await ChatbotService().chatbotRespond(
            //change based on stage
            history: sendHistory,
          );
          break;
        case 2:
          result = await ChatbotService().chatbotRespondStage2(
            history: sendHistory,
          );
          break;
        case 3:
          result = await ChatbotService().chatbotRespondStage3(
            history: sendHistory,
          );
          break;
        default:
      }
    } else {
      result = await ChatbotService().chatbotRespondLimited(
        history: sendHistory,
      );
    }

    ref.read(historyManagmentProvider.notifier).updateHistory(
          show_history: result["history"] ?? [],
        );
    final history = ref.read(historyManagmentProvider)["show_history"];
    final String? lastBotMessage =
        history.isNotEmpty ? history.last['bot']["Question_Text"] : null;
    if (history.length > 2 &&
        lastBotMessage != null &&
        lastBotMessage
            .contains("I have enough information to suggest a career")) {
      ref.read(historyManagmentProvider.notifier).addToHistory(
        content: {
          "show_career": true,
          "decline": null,
        },
      );
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollToBottom();
    });
  }

  void resetFunction() {
    ref.read(restartProvider.notifier).reset_restarts();
  }

  void onCareerAccept(career_result) async {
    print("career accepted");
    print("career_result $career_result");

    await ref.read(historyProvider.notifier).addToFile(career_result);

    // Read back the file to ensure it's properly stored
    await ref.read(historyProvider.notifier).readHistory();
    print("career history ${ref.read(historyProvider)["data"]}");

    // Now restart conversation
    setState(() {
      showRestartBtn = true;
    });
  }

  void onCareerDecline() async {
    // Step 1: Read the current history
    final List<dynamic> sendHistory =
        List.from(ref.read(historyManagmentProvider)['send_history']);

    // Step 2: Add the "decline" message
    sendHistory.add({
      "bot": {
        "Question_Text": "I have enough information to suggest a career",
      },
      "client":
          "I decline this career suggestion, please continue the conversation"
    });

    // Step 3: Get chatbot's response
    Map result = await ChatbotService().chatbotRespond(history: sendHistory);
    final List<dynamic> resultHistory = result["history"] ?? [];

    if (resultHistory.isNotEmpty) {
      // Step 4: Remove unwanted messages
      resultHistory.removeWhere((record) =>
          record["bot"]["Question_Text"]
              .contains("I have enough information to suggest a career") ||
          record["bot"]["Question_Text"] ==
              "I decline this career suggestion, please continue the conversation");

      // Step 5: Update `sendHistory`
      final result = ref
          .read(historyManagmentProvider.notifier)
          .updateSendHistory(send_history: resultHistory);
      final showHistory = result["show_history"];

      // Step 6: Find the latest career suggestion and mark it as declined
      final showCareerIndex = showHistory.indexWhere(
        (element) =>
            element["show_career"] == true && element["declined"] == null,
      );
      print("showCareerIndex $showCareerIndex");

      if (showCareerIndex != -1) {
        showHistory[showCareerIndex]["declined"] = true;
      }

      // Step 7: Append chatbot's latest message **AFTER the career suggestion**
      if (resultHistory.isNotEmpty) {
        final lastMessage = resultHistory.removeLast();
        showHistory.add(lastMessage);
      }

      // Step 8: Update the provider with the final `showHistory`
      ref.read(historyManagmentProvider.notifier).updateHistory(
            show_history: showHistory,
          );
    }
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollToBottom();
    });
    print("career declined");
    ref.read(restartProvider.notifier).increment_career_declines();
  }

  @override
  void initState() {
    setData();
    super.initState();
    initAsyncLogic();
  }

  @override
  Widget build(BuildContext context) {
    final numOfRestarts = ref.watch(restartProvider)['restarts'];
    final currentTutorialStep = ref.watch(walkthroughProvider);
    final history = ref.watch(historyManagmentProvider);

    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(6),
        child: Stack(
          children: [
            Positioned.fill(
              child: HomepageUi(
                scrollController: _scrollController,
                history: history["show_history"],
                restartConversation: restartConversation,
                numOfRestarts: numOfRestarts!,
                onCareerAccept: onCareerAccept,
                onCareerDecline: onCareerDecline,
                returnText: returnText,
                showRestartBtn: showRestartBtn,
              ),
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
            Positioned(
              right: 12,
              top: (MediaQuery.of(context).size.height / 5) * 2,
              child: Row(
                children: [
                  if (currentTutorialStep == 1)
                    WalkthroughHome(
                      text: "Here you can manage your account",
                      orientation: "right",
                      totalIncrements: 2,
                    ),
                  UserButton(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
