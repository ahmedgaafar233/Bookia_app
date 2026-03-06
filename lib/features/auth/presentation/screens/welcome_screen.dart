import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/widgets/custom_button.dart';
import 'package:bookia/features/auth/presentation/screens/login_screen.dart';
import 'package:bookia/features/auth/presentation/screens/register_screen.dart';
import 'package:flutter/material.dart';

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
                image: AssetImage(AppAssets.welcomeBg),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(22.0),
              child: Column(
                children: [
                  const Spacer(),
                  // Logo
                  Image.asset(
                    AppAssets.logo,
                    width: 150,
                  ),
                  const Gap(12),
                  const Text(
                    'Bookia',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                  const Spacer(flex: 2),
                  CustomButton(
                    text: 'Login',
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                      );
                    },
                  ),
                  const SizedBox(height: 15),
                  CustomButton(
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
                  const Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
