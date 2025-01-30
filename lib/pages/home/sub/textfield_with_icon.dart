import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldWithIcon extends StatelessWidget {
  TextFieldWithIcon({super.key, required this.returnText});

  String _text = '';

  final Function returnText;

  @override
  Widget build(BuildContext context) {
    // final TextEditingController _controller = TextEditingController();

    return Row(
      children: [
        Expanded(
          child: TextField(
            //controller: _controller,
            onChanged: (value) {
              _text = value;
            },
            style: TextStyle(
                fontSize: 16,
                fontFamily: GoogleFonts.inter().fontFamily,
                color: Color.fromRGBO(8, 7, 5, 1)),
            decoration: InputDecoration(
              border: InputBorder.none,
            ),
            maxLines: null,
            keyboardType: TextInputType.multiline,
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.send,
            color: Color.fromRGBO(8, 7, 5, 1),
            size: 32,
          ),
          onPressed: () {
            returnText(_text);
          },
        ),
      ],
    );
  }
}
