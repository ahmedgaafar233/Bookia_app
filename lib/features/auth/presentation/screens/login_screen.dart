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
              leading: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: Image.asset(AppAssets.backArrow, width: 41),
              ),
            ),
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(30),
                  const Text(
                    'Welcome back! Glad to see you, Again!',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                  const Gap(32),
                  CustomTextField(
                    hintText: 'Enter your email',
                    controller: _emailController,
                  ),
                  const Gap(15),
                  CustomTextField(
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
                  const Gap(12),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => const ForgotPasswordScreen()),
                        );
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(color: AppColors.darkGrey),
                      ),
                    ),
                  ),
                  const Gap(30),
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
                  const Gap(35),
                  // ... remaining children
            Row(
              children: [
                Expanded(child: Divider(color: AppColors.borderColor)),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text('Or Login with', style: TextStyle(color: AppColors.darkGrey)),
                ),
                Expanded(child: Divider(color: AppColors.borderColor)),
              ],
            ),
            const Gap(22),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                 _socialButton(AppAssets.googleIcon),
                 _socialButton(AppAssets.appleIcon),
                 _socialButton(AppAssets.facebookIcon),
              ],
            ),
            const Gap(50),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Don't have an account? "),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const RegisterScreen()),
                    );
                  },
                  child: const Text(
                    'Register Now',
                    style: TextStyle(
                      color: AppColors.primaryColor,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const Gap(20),
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
