import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_sport_club/core/styles/text_styles.dart';
import '../../../../core/styles/app_colors.dart';
import '../../../../core/widgets/responsive.dart';
import '../widgets/academy_card.dart';
import 'package:smart_sport_club/core/widgets/academies_header.dart';
import 'package:smart_sport_club/core/widgets/academies_search_bar.dart';
import '../widgets/academy_delete_dialog.dart';
import '../../home_dashboard/presentation/widgets/dashboard_layout.dart';
import '../../../../core/funcations/size_config.dart';
import '../logic/academies_cubit.dart';
import '../logic/academies_state.dart';
import 'package:smart_sport_club/application/feature/sports/data/model/academy_model.dart' as api_model;
import '../widgets/add_academy_bottom_sheet.dart';

class AdminAcademiesPage extends StatelessWidget {
  const AdminAcademiesPage({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    final bool isMobile = Responsive.isMobile(context);

    return DashboardLayout(
      header: AppBar(
        backgroundColor: AppColors.backgroundColor,
        elevation: 0,
        leading: isMobile
            ? Builder(
                builder: (context) => IconButton(
                  icon: const Icon(Icons.menu),
                  onPressed: () => Scaffold.of(context).openDrawer(),
                ),
              )
            : null,
        title: Text(
          "Academies Management",
          style: TextStyles.title.copyWith(color: AppColors.primaryColor),
        ),
      ),
      body: BlocListener<AcademiesCubit, AcademiesState>(
        listener: (context, state) {
          if (state is DeleteAcademyLoading) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Row(
                    children: [
                      SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(
                          color: Colors.white,
                          strokeWidth: 2,
                        ),
                      ),
                      SizedBox(width: 16),
                      Text('Deleting academy...'),
                    ],
                  ),
                  backgroundColor: AppColors.primaryColor,
                  behavior: SnackBarBehavior.floating,
                  duration: Duration(minutes: 1),
                ),
              );
          } else if (state is DeleteAcademySuccess) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text('Academy deleted successfully!'),
                  backgroundColor: AppColors.primaryGreen,
                  behavior: SnackBarBehavior.floating,
                ),
              );
          } else if (state is DeleteAcademyError) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                SnackBar(
                  content: Text('Failed to delete academy: ${state.message}'),
                  backgroundColor: AppColors.errorColor,
                  behavior: SnackBarBehavior.floating,
                ),
              );
          }
        },
        child: LayoutBuilder(
          builder: (context, constraints) {
            final double horizontalPadding = constraints.maxWidth < 600 ? 16 : 32;
            
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
                vertical: 32,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Header
                  AcademiesHeader(
                    onButtonPressed: () async {
                      final academiesCubit = context.read<AcademiesCubit>();
                      final result = await showModalBottomSheet<api_model.AcademyModel>(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (bottomSheetContext) => BlocProvider.value(
                          value: academiesCubit,
                          child: const AddAcademyBottomSheet(),
                        ),
                      );
  
                      if (result != null && context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text('${result.name} added successfully!'),
                            backgroundColor: AppColors.primaryGreen,
                            behavior: SnackBarBehavior.floating,
                          ),
                        );
                      }
                    },
                  ),
                  const SizedBox(height: 32),
                  
                  // Search Bar
                  AcademiesSearchBar(
                    onChanged: (value) {
                      context.read<AcademiesCubit>().searchAcademies(value);
                    },
                  ),
                  const SizedBox(height: 32),
                  
                  // Academies Grid
                  BlocBuilder<AcademiesCubit, AcademiesState>(
                    buildWhen: (previous, current) =>
                        current is AcademiesLoading ||
                        current is AcademiesLoaded ||
                        current is AcademiesError,
                    builder: (context, state) {
                      if (state is AcademiesLoading) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.all(50),
                            child: CircularProgressIndicator(color: AppColors.primaryGreen),
                          ),
                        );
                      }
      
                      if (state is AcademiesError) {
                        return Center(child: Text(state.message));
                      }
      
                      if (state is AcademiesLoaded) {
                        if (state.filteredAcademies.isEmpty) {
                          return Center(
                            child: Padding(
                              padding: const EdgeInsets.all(50),
                              child: Column(
                                children: [
                                  Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
                                  const SizedBox(height: 16),
                                  Text(
                                    'No academies found for "${state.searchQuery}"',
                                    style: TextStyles.body.copyWith(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
      
                        return GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 400,
                            mainAxisSpacing: 24,
                            crossAxisSpacing: 24,
                            childAspectRatio: 0.75,
                          ),
                          itemCount: state.filteredAcademies.length,
                          itemBuilder: (context, index) {
                            final academy = state.filteredAcademies[index];
                            return AcademyCard(
                              academyId: academy.academyId,
                              name: academy.name,
                              category: academy.category,
                              description: academy.description,
                              isActive: academy.isActive,
                              imageUrl: academy.imageUrl,
                              onDelete: () async {
                                final bool? confirm = await AcademyDeleteDialog.show(context, academy.name);
  
                                if (confirm == true && context.mounted) {
                                  context.read<AcademiesCubit>().deleteAcademy(academy.academyId);
                                }
                              },
                            );
                          },
                        );
                      }
      
                      return const SizedBox.shrink();
                    },
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
