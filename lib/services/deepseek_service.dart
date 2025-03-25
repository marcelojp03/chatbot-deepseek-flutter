import 'package:dio/dio.dart';

class DeepSeekService {
  final Dio _dio = Dio(
    BaseOptions(
      baseUrl: "https://openrouter.ai/api/v1",
      headers: {
        "Authorization": "Bearer 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",
        "Content-Type": "application/json",
      },
    ),
  );

  Future<String> getChatResponse(String userMessage) async {
    try {
      final response = await _dio.post(
        "/chat/completions",
        data: {
          "model": "deepseek/deepseek-r1:free",
          "messages": [
            {
              "role": "system",
              "content": """
                        Eres un asisteente especializado en procesar y responder preguntas en español. Tu tarea es:
                          1. Analizar el contexto proporcionado en español
                          2. Entender la pregunta en español
                          3. Generar una respuesta clara y concisa en español
                        """
            },
            {
              "role": "user", 
              "content": userMessage
            }
          ]
        },
      );

      if (response.statusCode == 200) {
        return response.data["choices"][0]["message"]["content"];
      } else {
        return "Error: ${response.statusCode} - ${response.data}";
      }
    } on DioException catch (e) {
      return "Error: ${e.response?.statusCode ?? 'Unknown'} - ${e.message}";
    }
  }
}
