import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/funcations/extensions.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/styles/text_styles.dart';
import 'package:smart_sport_club/core/widgets/custom_text_form_fields.dart';

class TrainerFormFields extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController idController;
  final TextEditingController imageUrlController;
  final String? selectedAcademy;
  final List<String> academies;
  final ValueChanged<String?> onAcademyChanged;

  const TrainerFormFields({
    super.key,
    required this.nameController,
    required this.idController,
    required this.imageUrlController,
    required this.selectedAcademy,
    required this.academies,
    required this.onAcademyChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Trainer Name
        Text(
          'Trainer Name',
          style: TextStyles.body.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        CustomTextFormField(
          controller: nameController,
          hintText: 'Enter trainer name',
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Name is required';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),

        // Academy Type
        Text(
          'Academy Type',
          style: TextStyles.body.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        DropdownButtonFormField<String>(
          value: selectedAcademy,
          decoration: InputDecoration(
            filled: true,
            fillColor: const Color(0xffF8FAFC),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15.w),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 18.h),
          ),
          hint: Text(
            'Select Academy',
            style: TextStyles.caption1.copyWith(color: AppColors.blackColor),
          ),
          items: academies.map((String academy) {
            return DropdownMenuItem<String>(
              value: academy,
              child: Text(academy),
            );
          }).toList(),
          onChanged: onAcademyChanged,
          validator: (value) => value == null ? 'Please select an academy' : null,
        ),
        const SizedBox(height: 16),

        // Trainer ID
        Text(
          'Trainer ID',
          style: TextStyles.body.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        CustomTextFormField(
          controller: idController,
          hintText: 'Enter trainer ID (e.g., T-101)',
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Trainer ID is required';
            }
            return null;
          },
        ),
        const SizedBox(height: 16),

        // Image URL
        Text(
          'Image URL',
          style: TextStyles.body.copyWith(fontWeight: FontWeight.w600),
        ),
        const SizedBox(height: 8),
        CustomTextFormField(
          controller: imageUrlController,
          hintText: 'Enter direct image URL (http...)',
          validator: (value) {
            if (value == null || value.trim().isEmpty) {
              return 'Image URL is required';
            }
            if (!value.startsWith('http')) {
              return 'Please enter a valid URL starting with http';
            }
            return null;
          },
        ),
      ],
    );
  }
}
