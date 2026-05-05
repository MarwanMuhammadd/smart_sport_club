import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class ChatbotApiService {
  static const String baseUrl = 'https://omarhamdon-chatbot.hf.space';
  static const String endpoint = '/chat';

  Future<String?> sendMessage(String question) async {
    try {
      final url = Uri.parse('$baseUrl$endpoint');
      final requestBody = jsonEncode({"question": question});

      print('===== NEW API REQUEST =====');
      print('URL: $url');
      print('BODY: $requestBody');
      print('===========================');

      final response = await http
          .post(
            url,
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: requestBody,
          )
          .timeout(const Duration(seconds: 15));

      print('===== NEW API RESPONSE =====');
      print('STATUS: ${response.statusCode}');
      print('BODY: ${response.body}');
      print('============================');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data['answer'] as String?;
      } else {
        print('New API Error ${response.statusCode}');
        return "Sorry, I couldn't respond right now. (${response.statusCode})";
      }
    } on TimeoutException {
      print('===== TIMEOUT =====');
      return "Request timed out. Please check your connection.";
    } catch (e) {
      print('===== EXCEPTION: $e =====');
      return "Connection error. Please check your internet.";
    }
  }
}
