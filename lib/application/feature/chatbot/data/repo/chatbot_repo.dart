import 'dart:async';
import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:smart_sport_club/application/feature/chatbot/data/models/chatbot_request_params.dart';
import 'package:smart_sport_club/application/feature/chatbot/data/models/chatbot_response.dart';

class ChatbotRepo {
  static const String baseUrl = 'https://omarhamdon-fitcoachchat.hf.space';
  static const String endpoint = '/chat';

  Future<({ChatbotResponse? response, String? error})> sendMessage(
    ChatbotRequestParams params,
  ) async {
    try {
      log("ChatBot Request: ${params.question}");

      final url = Uri.parse('$baseUrl$endpoint');
      final request = await http
          .post(
            url,
            headers: {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode(params.toJson()),
          )
          .timeout(const Duration(seconds: 30));

      if (request.statusCode >= 200 && request.statusCode < 300) {
        final decoded = jsonDecode(request.body);
        if (decoded is! Map<String, dynamic>) {
          return (response: null, error: "Invalid chatbot response");
        }

        final response = ChatbotResponse.fromJson(decoded);
        log("ChatBot Response Received");
        log("Exercises Count: ${response.exercisesList.length}");
        log("Matched Images: ${response.imageAccuracy.matched}");

        return (response: response, error: null);
      }

      return (
        response: null,
        error: "Sorry, I couldn't respond right now. (${request.statusCode})",
      );
    } on TimeoutException {
      return (response: null, error: "Request timed out. Please try again.");
    } catch (e) {
      log("ChatBot Error: $e");
      return (
        response: null,
        error: "Connection error. Please check your internet.",
      );
    }
  }
}
