import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/routes/app_routes.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        context.pushReplacement(AppRoutes.welcome);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Placeholder for Logo
            Image.asset(
              AppAssets.logo,
              width: 150,
              errorBuilder: (context, error, stackTrace) {
                return const Icon(
                  Icons.book_rounded,
                  size: 100,
                  color: AppColors.secondaryColor,
                );
              },
            ),
            const SizedBox(height: 16),
            const Text(
              'Bookia',
              style: TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.bold,
                color: AppColors.secondaryColor,
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              'Order Your Book Now!',
              style: TextStyle(
                fontSize: 18,
                color: AppColors.darkGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
