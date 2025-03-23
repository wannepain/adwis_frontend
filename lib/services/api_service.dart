import "package:dio/dio.dart";

class ApiService {
  final dio = Dio();
  final url = "https://adwis-api.onrender.com";

  Future<Map?> checkSubscription(
      {required String uid, required String? token}) async {
    final response = await dio.post(
      "$url/subscription/check",
      data: {"uid": uid, "purchaseToken": token},
    );
    return response.data;
  }
}
