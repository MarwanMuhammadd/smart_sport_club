import 'package:flutter/material.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/text_styles.dart';
import '../../../../core/widgets/main_button.dart';
import '../data/academy_model.dart';

class AddAcademyBottomSheet extends StatefulWidget {
  const AddAcademyBottomSheet({super.key});

  @override
  State<AddAcademyBottomSheet> createState() => _AddAcademyBottomSheetState();
}

class _AddAcademyBottomSheetState extends State<AddAcademyBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _imageController = TextEditingController();
  final _otherSportController = TextEditingController();

  String _selectedSport = 'tennis';
  final List<String> _sports = ['tennis', 'football', 'swimming', 'basketball', 'Other'];

  @override
  void dispose() {
    _nameController.dispose();
    _imageController.dispose();
    _otherSportController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 24,
        right: 24,
        top: 24,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Add New Academy',
                    style: TextStyles.headline.copyWith(color: AppColors.primaryColor),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              
              // Academy Name
              Text('Academy Name', style: TextStyles.title.copyWith(fontSize: 16)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _nameController,
                decoration: _buildInputDecoration('Enter academy name'),
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 20),

              // Image URL
              Text('Image URL', style: TextStyles.title.copyWith(fontSize: 16)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _imageController,
                decoration: _buildInputDecoration('Enter image URL'),
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 20),

              // Sport Type
              Text('Sport Type', style: TextStyles.title.copyWith(fontSize: 16)),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedSport,
                decoration: _buildInputDecoration(''),
                items: _sports.map((sport) {
                  return DropdownMenuItem(
                    value: sport,
                    child: Text(sport[0].toUpperCase() + sport.substring(1)),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedSport = value!;
                  });
                },
              ),
              
              // Conditional "Other" Sport Field
              if (_selectedSport == 'Other') ...[
                const SizedBox(height: 20),
                Text('Custom Sport Name', style: TextStyles.title.copyWith(fontSize: 16)),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _otherSportController,
                  decoration: _buildInputDecoration('Enter sport name'),
                  validator: (value) => _selectedSport == 'Other' && (value == null || value.isEmpty) ? 'Required' : null,
                ),
              ],

              const SizedBox(height: 32),
              
              // Submit Button
              MainButton(
                text: 'Add Academy',
                onPressed: _submit,
                width: double.infinity,
                height: 54,
                bgColor: AppColors.primaryGreen,
                textStyle: TextStyles.body.copyWith(
                  color: AppColors.primaryColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      filled: true,
      fillColor: AppColors.dashboardBackground,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide.none,
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.primaryGreen, width: 1.5),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      final String sport = _selectedSport == 'Other' ? _otherSportController.text : _selectedSport;
      
      final academy = Academy(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        name: _nameController.text,
        category: sport.toUpperCase(),
        isActive: true,
        trainerCount: 0,
        imageUrl: _imageController.text,
      );
      
      Navigator.pop(context, academy);
    }
  }
}
