import 'package:bookia/core/routes/app_routes.dart';
import 'package:bookia/feature/auth/presentation/page/create_new_password_screen.dart';
import 'package:bookia/feature/auth/presentation/page/forgot_password_screen.dart';
import 'package:bookia/feature/auth/presentation/page/login_screen.dart';
import 'package:bookia/feature/auth/presentation/page/otp_verification_screen.dart';
import 'package:bookia/feature/auth/presentation/page/password_changed_screen.dart';
import 'package:bookia/feature/auth/presentation/page/register_screen.dart';
import 'package:bookia/feature/auth/presentation/page/splash_screen.dart';
import 'package:bookia/feature/auth/presentation/page/welcome_screen.dart';
import 'package:bookia/feature/home/data/models/product_response_model.dart';
import 'package:bookia/feature/details/presentation/page/details_screen.dart';
import 'package:bookia/feature/home/presentation/page/home_screen.dart';
import 'package:bookia/feature/main/presentation/page/main_screen.dart';
import 'package:bookia/feature/wishlist/presentation/page/wishlist_screen.dart';
import 'package:bookia/feature/place_order/presentation/cubit/place_order_cubit.dart';
import 'package:bookia/feature/place_order/data/repository/place_order_repo.dart';
import 'package:bookia/feature/place_order/presentation/page/place_order_screen.dart';
import 'package:bookia/feature/place_order/presentation/page/checkout_success_screen.dart';
import 'package:bookia/feature/search/presentation/page/search_screen.dart';
import 'package:bookia/feature/profile/presentation/page/profile_screen.dart';
import 'package:bookia/feature/profile/presentation/page/edit_profile_screen.dart';
import 'package:bookia/feature/profile/presentation/page/reset_password_screen.dart';
import 'package:bookia/feature/profile/presentation/page/my_orders_screen.dart';
import 'package:bookia/feature/settings/presentation/page/faq_screen.dart';
import 'package:bookia/feature/settings/presentation/page/contact_us_screen.dart';
import 'package:bookia/feature/settings/presentation/page/terms_screen.dart';
import 'package:bookia/core/network/dio_consumer.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        path: AppRoutes.main,
        builder: (context, state) => const MainScreen(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.bookDetails,
        builder: (context, state) {
          final product = state.extra as Product;
          return DetailsScreen(product: product);
        },
      ),
      GoRoute(
        path: AppRoutes.wishlist,
        builder: (context, state) => const WishlistScreen(),
      ),
      GoRoute(
        path: AppRoutes.checkout,
        builder: (context, state) {
          final total = state.extra as String;
          return BlocProvider(
            create: (context) => PlaceOrderCubit(PlaceOrderRepository(DioConsumer())),
            child: PlaceOrderScreen(total: total),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.checkoutSuccess,
        builder: (context, state) => const CheckoutSuccessScreen(),
      ),
      GoRoute(
        path: AppRoutes.search,
        builder: (context, state) => const SearchScreen(),
      ),
      GoRoute(
        path: AppRoutes.profile,
        builder: (context, state) => const ProfileScreen(),
      ),
      GoRoute(
        path: AppRoutes.editProfile,
        builder: (context, state) => const EditProfileScreen(),
      ),
      GoRoute(
        path: AppRoutes.resetPasswordPage,
        builder: (context, state) => const ResetPasswordScreen(),
      ),
      GoRoute(
        path: AppRoutes.myOrders,
        builder: (context, state) => const MyOrdersScreen(),
      ),
      GoRoute(
        path: AppRoutes.faqs,
        builder: (context, state) => const FaqScreen(),
      ),
      GoRoute(
        path: AppRoutes.contactUs,
        builder: (context, state) => const ContactUsScreen(),
      ),
      GoRoute(
        path: AppRoutes.privacyTerms,
        builder: (context, state) => const PrivacyTermsScreen(),
      ),
    ],
  );
}
