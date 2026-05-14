import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_sport_club/core/funcations/size_config.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/styles/text_styles.dart';
import 'package:smart_sport_club/core/widgets/responsive.dart';
import 'package:smart_sport_club/core/widgets/academies_header.dart';
import 'package:smart_sport_club/core/widgets/academies_search_bar.dart';
import 'package:smart_sport_club/dashboard/features/admin_offers/data/models/offer_model.dart';
import 'package:smart_sport_club/dashboard/features/admin_offers/logic/offers_cubit.dart';
import 'package:smart_sport_club/dashboard/features/admin_offers/logic/offers_state.dart';
import 'package:smart_sport_club/dashboard/features/home_dashboard/presentation/widgets/dashboard_layout.dart';
import '../widgets/offers_stats_section.dart';
import '../widgets/add_offer_bottom_sheet.dart';
import '../widgets/offers_list_section.dart';

class AdminOffersPage extends StatelessWidget {
  const AdminOffersPage({super.key});

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
          "Offers & Promotions",
          style: TextStyles.title.copyWith(color: AppColors.primaryColor),
        ),
      ),
      body: LayoutBuilder(
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
                // 1. Header
                AcademiesHeader(
                  title: 'Offers',
                  subtitle: 'Manage club offers and promotions',
                  buttonText: 'Add New Offer',
                  onButtonPressed: () => _showAddOfferBottomSheet(context),
                ),
                const SizedBox(height: 32),

                // 2. Stats Section
                BlocBuilder<OffersCubit, OffersState>(
                  buildWhen: (previous, current) => current is OffersLoaded,
                  builder: (context, state) {
                    int activeCount = 0;
                    if (state is OffersLoaded) {
                      activeCount = state.offers.where((o) => o.isActive).length;
                    }
                    return OffersStatsSection(
                      maxWidth: constraints.maxWidth,
                      activeCount: activeCount,
                    );
                  },
                ),
                const SizedBox(height: 32),

                // 3. Search Bar
                AcademiesSearchBar(
                  hintText: 'Search offers or promotions...',
                  onChanged: (value) => context.read<OffersCubit>().searchOffers(value),
                ),
                const SizedBox(height: 32),

                // 4. Offers List (Extracted)
                OffersListSection(
                  onEdit: (offer) {
                    // TODO: Implement Edit
                  },
                  onDelete: (offer) => _confirmDelete(context, offer),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // --- UI ACTIONS ---

  void _showAddOfferBottomSheet(BuildContext context) async {
    final result = await showModalBottomSheet<OfferModel>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AddOfferBottomSheet(),
    );

    if (result != null && context.mounted) {
      context.read<OffersCubit>().addOffer(result);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Offer "${result.title}" created successfully!'),
          backgroundColor: AppColors.primaryGreen,
          behavior: SnackBarBehavior.floating,
        ),
      );
    }
  }

  void _confirmDelete(BuildContext context, OfferModel offer) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: const Text('Delete Offer'),
        content: Text('Are you sure you want to delete "${offer.title}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () {
              context.read<OffersCubit>().deleteOffer(offer.id);
              Navigator.pop(dialogContext);
              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Offer deleted'),
                    backgroundColor: AppColors.errorColor,
                    behavior: SnackBarBehavior.floating,
                  ),
                );
              }
            },
            child: const Text('Delete', style: TextStyle(color: AppColors.errorColor)),
          ),
        ],
      ),
    );
  }
}
