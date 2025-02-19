import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:adwis_frontend/providers/unlimited_provider.dart';

class Alert extends ConsumerStatefulWidget {
  final String type;
  final Function function;
  const Alert({super.key, required this.type, required this.function});

  @override
  _AlertState createState() => _AlertState();
}

class _AlertState extends ConsumerState<Alert> {
  String? resetAt;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      setState(() {
        resetAt = restartsLogic();
      });
    });
  }

  String restartsLogic() {
    final data = ref.read(unlimitedProvider);
    var hours;
    var minutes;
    if (!data["reset"] && data["resetTime"] != 0) {
      final reset = DateTime.now().millisecondsSinceEpoch >= data["resetTime"];
      if (reset) {
        hours = "";
        minutes = "";
        widget.function(); //call resetting function
      } else {
        final date = DateTime.fromMillisecondsSinceEpoch(data["resetTime"]);
        minutes = date.minute.toString().padLeft(2, '0');
        hours = date.hour.toString().padLeft(2, '0');
      }
    } else {
      final date = DateTime.now().add(
        Duration(minutes: 15),
      );
      final dateInUnix = date.millisecondsSinceEpoch;
      minutes = date.minute.toString().padLeft(2, '0');
      hours = date.hour.toString().padLeft(2, '0');
      ref.read(unlimitedProvider.notifier).storeTime(dateInUnix);
    }
    return "$hours:$minutes";
  }

  @override
  Widget build(BuildContext context) {
    Widget? icon;
    String? text1;
    String? text2;
    String? text3;
    String? link;
    Widget? button;

    // Set values based on the type
    switch (widget.type) {
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
        text1 = "You have used all free restarts";
        text2 = "Reset at ${resetAt ?? ""}";
        text3 = "Upgrade to unlimited for unlimited restarts";
        button = IntrinsicHeight(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacementNamed(context, "/unlimited");
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    Color.fromRGBO(51, 101, 138, 1),
                  ),
                ),
                child: Text(
                  "Upgrade".toUpperCase(),
                  style: TextStyle(
                    color: Color.fromRGBO(252, 254, 255, 1),
                    fontFamily: GoogleFonts.acme().fontFamily,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
        );
        break;
      default:
        break;
    }

    return Column(
      children: [
        Container(
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
              if (text1 != null)
                Text(
                  text1,
                  style: TextStyle(fontSize: 18),
                ),
              if (text2 != null)
                Text(
                  text2,
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: GoogleFonts.inter().fontFamily,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              if (text3 != null)
                Text(
                  text3,
                  style: TextStyle(fontSize: 18),
                ),
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
        ),
      ],
    );
  }
}
