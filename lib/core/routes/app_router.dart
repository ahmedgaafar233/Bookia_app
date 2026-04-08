import 'package:bookia/core/di/service_locator.dart';
import 'package:bookia/core/routes/app_routes.dart';
import 'package:bookia/feature/auth/presentation/page/create_new_password_screen.dart';
import 'package:bookia/feature/auth/presentation/page/forgot_password_screen.dart';
import 'package:bookia/feature/auth/presentation/page/login_screen.dart';
import 'package:bookia/feature/auth/presentation/page/otp_verification_screen.dart';
import 'package:bookia/feature/auth/presentation/page/password_changed_screen.dart';
import 'package:bookia/feature/auth/presentation/page/register_screen.dart';
import 'package:bookia/feature/auth/presentation/page/splash_screen.dart';
import 'package:bookia/feature/auth/presentation/page/welcome_screen.dart';
import 'package:bookia/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/feature/home/data/models/product_response_model.dart';
import 'package:bookia/feature/details/presentation/page/details_screen.dart';
import 'package:bookia/feature/home/presentation/cubit/home_cubit.dart';
import 'package:bookia/feature/home/presentation/page/home_screen.dart';
import 'package:bookia/feature/main/presentation/page/main_screen.dart';
import 'package:bookia/feature/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:bookia/feature/wishlist/presentation/page/wishlist_screen.dart';
import 'package:bookia/feature/cart/presentation/cubit/cart_cubit.dart';
import 'package:bookia/feature/place_order/presentation/cubit/place_order_cubit.dart';
import 'package:bookia/feature/place_order/presentation/page/place_order_screen.dart';
import 'package:bookia/feature/place_order/presentation/page/checkout_success_screen.dart';
import 'package:bookia/feature/search/presentation/cubit/search_cubit.dart';
import 'package:bookia/feature/search/presentation/page/search_screen.dart';
import 'package:bookia/feature/profile/presentation/cubit/profile_cubit.dart';
import 'package:bookia/feature/profile/presentation/page/profile_screen.dart';
import 'package:bookia/feature/profile/presentation/page/edit_profile_screen.dart';
import 'package:bookia/feature/profile/presentation/page/reset_password_screen.dart';
import 'package:bookia/feature/profile/presentation/page/my_orders_screen.dart';
import 'package:bookia/feature/settings/presentation/cubit/settings_cubit.dart';
import 'package:bookia/feature/settings/presentation/page/faq_screen.dart';
import 'package:bookia/feature/settings/presentation/page/contact_us_screen.dart';
import 'package:bookia/feature/settings/presentation/page/terms_screen.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final router = GoRouter(
    initialLocation: AppRoutes.splash,
    routes: [
      GoRoute(
        path: AppRoutes.splash,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<AuthCubit>(),
          child: const SplashScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.welcome,
        builder: (context, state) => const WelcomeScreen(),
      ),
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<AuthCubit>(),
          child: const LoginScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.register,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<AuthCubit>(),
          child: const RegisterScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.forgotPassword,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<AuthCubit>(),
          child: const ForgotPasswordScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.otpVerification,
        builder: (context, state) {
          final email = state.extra as String;
          return BlocProvider(
            create: (_) => sl<AuthCubit>(),
            child: OTPVerificationScreen(email: email),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.createPassword,
        builder: (context, state) {
          final code = state.extra as String;
          return BlocProvider(
            create: (_) => sl<AuthCubit>(),
            child: CreateNewPasswordScreen(verifyCode: code),
          );
        },
      ),
      GoRoute(
        path: AppRoutes.passwordChanged,
        builder: (context, state) => const PasswordChangedScreen(),
      ),
      GoRoute(
        path: AppRoutes.main,
        builder: (context, state) => MultiBlocProvider(
          providers: [
            BlocProvider(create: (_) => sl<HomeCubit>()),
            BlocProvider(create: (_) => sl<CartCubit>()),
            BlocProvider(create: (_) => sl<WishlistCubit>()),
            BlocProvider(create: (_) => sl<ProfileCubit>()),
            BlocProvider(create: (_) => sl<SettingsCubit>()),
          ],
          child: const MainScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<HomeCubit>(),
          child: const HomeScreen(),
        ),
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
        builder: (context, state) => BlocProvider(
          create: (_) => sl<WishlistCubit>(),
          child: const WishlistScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.checkout,
        builder: (context, state) {
          final total = state.extra as String;
          return BlocProvider(
            create: (_) => sl<PlaceOrderCubit>(),
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
        builder: (context, state) => BlocProvider(
          create: (_) => sl<SearchCubit>(),
          child: const SearchScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.profile,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<ProfileCubit>(),
          child: const ProfileScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.editProfile,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<ProfileCubit>(),
          child: const EditProfileScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.resetPasswordPage,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<ProfileCubit>(),
          child: const ResetPasswordScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.myOrders,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<ProfileCubit>(),
          child: const MyOrdersScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.faqs,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<SettingsCubit>(),
          child: const FaqScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.contactUs,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<SettingsCubit>(),
          child: const ContactUsScreen(),
        ),
      ),
      GoRoute(
        path: AppRoutes.privacyTerms,
        builder: (context, state) => BlocProvider(
          create: (_) => sl<SettingsCubit>(),
          child: const PrivacyTermsScreen(),
        ),
      ),
    ],
  );
}
