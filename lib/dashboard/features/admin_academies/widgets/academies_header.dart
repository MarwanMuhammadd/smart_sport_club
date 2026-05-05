import 'package:flutter/material.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/styles/text_styles.dart';
import '../../../../core/widgets/main_button.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../logic/academies_cubit.dart';
import '../data/academy_model.dart';
import 'add_academy_bottom_sheet.dart';

class AcademiesHeader extends StatelessWidget {
  const AcademiesHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final bool isSmallScreen = MediaQuery.of(context).size.width < 800;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Main Title
        Text(
          'Academies',
          style: TextStyles.hugeHeadLine.copyWith(
            color: AppColors.primaryColor,
            fontSize: isSmallScreen ? 32 : 48,
            letterSpacing: -1.2,
          ),
        ),
        const SizedBox(height: 8),

        // Subtitle and Action Button
        if (isSmallScreen)
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Manage all sports academies in your club',
                style: TextStyles.body.copyWith(
                  color: AppColors.secondaryColor,
                  fontWeight: FontWeight.w400,
                ),
              ),
              const SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                child: _buildAddButton(),
              ),
            ],
          )
        else
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  'Manage all sports academies in your club',
                  style: TextStyles.body.copyWith(
                    color: AppColors.secondaryColor,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              SizedBox(
                width: 240,
                child: _buildAddButton(),
              ),
            ],
          ),
      ],
    );
  }

  Widget _buildAddButton() {
    return Builder(
      builder: (context) {
        return MainButton(
          text: 'Add New Academy',
          onPressed: () async {
            final result = await showModalBottomSheet<Academy>(
              context: context,
              isScrollControlled: true,
              backgroundColor: Colors.transparent,
              builder: (context) => const AddAcademyBottomSheet(),
            );

            if (result != null && context.mounted) {
              context.read<AcademiesCubit>().addAcademy(result);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${result.name} added successfully!'),
                  backgroundColor: AppColors.primaryGreen,
                  behavior: SnackBarBehavior.floating,
                ),
              );
            }
          },
          height: 48,
          bgColor: AppColors.primaryGreen,
          textStyle: TextStyles.body.copyWith(
            color: AppColors.primaryColor,
            fontWeight: FontWeight.w700,
          ),
        );
      }
    );
  }
}
