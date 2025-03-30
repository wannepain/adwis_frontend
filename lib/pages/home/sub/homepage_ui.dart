import 'package:adwis_frontend/pages/home/walktrough_home/walktrough_home.dart';
import 'package:adwis_frontend/providers/history_providers.dart';
// import 'package:adwis_frontend/pages/speech/utils/open_speech_button.dart';
import 'package:adwis_frontend/providers/utils/walktrough_provider.dart';
import 'package:flutter/material.dart';
import 'package:adwis_frontend/pages/home/sub/chat_buble.dart';
import 'package:adwis_frontend/utils/loader_center.dart';
import 'package:adwis_frontend/pages/home/sub/career/career_card.dart';
import 'package:adwis_frontend/pages/home/sub/career/restart_conv_button.dart';
import 'package:adwis_frontend/pages/home/sub/text_input.dart';
import 'package:adwis_frontend/pages/home/sub/overlay_logo.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class HomepageUi extends ConsumerWidget {
  final ScrollController scrollController;
  final List history;
  final Function restartConversation;
  final int numOfRestarts;
  final Function onCareerDecline;
  final Function onCareerAccept;
  final Function returnText;
  HomepageUi({
    super.key,
    required this.scrollController,
    required this.history,
    required this.restartConversation,
    required this.numOfRestarts,
    required this.onCareerDecline,
    required this.onCareerAccept,
    required this.returnText,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final increment = ref.watch(walkthroughProvider);
    if (history.isEmpty) {
      return Scaffold(
        backgroundColor: Color.fromRGBO(252, 254, 255, 1),
        body: Center(
          child: LoaderCenter(),
        ),
      );
    }
    return Scaffold(
      backgroundColor: Color.fromRGBO(252, 254, 255, 1),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 18),
        child: Column(
          children: [
            Flexible(
              child: ListView.builder(
                controller: scrollController,
                padding: EdgeInsets.symmetric(vertical: 18.0),
                itemCount: history.isNotEmpty && history.last["end"] == true
                    ? history.length + 1 // Extra item for CareerCard
                    : history.length,
                itemBuilder: (context, index) {
                  // If this is the last item and history.last["end"] == true, show CareerCard
                  if (history[index]["show_career"] != null &&
                      history[index]["show_career"] == true) {
                    final newHistory = history.sublist(0, history.length);
                    newHistory.removeAt(index);
                    return CareerCard(
                      history: newHistory,
                      onCareerAccept: onCareerAccept,
                      onCareerDecline: onCareerDecline,
                      declined: history[index]["declined"],
                      saveCareerResult: (career_result) {
                        ref.read(historyProvider.notifier).addToFile(
                              career_result,
                            );
                      },
                    );
                  }
                  // if (history[index]["declined"] != null &&
                  //     history[index]["declined"] == true) {
                  //   // career declined message
                  //   return ChatBuble(
                  //     text: "Career declined",
                  //     isMe: true,
                  //     isFirst: index == 0,
                  //   );
                  // }
                  // Normal chat bubbles
                  var bot = history[index]['bot'] == null
                      ? ""
                      : history[index]['bot']['Question_Text'];
                  var client = history[index]['client'] == null
                      ? ""
                      : history[index]['client'];

                  List<Widget> toReturn = [];

                  if (bot.isNotEmpty) {
                    print(index == 0);
                    toReturn.add(ChatBuble(
                      text: bot,
                      isMe: false,
                      isFirst: index == 0,
                    ));
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
            IntrinsicHeight(
              child: Column(
                children: [
                  if (increment == 0)
                    WalkthroughHome(
                      text: "Here you can chat with adwis",
                      orientation: "bottom",
                      totalIncrements: 2,
                    ),
                  TextInput(
                    isDisabled: history.isNotEmpty &&
                        history.last["end"] != null &&
                        history.last["end"] == true,
                    returnText: returnText,
                  ),
                  SizedBox(width: 6.0),
                ],
              ),
            ),
            OverlayLogo(),
          ],
        ),
      ),
    );
  }
}
