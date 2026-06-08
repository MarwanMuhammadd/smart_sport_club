import 'dart:io';

import 'package:smart_sport_club/core/constant/app_images.dart';
import 'package:smart_sport_club/core/local/shared_pref.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:smart_sport_club/application/feature/auth/cubit/auth_cubit.dart';
import 'package:smart_sport_club/application/feature/home/pages/empty_page.dart';
import 'package:smart_sport_club/application/feature/auth/pages/create_new_screen.dart';
import 'package:smart_sport_club/application/feature/auth/pages/login_screen.dart';
import 'package:smart_sport_club/application/feature/auth/pages/otp_screen.dart';
import 'package:smart_sport_club/application/feature/auth/pages/register_screen.dart';
import 'package:smart_sport_club/application/feature/auth/pages/request_password_screen.dart';
import 'package:smart_sport_club/application/feature/auth/pages/welcome_screen.dart';
import 'package:smart_sport_club/application/feature/booking/data/booking_model.dart';
import 'package:smart_sport_club/application/feature/booking/pages/booking_success_screen.dart';
import 'package:smart_sport_club/application/feature/booking/pages/booking_summary_screen.dart';
import 'package:smart_sport_club/application/feature/booking/pages/my_bookings_screen.dart';
import 'package:smart_sport_club/application/feature/payment/data/renewal_plan_model.dart';
import 'package:smart_sport_club/application/feature/payment/page/payment.dart';
import 'package:smart_sport_club/application/feature/payment/page/payment_successful.dart';
import 'package:smart_sport_club/application/feature/payment/renew_membership/pages/renew_membership_page.dart';
import 'package:smart_sport_club/application/feature/profile/edit_profile/logic/edit_profile_cubit.dart';
import 'package:smart_sport_club/application/feature/profile/edit_profile/pages/edit_profile.dart';
import 'package:smart_sport_club/application/feature/splash/pages/splash_screen.dart';
import 'package:smart_sport_club/core/models/academy_model.dart';
import 'package:smart_sport_club/application/feature/sports/pages/booking_page.dart';
import 'package:smart_sport_club/application/main_screen.dart';
import 'package:smart_sport_club/core/goRouter/app_routes.dart';

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
        path: AppRoutes.requestPassword,
        builder: (context, state) => const RequestPasswordScreen(),
      ),
     
      GoRoute(
        path: AppRoutes.otp,
        builder: (context, state) => const OtpScreen(),
      ),
      GoRoute(
        path: AppRoutes.serviceNotAvailable,
        builder: (context, state) => const EmptyPage(),
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
          final academy = state.extra as Academy;
          return BookingScreen(academy: academy);
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
          final initialName =
              args['initialName'] as String? ?? SharedPref.getUserName().trim();
          final initialImageUrl =
              args['initialImageUrl'] as String? ?? AppImages.userAvatarPlaceholderSvg;

          final initialImageFile = args['initialImageFile'] as File?;

          return BlocProvider(
            create: (context) => EditProfileCubit(
              initialName: initialName,
              initialImageUrl: initialImageUrl,
              initialImageFile: initialImageFile,
            ),
            child: EditProfile(
              initialName: initialName,
              initialImageUrl: initialImageUrl,
              initialImageFile: initialImageFile,
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
        builder: (context, state) {
          final plan = state.extra as RenewalPlan?;
          return Payment(plan: plan);
        },
      ),
      GoRoute(
        path: AppRoutes.paymentSuccessful,
        builder: (context, state) {
          final args = state.extra as Map<String, String>;
          return PaymentSuccessful(
            membershipType: args['membershipType']!,
            paymentMethod: args['paymentMethod']!,
            startDate: args['startDate']!,
            expiryDate: args['expiryDate']!,
          );
        },
      ),
     
    ],
  );
}
