import 'package:flutter/material.dart';

class CareerCard extends StatelessWidget {
  final title;
  final description;
  final salary;

  const CareerCard(
      {super.key,
      required this.title,
      required this.description,
      required this.salary});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: Row(
        children: [
          Column(
            children: [Text(title), Text(description)],
          ),
          Center(
            child: Text(salary),
          )
        ],
      ),
    );
  }
}
