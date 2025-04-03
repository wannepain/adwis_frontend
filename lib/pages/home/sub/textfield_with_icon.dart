import 'package:adwis_frontend/utils/functions/hex_to_rgba.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TextFieldWithIcon extends StatelessWidget {
  final bool isDisabled;
  TextFieldWithIcon({
    super.key,
    required this.returnText,
    required this.isDisabled,
    required this.onTap,
  });

  String _text = '';
  Function onTap;

  final textField = TextEditingController();

  final Function returnText;

  void clearText() {
    textField.clear();
  }

  @override
  Widget build(BuildContext context) {
    // final TextEditingController _controller = TextEditingController();

    return Row(
      children: [
        Expanded(
          child: TextField(
            enabled: !isDisabled,
            cursorColor: isDisabled
                ? HexToRgba().convert("33658A", 0.50)
                : HexToRgba().convert("33658A", 1),
            //controller: _controller,
            onTap: () {
              onTap();
            },

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
            controller: textField,
            autocorrect: true,
          ),
        ),
        IconButton(
          icon: Icon(
            Icons.send,
            color: isDisabled
                ? HexToRgba().convert("080705", 0.50)
                : HexToRgba().convert("080705", 1),
            size: 32,
          ),
          onPressed: () {
            if (isDisabled) {
              return;
            }
            returnText(_text);
            clearText();
          },
        ),
      ],
    );
  }
}
