import 'package:flutter/material.dart';

class AccountButton extends StatelessWidget {
  final Function close;
  const AccountButton({super.key, required this.close});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: (MediaQuery.of(context).size.height / 5) * 2,
      right: 12,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              blurRadius: 4,
              offset: Offset(0, 0),
              spreadRadius: 0,
              color: Color.fromRGBO(180, 196, 209, 1),
            ),
          ],
          borderRadius: BorderRadius.all(
            Radius.circular(1000),
          ),
        ),
        child: IconButton(
          onPressed: () {
            close();
          },
          icon: Icon(
            Icons.account_circle_rounded,
            size: 48,
            color: Colors.black,
          ),
          color: Color.fromRGBO(252, 254, 255, 1),
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(
              Color.fromRGBO(252, 254, 255, 1),
            ),
            padding: WidgetStateProperty.all(
              EdgeInsets.all(0),
            ),
          ),
        ),
      ),
    );
  }
}
