import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/routes/app_routes.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

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
                  SvgPicture.asset(
                    AppAssets.logoSvg,
                    width: 210.w,
                    height: 66.h,
                  ),
                  const Gap(10),
                  Text(
                    'Order Your Book Now!',
                    style: TextStyle(
                      fontSize: 18.sp,
                      color: AppColors.secondaryColor.withValues(alpha: 0.8),
                    ),
                  ),
                  const Spacer(flex: 4),
                  SizedBox(
                    width: 331.w,
                    height: 56.h,
                    child: CustomButton(
                      text: 'Login',
                      onPressed: () {
                        context.push(AppRoutes.login);
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
                        context.push(AppRoutes.register);
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
