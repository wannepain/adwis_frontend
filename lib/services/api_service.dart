import 'package:dio/dio.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ApiService {
  final String url = "https://edf9-45-84-122-5.ngrok-free.app";

  ApiService();

  final dio = Dio();

  Future<Map> chatbotRespond(
      {required List history, required List usedQuestionIdx}) async {
    try {
      final response = await dio.post("$url/respond",
          data: {"history": history, "used_question_idx": usedQuestionIdx});

      return {
        "history": response.data['history'],
        "usedQuestionIdx": response.data['used_question_idx'],
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
      return response.data["career"];
    } catch (e) {
      print('Error: $e');
      return {"history": null, "usedQuestionIdx": null, "error": e};
    }
  }

  Future<Map> signUp({required user}) async {
    try {
      final email = user!.email;
      final uid = user.uid;
      final name = user.displayName as String;

      final result = await dio.post(
        "$url/api/sign",
        data: {
          "user": {
            "uid": uid,
            "name": name,
            "email": email,
          },
        },
      );
      return result.data;
    } catch (e) {
      return {"error": e, "success": false};
    }
  }
}
