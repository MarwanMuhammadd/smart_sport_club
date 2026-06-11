import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_sport_club/application/feature/sports/data/model/coach_model.dart';
import 'package:smart_sport_club/core/funcations/size_config.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/styles/text_styles.dart';
import 'package:smart_sport_club/core/widgets/main_button.dart';
import 'package:smart_sport_club/dashboard/features/trainers/logic/trainers_cubit.dart';
import 'package:smart_sport_club/dashboard/features/trainers/logic/trainers_state.dart';
import 'package:smart_sport_club/application/feature/sports/data/repo/academy_repo.dart';
import 'package:smart_sport_club/application/feature/sports/data/model/academy_model.dart';

class AddTrainerSheet extends StatefulWidget {
  const AddTrainerSheet({super.key});

  @override
  State<AddTrainerSheet> createState() => _AddTrainerSheetState();
}

class _AddTrainerSheetState extends State<AddTrainerSheet> {
  final _formKey = GlobalKey<FormState>();
  
  final _fullNameController = TextEditingController();
  final _specializationController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _bioController = TextEditingController();
  final _experienceYearsController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  final _emailController = TextEditingController();

  int? _selectedAcademyId;
  List<AcademyModel> _academies = [];
  bool _isLoadingAcademies = false;
  String? _academiesError;

  @override
  void initState() {
    super.initState();
    _loadAcademies();
  }

  Future<void> _loadAcademies() async {
    if (!mounted) return;
    setState(() {
      _isLoadingAcademies = true;
      _academiesError = null;
    });
    try {
      final result = await AcademyRepo.getAcademies();
      if (!mounted) return;
      if (result.response != null) {
        setState(() {
          _academies = result.response!;
          _isLoadingAcademies = false;
        });
      } else {
        setState(() {
          _academiesError = result.error ?? "Failed to load academies";
          _isLoadingAcademies = false;
        });
      }
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _academiesError = e.toString();
        _isLoadingAcademies = false;
      });
    }
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      if (_selectedAcademyId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Please select an academy'),
            backgroundColor: Colors.redAccent,
            behavior: SnackBarBehavior.floating,
          ),
        );
        return;
      }
      final experience = int.tryParse(_experienceYearsController.text.trim()) ?? 0;
      
      final coachRequest = CoachRequest(
        fullName: _fullNameController.text.trim(),
        specialization: _specializationController.text.trim(),
        imageUrl: _imageUrlController.text.trim(),
        bio: _bioController.text.trim(),
        experienceYears: experience,
        phoneNumber: _phoneNumberController.text.trim(),
        email: _emailController.text.trim(),
        academyId: _selectedAcademyId!,
      );

      context.read<TrainersCubit>().addCoach(coachRequest);
    }
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _specializationController.dispose();
    _imageUrlController.dispose();
    _bioController.dispose();
    _experienceYearsController.dispose();
    _phoneNumberController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  InputDecoration _buildInputDecoration({
    required String label,
    required String hintText,
    required IconData prefixIcon,
  }) {
    return InputDecoration(
      labelText: label,
      labelStyle: const TextStyle(color: Colors.black54),
      hintText: hintText,
      prefixIcon: Icon(prefixIcon, color: AppColors.primaryGreen),
      filled: true,
      fillColor: const Color(0xffF8FAFC),
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
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.redAccent, width: 1.5),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;
    final isMobile = MediaQuery.of(context).size.width < 600;

    return BlocListener<TrainersCubit, TrainersState>(
      listener: (context, state) {
        if (state is AddCoachSuccess) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Coach "${state.coach.fullName}" has been added!'),
              backgroundColor: AppColors.primaryGreen,
              behavior: SnackBarBehavior.floating,
            ),
          );
        } else if (state is AddCoachError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: Colors.redAccent,
              behavior: SnackBarBehavior.floating,
            ),
          );
        }
      },
      child: BlocBuilder<TrainersCubit, TrainersState>(
        builder: (context, state) {
          final isLoading = state is AddCoachLoading;

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
                            onPressed: isLoading ? null : () => Navigator.pop(context),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),

                      // Full Name Field
                      Text(
                        'Full Name',
                        style: TextStyles.body.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _fullNameController,
                        decoration: _buildInputDecoration(
                          label: 'Full Name',
                          hintText: 'Enter full name',
                          prefixIcon: Icons.person,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Full name is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Specialization Field
                      Text(
                        'Specialization',
                        style: TextStyles.body.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _specializationController,
                        decoration: _buildInputDecoration(
                          label: 'Specialization',
                          hintText: 'e.g. swimming, tennis, football',
                          prefixIcon: Icons.sports_soccer,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Specialization is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Image URL Field
                      Text(
                        'Image URL',
                        style: TextStyles.body.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _imageUrlController,
                        decoration: _buildInputDecoration(
                          label: 'Image URL',
                          hintText: 'Enter direct image URL',
                          prefixIcon: Icons.image,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Image URL is required';
                          }
                          if (!value.startsWith('http')) {
                            return 'Must start with http or https';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Bio Field
                      Text(
                        'Bio',
                        style: TextStyles.body.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _bioController,
                        maxLines: 3,
                        decoration: _buildInputDecoration(
                          label: 'Bio',
                          hintText: 'Write a short bio about the trainer...',
                          prefixIcon: Icons.description,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Bio is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Experience Years Field
                      Text(
                        'Experience Years',
                        style: TextStyles.body.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _experienceYearsController,
                        keyboardType: TextInputType.number,
                        decoration: _buildInputDecoration(
                          label: 'Experience Years',
                          hintText: 'Enter number of years',
                          prefixIcon: Icons.star_border,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Experience years is required';
                          }
                          final exp = int.tryParse(value);
                          if (exp == null || exp < 0) {
                            return 'Must be a valid positive number';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Phone Number Field
                      Text(
                        'Phone Number',
                        style: TextStyles.body.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _phoneNumberController,
                        keyboardType: TextInputType.phone,
                        decoration: _buildInputDecoration(
                          label: 'Phone Number',
                          hintText: 'e.g. 01143568826',
                          prefixIcon: Icons.phone,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Phone number is required';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Email Field
                      Text(
                        'Email',
                        style: TextStyles.body.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        decoration: _buildInputDecoration(
                          label: 'Email Address',
                          hintText: 'e.g. trainer@gmail.com',
                          prefixIcon: Icons.email,
                        ),
                        validator: (value) {
                          if (value == null || value.trim().isEmpty) {
                            return 'Email is required';
                          }
                          if (!value.contains('@') || !value.contains('.')) {
                            return 'Please enter a valid email';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: 16),

                      // Academy Name Field
                      Text(
                        'Academy Name',
                        style: TextStyles.body.copyWith(fontWeight: FontWeight.w600),
                      ),
                      const SizedBox(height: 8),
                      _isLoadingAcademies
                          ? const Center(
                              child: Padding(
                                padding: EdgeInsets.symmetric(vertical: 8.0),
                                child: CircularProgressIndicator(color: AppColors.primaryGreen),
                              ),
                            )
                          : _academiesError != null
                              ? Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Error loading academies: $_academiesError',
                                        style: const TextStyle(color: Colors.redAccent),
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(Icons.refresh, color: AppColors.primaryGreen),
                                      onPressed: _loadAcademies,
                                    ),
                                  ],
                                )
                              : DropdownButtonFormField<int>(
                                  value: _selectedAcademyId,
                                  decoration: _buildInputDecoration(
                                    label: 'Academy Name',
                                    hintText: 'Select Academy',
                                    prefixIcon: Icons.school,
                                  ),
                                  dropdownColor: Colors.white,
                                  items: _academies
                                      .where((academy) => academy.id != null)
                                      .map((academy) {
                                    return DropdownMenuItem<int>(
                                      value: academy.id,
                                      child: Text(
                                        academy.name ?? 'Unnamed Academy',
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    );
                                  }).toList(),
                                  validator: (value) {
                                    if (value == null) {
                                      return 'Please select an academy';
                                    }
                                    return null;
                                  },
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedAcademyId = value;
                                    });
                                  },
                                ),
                      const SizedBox(height: 32),

                      // Submit Button
                      MainButton(
                        text: 'Add Trainer',
                        onPressed: _submitForm,
                        isLoading: isLoading,
                        isDisabled: isLoading,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
