import 'package:flutter/material.dart';
import 'package:adwis_frontend/pages/home/sub/textfield_with_icon.dart';

class TextInput extends StatelessWidget {
  const TextInput({super.key, required this.returnText});

  final Function returnText;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 18),
        decoration: BoxDecoration(
          border: Border.all(
            color: Color.fromRGBO(51, 101, 138, 1),
            width: 1,
          ),
          color: Color.fromRGBO(237, 243, 248, 1),
          borderRadius: BorderRadius.circular(9),
          boxShadow: [
            BoxShadow(
              color: Color.fromRGBO(51, 101, 138, 1),
              spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(0, 0),
            ),
          ],
        ),
        child: TextFieldWithIcon(
          returnText: returnText,
        ),
      ),
    );
  }
}
