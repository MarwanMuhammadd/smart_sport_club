import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/application/feature/chatbot/logic/chatbot_cubit.dart';
import 'package:smart_sport_club/application/feature/chatbot/logic/chatbot_state.dart';
import 'package:smart_sport_club/application/feature/chatbot/widgets/chat_bubble.dart';
import 'package:smart_sport_club/application/feature/chatbot/widgets/chat_header.dart';
import 'package:smart_sport_club/application/feature/chatbot/widgets/chat_input_field.dart';
import 'package:smart_sport_club/application/feature/chatbot/widgets/typing_indicator.dart';

class ChatbotPage extends StatefulWidget {
  const ChatbotPage({super.key});

  @override
  State<ChatbotPage> createState() => _ChatbotPageState();
}

class _ChatbotPageState extends State<ChatbotPage> {
  final ScrollController _scrollController = ScrollController();

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundColor,
      appBar: const ChatHeader(),
      body: BlocListener<ChatbotCubit, ChatbotState>(
        listener: (context, state) {
          if (state is ChatbotLoaded || state is ChatbotLoading) {
            _scrollToBottom();
          }
        },
        child: BlocBuilder<ChatbotCubit, ChatbotState>(
          builder: (context, state) {
            final messages = state is ChatbotLoaded
                ? state.messages
                : (state is ChatbotLoading
                    ? state.messages
                    : (state is ChatbotError ? state.messages : []));

            return Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    controller: _scrollController,
                    padding: EdgeInsets.only(top: 20.h),
                    itemCount: messages.length,
                    itemBuilder: (context, index) {
                      return ChatBubble(message: messages[index]);
                    },
                  ),
                ),
                if (state is ChatbotLoading) const TypingIndicator(),
                const ChatInputField(),
              ],
            );
          },
        ),
      ),
    );
  }
}