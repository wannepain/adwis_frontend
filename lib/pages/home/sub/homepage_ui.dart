import 'package:flutter/material.dart';
import 'package:adwis_frontend/pages/home/sub/chat_buble.dart';
import 'package:adwis_frontend/utils/loader_center.dart';
import 'package:adwis_frontend/pages/home/sub/career/career_card.dart';
import 'package:adwis_frontend/pages/home/sub/career/restart_conv_button.dart';
import 'package:adwis_frontend/pages/home/sub/text_input.dart';
import 'package:adwis_frontend/pages/home/sub/overlay_logo.dart';

class HomepageUi extends StatelessWidget {
  final ScrollController scrollController;
  final List history;
  final Function restartConversation;
  final Function returnText;
  final int numOfRestarts;
  HomepageUi({
    super.key,
    required this.scrollController,
    required this.history,
    required this.restartConversation,
    required this.returnText,
    required this.numOfRestarts,
  });

  @override
  Widget build(BuildContext context) {
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
                ? RestartConvButton(
                    restart: restartConversation,
                    numOfRestarts: numOfRestarts,
                  )
                : TextInput(returnText: returnText),
            OverlayLogo(),
          ],
        ),
      ),
    );
  }
}
