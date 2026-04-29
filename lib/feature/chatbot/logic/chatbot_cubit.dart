import 'dart:async';
import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:smart_sport_club/feature/chatbot/data/app_data.dart';
import 'package:smart_sport_club/feature/chatbot/data/models/message_model.dart';
import 'package:smart_sport_club/feature/chatbot/logic/chatbot_state.dart';

const String _geminiApiKey = "AIzaSyCsEcnzqXoLyfsLz0yrTghr8BFFQayX9Xg";

const String _geminiUrl =
    'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.5-flash:generateContent?key=$_geminiApiKey';

class ChatbotCubit extends Cubit<ChatbotState> {
  ChatbotCubit() : super(ChatbotInitial()) {
    _addInitialMessage();
  }

  final List<MessageModel> _messages = [];
  final List<Map<String, dynamic>> _conversationHistory = [];

  void _addInitialMessage() {
    _messages.add(
      MessageModel(
        text: "Hello! How can I help you today?",
        sender: MessageSender.bot,
        time: DateTime.now(),
      ),
    );
    emit(ChatbotLoaded(List.from(_messages)));
  }

  Future<void> sendMessage(String text) async {
    if (text.trim().isEmpty) return;

    _messages.add(
      MessageModel(
        text: text,
        sender: MessageSender.user,
        time: DateTime.now(),
      ),
    );

    // First message: inject system prompt once
    // After that: just send plain user text
    final String messageToSend = _conversationHistory.isEmpty
        ? buildPrompt(text)
        : text;

    _conversationHistory.add({
      "role": "user",
      "parts": [
        {"text": messageToSend},
      ],
    });

    emit(ChatbotLoading(List.from(_messages)));

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

        _addBotMessage(botReply.trim());
      } else if (response.statusCode == 429) {
        print('Gemini API Error 429: Rate limit exceeded.');
        _addBotMessage(
          "I'm a bit overwhelmed with requests right now (Rate Limit). Please try again in a minute!",
        );
      } else {
        final errorData = jsonDecode(response.body);
        final errorMsg = errorData['error']['message'] ?? 'Unknown error';
        print('Gemini API Error ${response.statusCode}: $errorMsg');
        _addBotMessage(
          "Sorry, I couldn't respond right now. (${response.statusCode})",
        );
      }
    } on TimeoutException {
      print('===== TIMEOUT =====');
      _addBotMessage("Request timed out. Please check your connection.");
    } catch (e) {
      print('===== EXCEPTION: $e =====');
      _addBotMessage("Connection error. Please check your internet.");
    }
  }

  void _addBotMessage(String text) {
    _messages.add(
      MessageModel(
        text: text,
        sender: MessageSender.bot,
        time: DateTime.now(),
      ),
    );
    emit(ChatbotLoaded(List.from(_messages)));
  }
}