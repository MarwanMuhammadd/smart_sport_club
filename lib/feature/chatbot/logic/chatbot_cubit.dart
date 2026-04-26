import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:smart_sport_club/feature/chatbot/data/app_data.dart';
import 'package:smart_sport_club/feature/chatbot/data/models/message_model.dart';
import 'package:smart_sport_club/feature/chatbot/logic/chatbot_state.dart';

const String _geminiApiKey = "AIzaSyAH2MupU06QvoTnaCwP2ZVMc7Iu6YB9DGA";
const String _geminiUrl =
    'https://generativelanguage.googleapis.com/v1beta/models/gemini-3.1-flash-lite-preview:generateContent?key=$_geminiApiKey';

class ChatbotCubit extends Cubit<ChatbotState> {
  ChatbotCubit() : super(ChatbotInitial()) {
    _addInitialMessage();
  }

  final List<MessageModel> _messages = [];

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

    // 1. Add user message instantly
    _messages.add(
      MessageModel(
        text: text,
        sender: MessageSender.user,
        time: DateTime.now(),
      ),
    );
    emit(ChatbotLoading(List.from(_messages)));

    try {
      // 2. Build structured prompt with app data injected
      final prompt = buildPrompt(text);

      // 3. Call Gemini API
      final response = await http.post(
        Uri.parse(_geminiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "contents": [
            {
              "parts": [
                {"text": prompt},
              ],
            },
          ],
          "generationConfig": {"temperature": 0.7, "maxOutputTokens": 300},
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final botReply =
            data['candidates'][0]['content']['parts'][0]['text'] as String;

        _addBotMessage(botReply.trim());
      } else {
        _addBotMessage("I couldn't reach the server. Please try again.");
      }
    } catch (e) {
      _addBotMessage("Something went wrong. Please check your connection.");
    }
  }

  void _addBotMessage(String text) {
    _messages.add(
      MessageModel(text: text, sender: MessageSender.bot, time: DateTime.now()),
    );
    emit(ChatbotLoaded(List.from(_messages)));
  }
}
