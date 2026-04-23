import 'package:smart_sport_club/feature/chatbot/data/models/message_model.dart';

abstract class ChatbotState {}

class ChatbotInitial extends ChatbotState {}

class ChatbotLoading extends ChatbotState {
  final List<MessageModel> messages;
  ChatbotLoading(this.messages);
}

class ChatbotLoaded extends ChatbotState {
  final List<MessageModel> messages;
  ChatbotLoaded(this.messages);
}

class ChatbotError extends ChatbotState {
  final String message;
  final List<MessageModel> messages;
  ChatbotError(this.message, this.messages);
}
