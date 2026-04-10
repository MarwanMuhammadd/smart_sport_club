import 'package:go_router/go_router.dart';
import 'package:smart_sport_club/core/goRouter/app_routes.dart';
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
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => const RegisterScreen(),
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
    ],
  );
}
