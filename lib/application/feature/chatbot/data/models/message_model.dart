import 'package:smart_sport_club/application/feature/chatbot/data/models/chatbot_response.dart';

enum MessageSender { user, bot }

class MessageModel {
  final String text;
  final MessageSender sender;
  final DateTime time;
  final RecommendationModel? recommendation;
  final ChatbotResponse? chatbotResponse;

  MessageModel({
    required this.text,
    required this.sender,
    required this.time,
    this.recommendation,
    this.chatbotResponse,
  });
}

class RecommendationModel {
  final String title;
  final String subtitle;
  final String intensity;
  final String burn;
  final double progress;

  RecommendationModel({
    required this.title,
    required this.subtitle,
    required this.intensity,
    required this.burn,
    required this.progress,
  });
}
