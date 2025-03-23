import "package:dio/dio.dart";

class ApiService {
  final dio = Dio();
  final url = "https://b17d-45-84-122-4.ngrok-free.app";

  Future<Map?> checkSubscription(
      {required String uid, required String? token}) async {
    final response = await dio.post(
      "$url/subscription/check/new",
      data: {"uid": uid, "purchaseToken": token},
    );
    return response.data;
  }
}
