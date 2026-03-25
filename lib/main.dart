import 'package:bookia/core/routes/app_router.dart';
import 'package:bookia/core/services/local/shared_prefs.dart';
import 'package:bookia/core/theme/app_theme.dart';
import 'package:bookia/core/network/dio_consumer.dart';
import 'package:bookia/feature/cart/data/repos/cart_repo.dart';
import 'package:bookia/feature/details/presentation/widgets/cart_action/cubit/cart_action_cubit.dart';
import 'package:bookia/feature/details/presentation/widgets/wishlist_action/cubit/wishlist_action_cubit.dart';
import 'package:bookia/feature/wishlist/data/repos/wishlist_repo.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefs.init();
  runApp(const BookiaApp());
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
              create: (context) => WishlistActionCubit(
                WishlistRepository(DioConsumer()),
              ),
            ),
            BlocProvider(
              create: (context) => CartActionCubit(
                CartRepository(DioConsumer()),
              ),
            ),
          ],
          child: MaterialApp.router(
            title: 'Bookia',
            debugShowCheckedModeBanner: false,
            theme: AppTheme.lightTheme,
            routerConfig: AppRouter.router,
          ),
        );
      },
    );
  }
}
