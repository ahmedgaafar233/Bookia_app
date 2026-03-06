import 'package:bookia/core/theme/app_theme.dart';
import 'package:bookia/features/auth/presentation/screens/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
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
        return MaterialApp(
          title: 'Bookia',
          debugShowCheckedModeBanner: false,
          theme: AppTheme.lightTheme,
          home: const SplashScreen(),
        );
      },
    );
  }
}
