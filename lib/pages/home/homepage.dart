//import 'package:adwis_frontend/pages/home/sub/chat_buble.dart';
import 'package:adwis_frontend/pages/home/sub/text_input.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  _HomepageState createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  final dio = Dio();

  void getHttp() async {
    try {
      final response = await dio.post('http://10.0.5.80:5000/response', data: {
        'history': [],
      });
      print(response);
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
          onPressed: getHttp, child: Text("test the connection")),
    );
  }
}
