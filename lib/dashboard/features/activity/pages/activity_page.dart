import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/funcations/size_config.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/styles/text_styles.dart';
import 'package:smart_sport_club/core/widgets/responsive.dart';
import 'package:smart_sport_club/core/widgets/academies_header.dart';
import 'package:smart_sport_club/core/widgets/academies_search_bar.dart';
import 'package:smart_sport_club/dashboard/features/activity/widgets/member_activites.dart';
import 'package:smart_sport_club/dashboard/features/home_dashboard/presentation/widgets/dashboard_layout.dart';
import '../widgets/training_booking_card.dart';

class ActivityPage extends StatelessWidget {
  const ActivityPage({super.key});

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
          "Activity Center",
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
                const AcademiesHeader(
                  title: 'Activity Center',
                  subtitle: 'Track member activities and club actions in real-time.',
                ),
                const SizedBox(height: 32),

                // 2. Training Booking Card & Search Bar (Responsive Row/Column)
                if (isMobile)
                  Column(
                    children: [
                      const TrainingBookingCard(),
                      const SizedBox(height: 16),
                      AcademiesSearchBar(
                        hintText: 'Search activities...',
                        onChanged: (value) {},
                      ),
                    ],
                  )
                else
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      const Expanded(
                        flex: 1,
                        child: TrainingBookingCard(),
                      ),
                      const SizedBox(width: 32),
                      Expanded(
                        flex: 1,
                        child: AcademiesSearchBar(
                          hintText: 'Search activities...',
                          onChanged: (value) {},
                        ),
                      ),
                    ],
                  ),
                const SizedBox(height: 32),

                // 3. Live Updates Section
                

                // 4. Live Updates List (Static UI)
                MemberActivites(),
              ],
            ),
          );
        },
      ),
    );
  }
}
