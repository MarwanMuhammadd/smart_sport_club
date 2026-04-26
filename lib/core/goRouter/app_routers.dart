import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_sport_club/core/goRouter/app_routes.dart';
import 'package:smart_sport_club/feature/auth/cubit/auth_cubit.dart';
import 'package:smart_sport_club/feature/auth/pages/admin_screen.dart';
import 'package:smart_sport_club/feature/auth/pages/create_new_screen.dart';
import 'package:smart_sport_club/feature/auth/pages/login_screen.dart';
import 'package:smart_sport_club/feature/auth/pages/otp_screen.dart';
import 'package:smart_sport_club/feature/auth/pages/register_screen.dart';
import 'package:smart_sport_club/feature/auth/pages/request_password_screen.dart';
import 'package:smart_sport_club/feature/auth/pages/welcome_screen.dart';
import 'package:smart_sport_club/feature/booking/data/booking_model.dart';
import 'package:smart_sport_club/feature/booking/pages/booking_success_screen.dart';
import 'package:smart_sport_club/feature/booking/pages/booking_summary_screen.dart';
import 'package:smart_sport_club/feature/booking/pages/my_bookings_screen.dart';
import 'package:smart_sport_club/feature/payment/page/payment.dart';
import 'package:smart_sport_club/feature/profile/edit_profile/logic/edit_profile_cubit.dart';
import 'package:smart_sport_club/feature/profile/edit_profile/pages/edit_profile.dart';
import 'package:smart_sport_club/feature/profile/renew_membership/pages/renew_membership_page.dart';
import 'package:smart_sport_club/feature/splash/pages/splash_screen.dart';
import 'package:smart_sport_club/feature/sports/data/sports_data.dart';
import 'package:smart_sport_club/feature/sports/pages/booking_page.dart';
import 'package:smart_sport_club/main_screen.dart';

class AppRouters {
  static final router = GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: AppRoutes.welcome,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => BlocProvider(
          create: (context) => AuthCubit(),
          child: const RegisterScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.adminLogin,
        builder: (context, state) => const AdminLoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.requestPassword,
        builder: (context, state) => const RequestPasswordScreen(),
      ),
      GoRoute(
        path: AppRoutes.otp,
        builder: (context, state) => const OtpScreen(),
      ),
      GoRoute(
        path: AppRoutes.createNewPassword,
        builder: (context, state) => const CreateNewPassword(),
      ),
      GoRoute(
        path: AppRoutes.mainApp,
        builder: (context, state) {
          final tabIndex =
              int.tryParse(state.uri.queryParameters['tab'] ?? '0') ?? 0;
          return MainAppScreen(initialIndex: tabIndex);
        },
      ),
      GoRoute(
        path: AppRoutes.bookingSummary,
        builder: (context, state) {
          final bookingModel = state.extra as BookingModel;
          return BookingSummaryScreen(bookingModel: bookingModel);
        },
      ),
      GoRoute(
        path: AppRoutes.bookingSuccess,
        builder: (context, state) {
          final bookingModel = state.extra as BookingModel;
          return BookingSuccessScreen(bookingModel: bookingModel);
        },
      ),
      GoRoute(
        path: AppRoutes.booking,
        builder: (context, state) {
          final sportsData = state.extra as SportsData;
          return BookingScreen(sportsData: sportsData);
        },
      ),
      GoRoute(
        path: AppRoutes.myBookings,
        builder: (context, state) => const MyBookingsScreen(),
      ),
      GoRoute(
        path: AppRoutes.editProfile,
        builder: (context, state) {
          final args = state.extra as Map<String, dynamic>? ?? {};
          final initialName = args['initialName'] as String? ?? "Julian Alvarez";
          final initialImageUrl = args['initialImageUrl'] as String? ??
              "https://lh3.googleusercontent.com/aida-public/AB6AXuBE1FuA12FaeNZ3Ihc4di5k9KutJQhVDYRhQhvgYTiliUovi_X6cj4rZ4K1rRLdqa_Cm97u_BEtqFPoaEFvmQvoH8RxC0GSqIkSSdAs-xFlV7Tf_3x_hza_mzrloJpqSC07VbFFASKi1vj4F2NjZZKftJp2kcnt1gfvxGEt5MaEE21YwvR9xC9M2ctVg-r4VmNs8pVkkBHcgtT5QsNdtvisvh6lJDhP6NCddsqUwOhP0Kgv-6mtgwew3qiOyOm5TFC_2x9009rYDDQE";

          return BlocProvider(
            create: (context) => EditProfileCubit(
              initialName: initialName,
              initialImageUrl: initialImageUrl,
            ),
            child: EditProfile(
              initialName: initialName,
              initialImageUrl: initialImageUrl,
            ),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.renewMembership,
        builder: (context, state) => const RenewMembershipPage(),
      ),
      GoRoute(
        path: AppRoutes.payment,
        builder: (context, state) => const Payment(),
      ),
    ],
  );
}
