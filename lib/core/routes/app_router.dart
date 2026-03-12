import 'package:bookia/core/routes/app_routes.dart';
import 'package:bookia/features/auth/presentation/screens/create_new_password_screen.dart';
import 'package:bookia/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:bookia/features/auth/presentation/screens/login_screen.dart';
import 'package:bookia/features/auth/presentation/screens/otp_verification_screen.dart';
import 'package:bookia/features/auth/presentation/screens/password_changed_screen.dart';
import 'package:bookia/features/auth/presentation/screens/register_screen.dart';
import 'package:bookia/features/auth/presentation/screens/splash_screen.dart';
import 'package:bookia/features/auth/presentation/screens/welcome_screen.dart';
import 'package:bookia/features/home/data/models/product_response_model.dart';
import 'package:bookia/features/home/presentation/screens/book_details_screen.dart';
import 'package:bookia/features/home/presentation/screens/home_screen.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
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
        path: AppRoutes.forgotPassword,
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: AppRoutes.otpVerification,
        builder: (context, state) {
          final email = state.extra as String;
          return OTPVerificationScreen(email: email);
        },
      ),
      GoRoute(
        path: AppRoutes.createPassword,
        builder: (context, state) {
          final code = state.extra as String;
          return CreateNewPasswordScreen(verifyCode: code);
        },
      ),
      GoRoute(
        path: AppRoutes.passwordChanged,
        builder: (context, state) => const PasswordChangedScreen(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.bookDetails,
        builder: (context, state) {
          final product = state.extra as Product;
          return BookDetailsScreen(product: product);
        },
      ),
    ],
  );
}
