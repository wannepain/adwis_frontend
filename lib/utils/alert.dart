import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class Alert extends StatelessWidget {
  final String type;
  const Alert({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    Widget? icon;
    String? text1;
    String? text2;
    String? text3;
    String? link;
    Widget? button;

    // Set values based on the type
    switch (type) {
      case 'development':
        icon = SvgPicture.asset("assets/icons/logo_text.svg");
        text1 = "This feature";
        text2 = "is in development";
        text3 = "If you encounter errors,";
        link = "contact us";
        button = ElevatedButton(onPressed: () {}, child: Text("Continue"));
        break;
      case 'restarts':
        icon = SvgPicture.asset("assets/icons/logo_text.svg");
        text1 = "Restar reset at:";
        text2 = "10:15";
        text3 = "or upgrade to unlimited";
        button = ElevatedButton(
          onPressed: () {},
          style: ButtonStyle(),
          child: Text("Upgrade"),
        );
        break;
      default:
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 18, vertical: 12),
      decoration: BoxDecoration(
        color: Color.fromRGBO(239, 246, 251, 1),
        borderRadius: BorderRadius.all(
          Radius.circular(9),
        ),
        boxShadow: [
          BoxShadow(
            offset: Offset.zero,
            spreadRadius: 0,
            blurRadius: 4,
            color: Color.fromRGBO(8, 7, 5, 0.25),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if (icon != null) icon,
          SizedBox(
            height: 12,
          ),
          if (text1 != null) Text(text1, style: TextStyle(fontSize: 18)),
          if (text2 != null) Text(text2, style: TextStyle(fontSize: 18)),
          if (text3 != null) Text(text3, style: TextStyle(fontSize: 18)),
          if (link != null)
            TextButton(
              onPressed: () {
                // Handle link click
              },
              child: Text(link!, style: TextStyle(color: Colors.blue)),
            ),
          if (button != null) button!,
        ],
      ),
    );
  }
}
