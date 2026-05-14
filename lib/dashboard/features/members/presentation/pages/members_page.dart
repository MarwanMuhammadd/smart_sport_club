import 'package:flutter/material.dart';
import 'package:smart_sport_club/core/funcations/size_config.dart';
import 'package:smart_sport_club/core/styles/app_colors.dart';
import 'package:smart_sport_club/core/styles/text_styles.dart';
import 'package:smart_sport_club/core/widgets/responsive.dart';
import 'package:smart_sport_club/core/widgets/academies_header.dart';
import 'package:smart_sport_club/core/widgets/academies_search_bar.dart';
import 'package:smart_sport_club/dashboard/features/home_dashboard/presentation/widgets/dashboard_layout.dart';
import '../widgets/member_card.dart';

class MembersPage extends StatelessWidget {
  const MembersPage({super.key});

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
          "Members",
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
                  title: 'Members',
                  subtitle: 'Manage all registered club members',
                  buttonText: 'Add Member',
                  onButtonPressed: () {
                    // UI only for now - no functionality
                  },
                ),
                const SizedBox(height: 32),

                // 2. Search Section
                AcademiesSearchBar(
                  hintText: 'Search members by name or email...',
                  onChanged: (value) {
                    // UI only for now - no functionality
                  },
                ),
                const SizedBox(height: 32),

                // 3. Members List
                ListView.separated(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 3,
                  separatorBuilder: (context, index) => const SizedBox(height: 16),
                  itemBuilder: (context, index) {
                    return MemberCard(
                      name: 'Member ${index + 1}',
                      email: 'member${index + 1}@example.com',
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
