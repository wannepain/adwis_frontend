import 'package:flutter/material.dart';
import 'package:adwis_frontend/utils/text_with_icon.dart';

class ActionButton extends StatelessWidget {
  ///Creates a button with a text and Adwis icon on the right side
  ///Args:
  ///- text: The text to display on the button
  ///- onPressed: The function to call when the button is pressed
  final String text;
  final Function() onPressed;

  const ActionButton({super.key, required this.text, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(left: 20, right: 20, bottom: 12),
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: Color.fromARGB(50, 143, 198, 238),
            offset: Offset(0, 0),
            blurRadius: 2,
          ),
        ],
      ),
      child: ElevatedButton(
        onPressed: () {
          onPressed();
        },
        style: ButtonStyle(
            backgroundColor:
                WidgetStateProperty.all(Color.fromARGB(255, 237, 243, 248)),
            foregroundColor:
                WidgetStateProperty.all(Color.fromARGB(8, 7, 5, 1)),
            shape: WidgetStateProperty.all(RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(9),
            )),
            padding: WidgetStateProperty.all(EdgeInsets.all(12))),
        child: TextWithIcon(text: text),
      ),
    );
  }
}
