import 'package:dio/dio.dart';

class ApiService {
  final String url = "https://adwis-api.onrender.com";

  ApiService();

  final dio = Dio();

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

  Future<String> createPaymentIntent(String uid) async {
    final response = await dio.post(
      '$url/api/create-subscription',
      data: {'uid': uid},
    );
    final responseData = response.data;
    return responseData["clientSecret"];
  }
}
