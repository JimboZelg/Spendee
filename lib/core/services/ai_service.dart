import 'dart:convert';
import 'package:http/http.dart' as http;

class AIService {
  final String apiKey = 'TU_API_KEY_DE_OPENAI';

  // Obtener consejos financieros de la IA
  Future<String> getFinancialAdvice(String userMessage) async {
    final response = await http.post(
      Uri.parse('https://api.openai.com/v1/chat/completions'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $apiKey',
      },
      body: jsonEncode({
        'model': 'gpt-4', // O el modelo que prefieras
        'messages': [
          {'role': 'system', 'content': 'Eres un asistente financiero.'},
          {'role': 'user', 'content': userMessage},
        ],
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['choices'][0]['message']['content'];
    } else {
      throw Exception('Error al obtener respuesta de la IA');
    }
  }
}