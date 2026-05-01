import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:smart_sport_club/core/funcations/size_config.dart';
import 'package:smart_sport_club/core/styles/text_styles.dart';
import 'package:smart_sport_club/core/widgets/main_button.dart';
import 'package:smart_sport_club/dashboard/features/trainers/presentation/widgets/trainer_form_fields.dart';

class AddTrainerSheet extends StatefulWidget {
  const AddTrainerSheet({super.key});

  @override
  State<AddTrainerSheet> createState() => _AddTrainerSheetState();
}

class _AddTrainerSheetState extends State<AddTrainerSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _idController = TextEditingController();
  final _imageUrlController = TextEditingController();

  String? _selectedAcademy;
  final List<String> _academies = ['Tennis', 'Football', 'Swimming'];

  bool _isLoading = false;

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (_selectedAcademy == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select an academy type')),
        );
        return;
      }

      setState(() {
        _isLoading = true;
      });

      try {
        // Step 1: Save data to Firestore directly using the provided URL
        await FirebaseFirestore.instance.collection('trainers').add({
          'name': _nameController.text.trim(),
          'id': _idController.text.trim(),
          'academy': _selectedAcademy,
          'imageUrl': _imageUrlController.text.trim(),
          'createdAt': DateTime.now(),
        });

        if (mounted) {
          Navigator.pop(context);
        }
      } catch (e) {
        log(e.toString());
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('$e'),
              duration: const Duration(seconds: 5),
            ),
          );
          
        }
        
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _idController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    
    // Make bottom sheet responsive
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final isMobile = MediaQuery.of(context).size.width < 600;

    return Container(
      width: double.infinity,
      constraints: BoxConstraints(
        maxWidth: isMobile ? double.infinity : 600,
      ),
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: 24 + bottomInset,
      ),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Add New Trainer',
                      style: TextStyles.headline.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.close),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Form Fields Component
                TrainerFormFields(
                  nameController: _nameController,
                  idController: _idController,
                  imageUrlController: _imageUrlController,
                  selectedAcademy: _selectedAcademy,
                  academies: _academies,
                  onAcademyChanged: (String? newValue) {
                    setState(() {
                      _selectedAcademy = newValue;
                    });
                  },
                ),
                const SizedBox(height: 32),

                // Submit Button
                MainButton(
                  text: 'Add Trainer',
                  onPressed: _submitForm,
                  isLoading: _isLoading,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

