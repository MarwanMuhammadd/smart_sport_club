import 'package:smart_sport_club/application/feature/chatbot/data/models/chatbot_request_params.dart';
import 'package:smart_sport_club/application/feature/chatbot/data/repo/chatbot_repo.dart';

class ChatbotApiService {
  final ChatbotRepo _repo = ChatbotRepo();

  Future<String?> sendMessage(String question) async {
    final result = await _repo.sendMessage(
      ChatbotRequestParams(question: question),
    );

    return result.response?.answer ?? result.error;
  }
}
