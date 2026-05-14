import 'package:flutter/material.dart';
import '../../../../../../core/styles/app_colors.dart';
import '../../../../../../core/styles/text_styles.dart';
import '../../../../../../core/widgets/main_button.dart';
import '../../data/models/offer_model.dart';

class AddOfferBottomSheet extends StatefulWidget {
  const AddOfferBottomSheet({super.key});

  @override
  State<AddOfferBottomSheet> createState() => _AddOfferBottomSheetState();
}

class _AddOfferBottomSheetState extends State<AddOfferBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageController = TextEditingController();

  String _selectedType = 'discount';
  final List<String> _types = ['discount', 'event', 'seasonal', 'academy-specific'];
  
  DateTime? _selectedEndDate;

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _imageController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 7)),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: AppColors.primaryGreen,
              onPrimary: AppColors.primaryColor,
              onSurface: AppColors.primaryColor,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null && picked != _selectedEndDate) {
      setState(() {
        _selectedEndDate = picked;
      });
    }
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
                    'Create New Offer',
                    style: TextStyles.headline.copyWith(color: AppColors.primaryColor),
                  ),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              
              // Offer Title
              Text('Offer Title', style: TextStyles.title.copyWith(fontSize: 16)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _titleController,
                decoration: _buildInputDecoration('Enter offer title'),
                validator: (value) => value == null || value.isEmpty ? 'Required' : null,
              ),
              const SizedBox(height: 20),

              // Description
              Text('Description', style: TextStyles.title.copyWith(fontSize: 16)),
              const SizedBox(height: 8),
              TextFormField(
                controller: _descriptionController,
                maxLines: 3,
                decoration: _buildInputDecoration('Enter offer details'),
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

              // Offer Type
              Text('Offer Type', style: TextStyles.title.copyWith(fontSize: 16)),
              const SizedBox(height: 8),
              DropdownButtonFormField<String>(
                value: _selectedType,
                decoration: _buildInputDecoration(''),
                items: _types.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type[0].toUpperCase() + type.substring(1)),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedType = value!;
                  });
                },
              ),
              const SizedBox(height: 20),

              // End Date
              Text('End Date (Optional)', style: TextStyles.title.copyWith(fontSize: 16)),
              const SizedBox(height: 8),
              InkWell(
                onTap: () => _selectDate(context),
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                  decoration: BoxDecoration(
                    color: AppColors.dashboardBackground,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _selectedEndDate == null 
                            ? 'No expiry date' 
                            : '${_selectedEndDate!.day}/${_selectedEndDate!.month}/${_selectedEndDate!.year}',
                        style: TextStyles.body.copyWith(
                          color: _selectedEndDate == null ? Colors.grey : AppColors.primaryColor,
                        ),
                      ),
                      const Icon(Icons.calendar_today_outlined, size: 20, color: AppColors.primaryColor),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 32),
              
              // Submit Button
              MainButton(
                text: 'Create Offer',
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
      final offer = OfferModel(
        id: '', // Will be generated
        title: _titleController.text,
        description: _descriptionController.text,
        imageUrl: _imageController.text,
        type: _selectedType,
        endDate: _selectedEndDate,
        createdAt: DateTime.now(),
        isActive: true,
        usedCount: 0,
      );
      
      Navigator.pop(context, offer);
    }
  }
}
