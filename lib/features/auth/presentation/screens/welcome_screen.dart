import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/widgets/custom_button.dart';
import 'package:bookia/features/auth/presentation/screens/login_screen.dart';
import 'package:bookia/features/auth/presentation/screens/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage(AppAssets.welcomeBgNew),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.w),
              child: Column(
                children: [
                  const Spacer(flex: 3),
                  // Logo
                  Image.asset(
                    AppAssets.logo,
                    width: 210.w,
                    height: 66.h,
                  ),
                  const Gap(10),
                  Text(
                    'Order Your Book Now!',
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: AppColors.secondaryColor.withOpacity(0.8),
                    ),
                  ),
                  const Spacer(flex: 4),
                  SizedBox(
                    width: 331.w,
                    height: 56.h,
                    child: CustomButton(
                      text: 'Login',
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const LoginScreen()),
                        );
                      },
                    ),
                  ),
                  const Gap(15),
                  SizedBox(
                    width: 331.w,
                    height: 56.h,
                    child: CustomButton(
                      text: 'Register',
                      color: AppColors.white,
                      textColor: AppColors.secondaryColor,
                      borderColor: AppColors.secondaryColor,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const RegisterScreen()),
                        );
                      },
                    ),
                  ),
                  const Gap(60),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
