import 'package:flutter/material.dart';

class ChatBuble extends StatelessWidget {
  const ChatBuble({super.key, required this.text, required this.isMe});

  final String text;
  final bool isMe;

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width * 0.6;
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          constraints: BoxConstraints(
            maxWidth: c_width, // Limit max width
          ),
          padding: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(9)),
            color: isMe
                ? Color.fromRGBO(143, 198, 238, 1)
                : Color.fromRGBO(237, 243, 248, 1),
            boxShadow: [
              BoxShadow(
                color: isMe
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
              text,
              style: TextStyle(fontSize: 16),
              textAlign: isMe ? TextAlign.end : TextAlign.start,
            ),
          ),
        ),
      ],
    );
  }
}
