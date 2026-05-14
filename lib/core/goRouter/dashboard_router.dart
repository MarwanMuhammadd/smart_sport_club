import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_sport_club/dashboard/features/admin_academies/logic/academies_cubit.dart';
import 'package:smart_sport_club/dashboard/features/admin_academies/page/admin_academies_page.dart';
import 'package:smart_sport_club/dashboard/features/admin_offers/presentation/pages/admin_offers_page.dart';
import 'package:smart_sport_club/dashboard/features/auth/presentation/pages/admin_screen.dart';
import 'package:smart_sport_club/dashboard/features/home_dashboard/presentation/pages/home_dashboard_page.dart';
import 'package:smart_sport_club/core/goRouter/app_routes.dart';
import 'package:smart_sport_club/dashboard/features/members/logic/members_cubit.dart';
import 'package:smart_sport_club/dashboard/features/members/presentation/pages/members_page.dart';
import 'package:smart_sport_club/dashboard/features/splash/presentation/dashborad_spash.dart';
import 'package:smart_sport_club/dashboard/features/trainers/logic/trainers_cubit.dart';
import 'package:smart_sport_club/dashboard/features/trainers/presentation/pages/trainers_screen.dart';
import 'package:smart_sport_club/dashboard/features/activity/pages/activity_page.dart';
import 'package:smart_sport_club/dashboard/features/admin_offers/logic/offers_cubit.dart';
import 'package:smart_sport_club/dashboard/features/admin_offers/data/repos/offers_repository_impl.dart';

class DashboardRouter {
  static final router = GoRouter(
    initialLocation: AppRoutes.dashboradSpash,
    routes: [
      GoRoute(
        path: AppRoutes.dashboradSpash,
        builder: (context, state) => const DashboradSpash(),
      ),
      GoRoute(
        path: AppRoutes.adminLogin,
        builder: (context, state) => const AdminLoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.homeDashboard,
        builder: (context, state) => const HomeDashboardPage(),
      ),
      GoRoute(
        path: AppRoutes.trainers,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => TrainersCubit()..subscribeToTrainers(),
            ),
            BlocProvider(
              create: (context) => AcademiesCubit()..loadAcademies(),
            ),
          ],
          child: const TrainersScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.academies,
        builder: (context, state) => BlocProvider(
          create: (context) => AcademiesCubit()..loadAcademies(),
          child: const AdminAcademiesPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.members,
        builder: (context, state) => BlocProvider(
          create: (context) => MembersCubit()..subscribeToMembers(),
          child: const MembersPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.offers,
        builder: (context, state) => BlocProvider(
          create: (context) => OffersCubit(OffersRepositoryImpl())..loadOffers(),
          child: const AdminOffersPage(),
        ),
      ),
      GoRoute(
        path: AppRoutes.requests,
        builder: (context, state) => const ActivityPage(),
      ),
    ],
  );
}
