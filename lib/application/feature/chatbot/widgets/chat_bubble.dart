import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/application/feature/chatbot/data/models/message_model.dart';
import 'package:smart_sport_club/application/feature/chatbot/data/models/chatbot_response.dart';

class ChatBubble extends StatelessWidget {
  final MessageModel message;

  const ChatBubble({super.key, required this.message});

  @override
  Widget build(BuildContext context) {
    bool isUser = message.sender == MessageSender.user;
    final exercises = (message.chatbotResponse?.exercisesList ?? [])
        .where((exercise) => exercise.hasActualContent)
        .toList();

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
                if (!isUser && exercises.isNotEmpty) ...[
                  SizedBox(height: 14.h),
                  ...exercises.map(_ExerciseCard.new),
                ],
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

class _ExerciseCard extends StatelessWidget {
  final ExerciseModel exercise;

  const _ExerciseCard(this.exercise);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 10.h),
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.w),
        border: Border.all(color: AppColors.primaryGreen.withOpacity(0.35)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            exercise.name.isEmpty ? 'Exercise' : exercise.name,
            style: TextStyle(
              color: AppColors.blackColor,
              fontSize: 14.sp,
              fontWeight: FontWeight.w700,
            ),
          ),
          if (exercise.target.isNotEmpty) ...[
            SizedBox(height: 6.h),
            _InfoLine(label: 'Target', value: exercise.target),
          ],
          if (exercise.howTo.isNotEmpty) ...[
            SizedBox(height: 6.h),
            _InfoLine(label: 'How To', value: exercise.howTo),
          ],
          if (exercise.imageStart != null || exercise.imageEnd != null) ...[
            SizedBox(height: 10.h),
            if (exercise.imageStart != null)
              _ExerciseImage(url: exercise.imageStart!, label: 'Start'),
            if (exercise.imageEnd != null) ...[
              SizedBox(height: 8.h),
              _ExerciseImage(url: exercise.imageEnd!, label: 'End'),
            ],
          ],
        ],
      ),
    );
  }
}

class _InfoLine extends StatelessWidget {
  final String label;
  final String value;

  const _InfoLine({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        style: TextStyle(
          color: AppColors.blackColor,
          fontSize: 12.sp,
          height: 1.4,
        ),
        children: [
          TextSpan(
            text: '$label: ',
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
          TextSpan(text: value),
        ],
      ),
    );
  }
}

class _ExerciseImage extends StatelessWidget {
  final String url;
  final String label;

  const _ExerciseImage({required this.url, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: AppColors.blackColor,
            fontSize: 11.sp,
            fontWeight: FontWeight.w700,
          ),
        ),
        SizedBox(height: 4.h),
        ClipRRect(
          borderRadius: BorderRadius.circular(10.w),
          child: AspectRatio(
            aspectRatio: 16 / 10,
            child: Image.network(
              url,
              fit: BoxFit.cover,
              loadingBuilder: (context, child, loadingProgress) {
                if (loadingProgress == null) return child;

                return Container(
                  color: AppColors.backgroundColor,
                  alignment: Alignment.center,
                  child: SizedBox(
                    width: 22.w,
                    height: 22.w,
                    child: const CircularProgressIndicator(strokeWidth: 2),
                  ),
                );
              },
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  color: AppColors.backgroundColor,
                  alignment: Alignment.center,
                  child: Icon(
                    Icons.image_not_supported_outlined,
                    color: AppColors.accentGrey,
                    size: 32.w,
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
