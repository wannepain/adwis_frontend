import "package:dio/dio.dart";

class ChatbotService {
  final url = "https://adwisbackend-563539782861.us-central1.run.app";
  //final url = "https://3734-45-84-122-8.ngrok-free.app";
  final dio = Dio();

  ChatbotService();

  Future<Map> chatbotRespond({required List history}) async {
    try {
      final response =
          await dio.post("$url/respond/unlimited", data: {"history": history});

      return {
        "history": response.data['history'],
        "error": false,
      };
    } catch (e) {
      print('Error: $e');
      return {"history": null, "error": e};
    }
  }

  Future<Map> getCareer({required history}) async {
    try {
      final response =
          await dio.post("$url/career/unlimited", data: {"history": history});
      return response.data["career"];
    } catch (e) {
      print('Error: $e');
      return {"history": null, "error": e};
    }
  }

  Future<String?> getCompliment({required history}) async {
    try {
      final response = await dio.post(
        "$url/compliment",
        data: {
          "history": history,
        },
      );
      return response.data["compliment"];
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}
