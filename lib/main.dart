import 'package:bookia/core/di/service_locator.dart';
import 'package:bookia/core/routes/app_router.dart';
import 'package:bookia/core/services/local/shared_prefs.dart';
import 'package:bookia/core/theme/app_theme.dart';
import 'package:bookia/feature/details/presentation/widgets/cart_action/cubit/cart_action_cubit.dart';
import 'package:bookia/feature/details/presentation/widgets/wishlist_action/cubit/wishlist_action_cubit.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();
  await SharedPrefs.init();
  await setupServiceLocator();
  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: const BookiaApp(),
    ),
  );
}

class BookiaApp extends StatelessWidget {
  const BookiaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => sl<WishlistActionCubit>(),
            ),
            BlocProvider(
              create: (context) => sl<CartActionCubit>(),
            ),
          ],
          child: MaterialApp.router(
            title: 'Bookia',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            routerConfig: AppRouter.router,
            localizationsDelegates: context.localizationDelegates,
            supportedLocales: context.supportedLocales,
            locale: context.locale,
          ),
        );
      },
    );
  }
}
