import "package:dio/dio.dart";

class ChatbotService {
  // final url = "https://adwisbackend-563539782861.us-central1.run.app";
  final url = "https://c189-45-84-122-40.ngrok-free.app";
  final dio = Dio();

  ChatbotService();

  Future<Map> chatbotRespond({required List history}) async {
    print("using chatbot unlimited");
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

  Future<Map> chatbotRespondLimited({required List history}) async {
    print("using chatbot limited");
    try {
      final response =
          await dio.post("$url/respond/limited", data: {"history": history});

      return {
        "history": response.data['history'],
        "error": false,
      };
    } catch (e) {
      print('Error: $e');
      return {"history": null, "error": e};
    }
  }

  Future<Map> chatbotRespondStage2({required List history}) async {
    print("using chatbot stage 2");
    try {
      final response =
          await dio.post("$url/respond/stage/2", data: {"history": history});

      return {
        "history": response.data['history'],
        "error": false,
      };
    } catch (e) {
      print('Error: $e');
      return {"history": null, "error": e};
    }
  }

  Future<Map> chatbotRespondStage3(
      {required List blankHistory, required String userCareerPrecise}) async {
    print("using chatbot stage 3");
    try {
      final response = await dio.post("$url/respond/stage/3",
          data: {"history": blankHistory, "mentee_purpose": userCareerPrecise});

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
