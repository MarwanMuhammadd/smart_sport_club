import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_sport_club/application/feature/chatbot/data/models/chatbot_request_params.dart';
import 'package:smart_sport_club/application/feature/chatbot/data/models/chatbot_response.dart';
import 'package:smart_sport_club/application/feature/chatbot/data/models/message_model.dart';
import 'package:smart_sport_club/application/feature/chatbot/logic/chatbot_state.dart';
import 'package:smart_sport_club/application/feature/chatbot/data/apis/gemini_chatbot_service.dart';
import 'package:smart_sport_club/application/feature/chatbot/data/repo/chatbot_repo.dart';

class ChatbotCubit extends Cubit<ChatbotState> {
  ChatbotCubit() : super(ChatbotInitial()) {
    _addInitialMessage();
  }

  // Toggle this flag to switch between APIs
  bool useNewApi = true;

  final ChatbotRepo _chatbotRepo = ChatbotRepo();
  final GeminiChatbotService _geminiService = GeminiChatbotService();

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

    _messages.add(
      MessageModel(
        text: text,
        sender: MessageSender.user,
        time: DateTime.now(),
      ),
    );

    emit(ChatbotLoading(List.from(_messages)));

    if (useNewApi) {
      final result = await _chatbotRepo.sendMessage(
        ChatbotRequestParams(question: text),
      );

      if (result.response != null) {
        _addBotMessage(
          result.response!.answer,
          chatbotResponse: result.response,
        );
      } else {
        _addBotMessage(
          result.error ?? "Sorry, I couldn't get a response. Please try again.",
        );
      }
      return;
    }

    final botReply = await _geminiService.sendMessage(text);
    if (botReply != null) {
      _addBotMessage(botReply);
    } else {
      _addBotMessage("Sorry, I couldn't get a response. Please try again.");
    }
  }

  void _addBotMessage(String text, {ChatbotResponse? chatbotResponse}) {
    _messages.add(
      MessageModel(
        text: text,
        sender: MessageSender.bot,
        time: DateTime.now(),
        chatbotResponse: chatbotResponse,
      ),
    );
    emit(ChatbotLoaded(List.from(_messages)));
  }
}
