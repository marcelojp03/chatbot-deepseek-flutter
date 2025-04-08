import 'package:dio/dio.dart';

class FlaskService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "http://192.168.42.216:5000",
      /*headers: {
        "Authorization": "Bearer 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",
        "Content-Type": "application/json",
      },*/
    ),
  );

  Future<String> getChatResponse(String userMessage) async {
    try {
      final response = await _dio.post(
        "/chat-transito",
        data: {
          "message": userMessage,
        }
      );

      if (response.statusCode == 200) {
        return response.data["response"];
      } else {
        return "Error: ${response.statusCode} - ${response.data}";
      }
    } on DioException catch (e) {
      return "Error: ${e.response?.statusCode ?? 'Unknown'} - ${e.message}";
    }
  }
}
