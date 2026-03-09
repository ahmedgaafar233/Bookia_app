import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/network/dio_consumer.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/widgets/custom_button.dart';
import 'package:bookia/core/widgets/custom_text_field.dart';
import 'package:bookia/features/auth/data/repos/auth_repository.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/features/auth/presentation/screens/forgot_password_screen.dart';
import 'package:bookia/features/auth/presentation/screens/register_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(AuthRepository(DioConsumer(Dio()))),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.loginResponseModel.message ?? 'Success')),
            );
            // Navigate to Home (To be implemented)
          } else if (state is AuthError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(state.message)),
            );
          }
        },
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              automaticallyImplyLeading: false,
              title: Padding(
                padding: EdgeInsets.only(left: 10.w),
                child: Row(
                  children: [
                    Container(
                      width: 41.w,
                      height: 41.h,
                      decoration: BoxDecoration(
                        border: Border.all(color: AppColors.borderColor),
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: Icon(Icons.arrow_back_ios_new, size: 15.sp),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            body: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 22.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Gap(30.h),
                   Text(
                    'Welcome back! Glad to see you, Again!',
                    style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                   Gap(32.h),
                  SizedBox(
                    width: 331.w,
                    height: 56.h,
                    child: CustomTextField(
                      hintText: 'Enter your email',
                      controller: _emailController,
                    ),
                  ),
                   Gap(15.h),
                  SizedBox(
                    width: 331.w,
                    height: 56.h,
                    child: CustomTextField(
                      hintText: 'Enter your password',
                      controller: _passwordController,
                      obscureText: !_isPasswordVisible,
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                        icon: Icon(
                          _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                          color: AppColors.darkGrey,
                        ),
                      ),
                    ),
                  ),
                   Gap(12.h),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
                        );
                      },
                      child:  Text(
                        'Forgot Password?',
                        style: TextStyle(color: AppColors.darkGrey, fontSize: 14.sp),
                      ),
                    ),
                  ),
                   Gap(30.h),
                  state is AuthLoading
                      ? const Center(child: CircularProgressIndicator())
                      : CustomButton(
                          text: 'Login',
                          onPressed: () {
                            context.read<AuthCubit>().login(
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                );
                          },
                        ),
                   Gap(35.h),
                  Row(
                    children: [
                       Expanded(child: Divider(color: AppColors.borderColor, thickness: 1)),
                       Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10.w),
                        child: Text('Or Login with', style: TextStyle(color: AppColors.darkGrey, fontSize: 14.sp)),
                      ),
                       Expanded(child: Divider(color: AppColors.borderColor, thickness: 1)),
                    ],
                  ),
                   Gap(22.h),
                  Row(
                    children: [
                      Expanded(
                        child: CustomButton(
                          text: 'Google',
                          onPressed: () {},
                          color: AppColors.white,
                          textColor: AppColors.secondaryColor,
                          borderColor: AppColors.borderColor,
                          prefixIcon: SvgPicture.asset(AppAssets.googleIc, width: 24.w),
                        ),
                      ),
                       Gap(8.w),
                      Expanded(
                        child: CustomButton(
                          text: 'Apple',
                          onPressed: () {},
                          color: AppColors.white,
                          textColor: AppColors.secondaryColor,
                          borderColor: AppColors.borderColor,
                          prefixIcon: SvgPicture.asset(AppAssets.appleIc, width: 24.w),
                        ),
                      ),
                       Gap(8.w),
                      Expanded(
                        child: CustomButton(
                          text: 'Facebook',
                          onPressed: () {},
                          color: AppColors.white,
                          textColor: AppColors.secondaryColor,
                          borderColor: AppColors.borderColor,
                          prefixIcon: SvgPicture.asset(AppAssets.facebookIcon, width: 24.w),
                        ),
                      ),
                    ],
                  ),
                   Gap(50.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Text("Don't have an account? ", style: TextStyle(fontSize: 15.sp)),
                      GestureDetector(
                        onTap: () {
                          Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(builder: (context) => const RegisterScreen()),
                          );
                        },
                        child:  Text(
                          'Register Now',
                          style: TextStyle(
                            color: AppColors.primaryColor,
                            fontWeight: FontWeight.bold,
                            fontSize: 15.sp,
                          ),
                        ),
                      ),
                    ],
                  ),
                   Gap(20.h),
                ],
              ),
            ),
          );
        },
),
);
  }

  Widget _socialButton(String iconPath) {
    return Container(
      width: 105,
      height: 56,
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.borderColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: SvgPicture.asset(
          iconPath,
          width: 30,
        ),
      ),
    );
  }
}
