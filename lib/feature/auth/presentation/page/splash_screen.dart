import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/routes/app_routes.dart';
import 'package:bookia/core/services/local/shared_prefs.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
        String? token = SharedPrefs.getData(SharedPrefs.kToken) as String?;
        if (token != null && token.isNotEmpty) {
          context.pushReplacement(AppRoutes.main);
        } else {
          context.pushReplacement(AppRoutes.welcome);
        }
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
            SvgPicture.asset(
              AppAssets.logoSvg,
              width: 250.w,
            ),
          ],
        ),
      ),
    );
  }
}
