import 'package:dio/dio.dart';
import 'dart:convert';

class ApiService {
  final String url;

  ApiService({required this.url});

  final dio = Dio();

  Future<Map> chatbotRespond(
      {required List history, required List usedQuestionIdx}) async {
    try {
      final response = await dio.post("$url/respond",
          data: {"history": history, "used_question_idx": usedQuestionIdx});

      return {
        "history": jsonDecode(response.data)['history'],
        "usedQuestionIdx": jsonDecode(response.data)['used_question_idx'],
        "error": false,
      };
    } catch (e) {
      print('Error: $e');
      return {"history": null, "usedQuestionIdx": null, "error": e};
    }
  }

  Future<Map> getCareer({required history}) async {
    try {
      final response =
          await dio.post("$url/career", data: {"history": history});
      return jsonDecode(response.data)["career"];
    } catch (e) {
      print('Error: $e');
      return {"history": null, "usedQuestionIdx": null, "error": e};
    }
  }

  Future<Map> signUp({required user}) async {
    try {
      final result = await dio.post(
        "$url/api/sign",
        data: {"user": user},
      );
      return jsonDecode(result.data);
    } catch (e) {
      return {"error": e, "success": false};
    }
  }
}
