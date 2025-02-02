import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:dio/dio.dart';

class CareerCard extends StatefulWidget {
  List history;

  CareerCard({super.key, required this.history});

  @override
  State<CareerCard> createState() => _CareerCardState();
}

class _CareerCardState extends State<CareerCard> {
  final dio = Dio();

  List data = [];

  String salary = "";

  String title = "";

  String description = "";

  Future<Map> postHttp() async {
    try {
      final response = await dio.post(
          "https://4615-45-84-122-21.ngrok-free.app/career",
          data: {"history": widget.history});
      return jsonDecode(response.data)["career"];
    } catch (e) {
      print('Error: $e');
      return {"history": null, "usedQuestionIdx": null, "error": e};
    }
  }

  void setData() async {
    final response = await postHttp();
    data.add(response);
    final startingSalary = response["Starting_Salary"];
    setState(() {
      salary = "$startingSalary";
      title = response["Career_Name"];
      description = response["Description"];
    });
  }

  @override
  void initState() {
    super.initState();
    setData();
  }

  @override
  Widget build(BuildContext context) {
    double c_width = MediaQuery.of(context).size.width * 0.6;
    return Row(
      children: [
        Container(
          width: c_width,
          padding: EdgeInsets.all(10),
          margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(9)),
            // border: Border.all(color: Colors.black, width: 2.0)
            boxShadow: [
              BoxShadow(
                color: Color.fromRGBO(143, 198, 238, 0.5),
                offset: Offset(0, 0),
                blurRadius: 10,
                spreadRadius: 0,
              ),
            ],
            image: DecorationImage(
              image: AssetImage("assets/images/degree_2.jpg"),
              colorFilter: ColorFilter.mode(
                Colors.black.withAlpha(100),
                BlendMode.srcATop,
              ),
              fit: BoxFit.cover, // Ensures the image covers the container
            ),
          ),
          child: IntrinsicHeight(
            child: Column(
              children: [
                SizedBox(
                  height: 200,
                ),
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        width: ((c_width - 20) / 3) * 2,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              title,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                color: Color.fromRGBO(252, 254, 255, 1),
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                                fontFamily: GoogleFonts.inter().fontFamily,
                              ),
                            ),
                            SizedBox(
                              height: 6,
                            ),
                            Text(
                              description,
                              textAlign: TextAlign.start,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w300,
                                color: Color.fromRGBO(252, 254, 255, 0.7),
                                fontFamily: GoogleFonts.inter().fontFamily,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        width: (c_width - 20) / 3,
                        alignment: Alignment.center,
                        child: Text(
                          "\$$salary",
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.w800,
                            color: Color.fromRGBO(252, 254, 255, 1),
                            fontFamily: GoogleFonts.inter().fontFamily,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
