import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/application/feature/chatbot/data/models/message_model.dart';

class ChatBubble extends StatelessWidget {
  final MessageModel message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    bool isUser = message.sender == MessageSender.user;

    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h, horizontal: 24.w),
      child: Column(
        crossAxisAlignment: isUser
            ? CrossAxisAlignment.end
            : CrossAxisAlignment.start,
        children: [
          Container(
            padding: EdgeInsets.all(16.w),
            constraints: BoxConstraints(
              maxWidth: MediaQuery.sizeOf(context).width * 0.7,
            ),
            decoration: BoxDecoration(
              color: isUser ? AppColors.primaryGreen : AppColors.blackColor,
              border: isUser
                  ? null
                  : Border.all(color: AppColors.primaryGreen, width: 2),
              borderRadius: BorderRadius.only(
                topLeft: const Radius.circular(24),
                topRight: const Radius.circular(24),
                bottomLeft: Radius.circular(isUser ? 24 : 8),
                bottomRight: Radius.circular(isUser ? 8 : 24),
              ),
              boxShadow: [
                BoxShadow(
                  color: isUser
                      ? AppColors.primaryGreen.withOpacity(0.3)
                      : Colors.black.withOpacity(0.3),
                  blurRadius: 15,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message.text,
                  style: TextStyle(
                    color: isUser ? AppColors.blackColor : Colors.white,
                    fontSize: 14.sp,
                    fontWeight: isUser ? FontWeight.w600 : FontWeight.w400,
                    height: 1.6,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 4.h),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Text(
              DateFormat('hh:mm a').format(message.time),
              style: TextStyle(
                color: AppColors.accentGrey,
                fontSize: 10.sp,
                // fontFamily: 'Inter',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
