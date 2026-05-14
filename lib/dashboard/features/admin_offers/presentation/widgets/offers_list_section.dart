import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smart_sport_club/dashboard/features/admin_offers/data/models/offer_model.dart';
import 'package:smart_sport_club/dashboard/features/admin_offers/logic/offers_cubit.dart';
import 'package:smart_sport_club/dashboard/features/admin_offers/logic/offers_state.dart';
import '../../../../../../core/styles/app_colors.dart';
import '../../../../../../core/styles/text_styles.dart';

import 'offer_card.dart';

class OffersListSection extends StatelessWidget {
  final Function(OfferModel) onDelete;
  final Function(OfferModel) onEdit;

  const OffersListSection({
    super.key,
    required this.onDelete,
    required this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OffersCubit, OffersState>(
      builder: (context, state) {
        if (state is OffersLoading) {
          return const Center(
            child: Padding(
              padding: EdgeInsets.all(50),
              child: CircularProgressIndicator(color: AppColors.primaryGreen),
            ),
          );
        }

        if (state is OffersError) {
          return _buildErrorState(context, state.message);
        }

        if (state is OffersLoaded) {
          if (state.filteredOffers.isEmpty) {
            return _buildEmptyState(state.searchQuery);
          }

          return ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: state.filteredOffers.length,
            separatorBuilder: (context, index) => const SizedBox(height: 20),
            itemBuilder: (context, index) {
              final offer = state.filteredOffers[index];
              return OfferCard(
                offer: offer,
                onEdit: () => onEdit(offer),
                onDelete: () => onDelete(offer),
              );
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildErrorState(BuildContext context, String message) {
    return Center(
      child: Column(
        children: [
          const Icon(Icons.error_outline, color: AppColors.errorColor, size: 48),
          const SizedBox(height: 16),
          Text(message, style: const TextStyle(color: AppColors.errorColor)),
          TextButton(
            onPressed: () => context.read<OffersCubit>().loadOffers(),
            child: const Text('Retry'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(String searchQuery) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(50),
        child: Column(
          children: [
            Icon(Icons.search_off, size: 64, color: Colors.grey[400]),
            const SizedBox(height: 16),
            Text(
              searchQuery.isEmpty 
                  ? 'No offers available.' 
                  : 'No offers found for "$searchQuery"',
              style: TextStyles.body.copyWith(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}
