import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/text_styles.dart';
import '../../../../core/widgets/main_button.dart';
import 'package:smart_sport_club/application/feature/sports/data/model/academy_model.dart'
    as api_model;
import 'package:smart_sport_club/dashboard/features/admin_academies/logic/academies_cubit.dart';
import '../logic/academies_state.dart';

class AddAcademyBottomSheet extends StatefulWidget {
  const AddAcademyBottomSheet({super.key});

  @override
  State<AddAcademyBottomSheet> createState() => _AddAcademyBottomSheetState();
}

class _AddAcademyBottomSheetState extends State<AddAcademyBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _locationController = TextEditingController();
  final _typeController = TextEditingController(text: 'Academy');
  final _imageController = TextEditingController();
  final _displayOrderController = TextEditingController(text: '0');
  final _sportIdController = TextEditingController(text: '1');

  bool _isFeatured = false;
  bool _isNew = false;
  bool _isActive = true;

  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _descriptionController.dispose();
    _locationController.dispose();
    _typeController.dispose();
    _imageController.dispose();
    _displayOrderController.dispose();
    _sportIdController.dispose();
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
      child: BlocListener<AcademiesCubit, AcademiesState>(
        listener: (context, state) {
          if (state is AddAcademyLoading) {
            setState(() {
              _isLoading = true;
            });
          } else if (state is AddAcademyError) {
            setState(() {
              _isLoading = false;
            });
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.message),
                backgroundColor: AppColors.errorColor,
                behavior: SnackBarBehavior.floating,
              ),
            );
          }
        },
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
                      style: TextStyles.headline.copyWith(
                        color: AppColors.primaryColor,
                      ),
                    ),
                    IconButton(
                      onPressed: _isLoading
                          ? null
                          : () => Navigator.pop(context),
                      icon: const Icon(Icons.close),
                    ),
                  ],
                ),
                const SizedBox(height: 24),

                // Academy Name
                Text(
                  'Academy Name *',
                  style: TextStyles.title.copyWith(fontSize: 16),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _nameController,
                  enabled: !_isLoading,
                  decoration: _buildInputDecoration('Enter academy name'),
                  validator: (value) => value == null || value.isEmpty
                      ? 'Name is required'
                      : null,
                ),
                const SizedBox(height: 20),

                // Description
                Text(
                  'Description',
                  style: TextStyles.title.copyWith(fontSize: 16),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _descriptionController,
                  enabled: !_isLoading,
                  maxLines: 3,
                  decoration: _buildInputDecoration(
                    'Enter description (optional)',
                  ),
                ),
                const SizedBox(height: 20),

                // Location
                Text(
                  'Location',
                  style: TextStyles.title.copyWith(fontSize: 16),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _locationController,
                  enabled: !_isLoading,
                  decoration: _buildInputDecoration(
                    'Enter location (e.g. giza)',
                  ),
                ),
                const SizedBox(height: 20),

                // Type (Text Field)
                Text('Type *', style: TextStyles.title.copyWith(fontSize: 16)),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _typeController,
                  enabled: !_isLoading,
                  decoration: _buildInputDecoration(
                    'Enter academy type (e.g. Academy, Football)',
                  ),
                  validator: (value) => value == null || value.trim().isEmpty
                      ? 'Type is required'
                      : null,
                ),
                const SizedBox(height: 20),

                // Image URL
                Text(
                  'Image URL *',
                  style: TextStyles.title.copyWith(fontSize: 16),
                ),
                const SizedBox(height: 8),
                TextFormField(
                  controller: _imageController,
                  enabled: !_isLoading,
                  decoration: _buildInputDecoration('Enter image URL'),
                  onChanged: (value) {
                    setState(() {});
                  },
                  validator: (value) => value == null || value.isEmpty
                      ? 'Image URL is required'
                      : null,
                ),
                const SizedBox(height: 12),

                // Image Preview
                if (_imageController.text.isNotEmpty) ...[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(12),
                    child: Image.network(
                      _imageController.text,
                      height: 150,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 150,
                        width: double.infinity,
                        color: AppColors.dashboardBackground,
                        child: const Center(
                          child: Icon(
                            Icons.broken_image_rounded,
                            color: AppColors.cardBorder,
                            size: 48,
                          ),
                        ),
                      ),
                      loadingBuilder: (context, child, loadingProgress) {
                        if (loadingProgress == null) return child;
                        return Container(
                          height: 150,
                          width: double.infinity,
                          color: AppColors.dashboardBackground,
                          child: const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.primaryGreen,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 20),
                ],

                // Switches
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildSwitchColumn('Featured', _isFeatured, (val) {
                      setState(() => _isFeatured = val);
                    }),
                    _buildSwitchColumn('New', _isNew, (val) {
                      setState(() => _isNew = val);
                    }),
                    _buildSwitchColumn('Active', _isActive, (val) {
                      setState(() => _isActive = val);
                    }),
                  ],
                ),
                const SizedBox(height: 12),

                // Advanced Section (Collapsible ExpansionTile)
                Theme(
                  data: Theme.of(
                    context,
                  ).copyWith(dividerColor: Colors.transparent),
                  child: ExpansionTile(
                    title: Text(
                      'Advanced Options',
                      style: TextStyles.title.copyWith(
                        fontSize: 15,
                        color: AppColors.secondaryColor,
                      ),
                    ),
                    tilePadding: EdgeInsets.zero,
                    children: [
                      Row(
                        children: [
                          // Display Order
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Display Order',
                                  style: TextStyles.title.copyWith(
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                TextFormField(
                                  controller: _displayOrderController,
                                  enabled: !_isLoading,
                                  keyboardType: TextInputType.number,
                                  decoration: _buildInputDecoration('0'),
                                  validator: (value) {
                                    if (value != null && value.isNotEmpty) {
                                      if (int.tryParse(value) == null) {
                                        return 'Must be an integer';
                                      }
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: 16),
                          // Sport ID
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Sport ID',
                                  style: TextStyles.title.copyWith(
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                TextFormField(
                                  controller: _sportIdController,
                                  enabled: !_isLoading,
                                  keyboardType: TextInputType.number,
                                  decoration: _buildInputDecoration('1'),
                                  validator: (value) {
                                    if (value != null && value.isNotEmpty) {
                                      final id = int.tryParse(value);
                                      if (id == null) {
                                        return 'Must be an integer';
                                      }
                                      if (id <= 0) {
                                        return 'Must be greater than 0';
                                      }
                                    } else {
                                      return 'Sport ID is required';
                                    }
                                    return null;
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                    ],
                  ),
                ),
                const SizedBox(height: 32),

                // Submit Button
                MainButton(
                  text: 'Add Academy',
                  onPressed: _submit,
                  isLoading: _isLoading,
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

  Widget _buildSwitchColumn(
    String label,
    bool value,
    ValueChanged<bool> onChanged,
  ) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label,
          style: TextStyles.title.copyWith(
            fontSize: 14,
            color: AppColors.primaryColor,
          ),
        ),
        const SizedBox(height: 4),
        Switch(
          value: value,
          onChanged: _isLoading ? null : onChanged,
          activeThumbColor: AppColors.primaryGreen,
        ),
      ],
    );
  }

  Future<void> _submit() async {
    if (_formKey.currentState!.validate()) {
      final academyModel = api_model.AcademyModel(
        name: _nameController.text.trim(),
        description: _descriptionController.text.trim(),
        location: _locationController.text.trim().isEmpty
            ? 'unknown'
            : _locationController.text.trim(),
        imageUrl: _imageController.text.trim(),
        type: _typeController.text.trim(),
        isFeatured: _isFeatured,
        isNew: _isNew,
        isActive: _isActive,
        displayOrder: int.tryParse(_displayOrderController.text) ?? 0,
        sportId: int.tryParse(_sportIdController.text) ?? 1,
      );

      setState(() {
        _isLoading = true;
      });

      final result = await context.read<AcademiesCubit>().addAcademy(
        academyModel,
      );

      if (!mounted) return;

      setState(() {
        _isLoading = false;
      });

      if (result.response != null) {
        Navigator.pop(context, result.response);
      }
    }
  }
}
