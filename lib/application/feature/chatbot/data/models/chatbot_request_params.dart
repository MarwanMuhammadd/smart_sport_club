class ChatbotRequestParams {
  final String question;

  ChatbotRequestParams({required this.question});

  Map<String, dynamic> toJson() => {'question': question};
}
