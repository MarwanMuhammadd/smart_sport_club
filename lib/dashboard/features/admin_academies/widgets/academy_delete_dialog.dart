import 'package:flutter/material.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/text_styles.dart';

class AcademyDeleteDialog extends StatelessWidget {
  final String academyName;

  const AcademyDeleteDialog({super.key, required this.academyName});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      title: Text(
        'Delete Academy',
        style: TextStyles.title.copyWith(color: AppColors.primaryColor),
      ),
      content: Text(
        'Are you sure you want to delete "$academyName"? This action cannot be undone.',
        style: TextStyles.body.copyWith(color: AppColors.secondaryColor),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(
            'Cancel',
            style: TextStyles.body.copyWith(
              color: AppColors.secondaryColor,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text(
            'Delete',
            style: TextStyles.body.copyWith(
              color: AppColors.errorColor,
              fontWeight: FontWeight.w700,
            ),
          ),
        ),
      ],
    );
  }

  static Future<bool?> show(BuildContext context, String name) {
    return showDialog<bool>(
      context: context,
      builder: (context) => AcademyDeleteDialog(academyName: name),
    );
  }
}
