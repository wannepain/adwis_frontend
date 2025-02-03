import 'package:flutter/material.dart';

class ChatBuble extends StatefulWidget {
  const ChatBuble({super.key, required this.text, required this.isMe});

  final String text;
  final bool isMe;

  @override
  State<ChatBuble> createState() => _ChatBubleState();
}

class _ChatBubleState extends State<ChatBuble> {
  double opacityLevel = 0.0;
  Offset slideOffsetBot = Offset(-0.3, 0);
  Offset slideOffsetUser = Offset(0.3, 0);

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 200), () {
      setState(() {
        opacityLevel = 1.0;
        slideOffsetBot = Offset(0, 0); // Moves to original position
        slideOffsetUser = Offset(0, 0);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width * 0.6;
    return Row(
      mainAxisAlignment:
          widget.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        AnimatedSlide(
          offset: widget.isMe ? slideOffsetUser : slideOffsetBot,
          duration: Duration(milliseconds: 200),
          curve: Curves.easeInOutSine,
          child: AnimatedOpacity(
            duration: Duration(milliseconds: 200),
            opacity: opacityLevel,
            curve: Curves.easeIn,
            child: Container(
              constraints: BoxConstraints(
                maxWidth: c_width, // Limit max width
              ),
              padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(9)),
                color: widget.isMe
                    ? Color.fromRGBO(143, 198, 238, 1)
                    : Color.fromRGBO(237, 243, 248, 1),
                boxShadow: [
                  BoxShadow(
                    color: widget.isMe
                        ? Color.fromRGBO(143, 198, 238, 0.5)
                        : Color.fromRGBO(237, 243, 248, 0.5),
                    spreadRadius: 0,
                    blurRadius: 4,
                    offset: Offset(0, 0),
                  ),
                ],
              ),
              child: IntrinsicWidth(
                child: Text(
                  widget.text,
                  style: TextStyle(fontSize: 16),
                  textAlign: widget.isMe ? TextAlign.end : TextAlign.start,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
