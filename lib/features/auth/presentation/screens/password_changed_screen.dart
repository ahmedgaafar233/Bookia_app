import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/widgets/custom_button.dart';
import 'package:bookia/features/auth/presentation/screens/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class PasswordChangedScreen extends StatelessWidget {
  const PasswordChangedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/images/successmark.png',
              width: 100,
            ),
            const Gap(30),
            const Text(
              'Password Changed!',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
                color: AppColors.secondaryColor,
              ),
            ),
            const Gap(10),
            const Text(
              "Your password has been changed successfully.",
              textAlign: TextAlign.center,
              style: TextStyle(color: AppColors.darkGrey, fontSize: 16),
            ),
            const Gap(40),
            CustomButton(
              text: 'Back to Login',
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => const LoginScreen()),
                  (route) => false,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
