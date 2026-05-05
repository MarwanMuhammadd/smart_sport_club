import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:smart_sport_club/application/feature/chatbot/data/app_data.dart';

class GeminiChatbotService {
  static const String _geminiApiKey = "AIzaSyCsEcnzqXoLyfsLz0yrTghr8BFFQayX9Xg";
  static const String _geminiUrl =
      'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=$_geminiApiKey';

  final List<Map<String, dynamic>> _conversationHistory = [];

  Future<String?> sendMessage(String text) async {
    final String messageToSend = _conversationHistory.isEmpty
        ? buildPrompt(text)
        : text;

    _conversationHistory.add({
      "role": "user",
      "parts": [
        {"text": messageToSend},
      ],
    });

    try {
      final requestBody = jsonEncode({
        "contents": _conversationHistory,
        "generationConfig": {"temperature": 0.7, "maxOutputTokens": 300},
      });

      print('===== GEMINI REQUEST =====');
      print('URL: $_geminiUrl');
      print('BODY: $requestBody');
      print('==========================');

      final response = await http
          .post(
            Uri.parse(_geminiUrl),
            headers: {'Content-Type': 'application/json'},
            body: requestBody,
          )
          .timeout(const Duration(seconds: 15));

      print('===== GEMINI RESPONSE =====');
      print('STATUS: ${response.statusCode}');
      print('BODY: ${response.body}');
      print('===========================');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final botReply =
            data['candidates'][0]['content']['parts'][0]['text'] as String;

        _conversationHistory.add({
          "role": "model",
          "parts": [
            {"text": botReply.trim()},
          ],
        });

        return botReply.trim();
      } else if (response.statusCode == 429) {
        print('Gemini API Error 429: Rate limit exceeded.');
        return "I'm a bit overwhelmed with requests right now (Rate Limit). Please try again in a minute!";
      } else {
        final errorData = jsonDecode(response.body);
        final errorMsg = errorData['error']['message'] ?? 'Unknown error';
        print('Gemini API Error ${response.statusCode}: $errorMsg');
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
