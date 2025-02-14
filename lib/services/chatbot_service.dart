import "package:dio/dio.dart";

class ChatbotService {
  final url = "https://adwisbackend-563539782861.us-central1.run.app";
  final dio = Dio();

  ChatbotService();

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
}
