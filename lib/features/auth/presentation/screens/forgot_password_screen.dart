import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/network/dio_consumer.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/widgets/custom_button.dart';
import 'package:bookia/core/widgets/custom_text_field.dart';
import 'package:bookia/features/auth/data/repos/auth_repository.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/features/auth/presentation/screens/otp_verification_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(AuthRepository(DioConsumer(Dio()))),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => OTPVerificationScreen(email: _emailController.text),
              ),
            );
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
            body: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(30),
                  const Text(
                    'Forgot Password?',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                  const Gap(10),
                  const Text(
                    "Don't worry! It occurs. Please enter the email address linked with your account.",
                    style: TextStyle(color: AppColors.darkGrey, fontSize: 16),
                  ),
                  const Gap(32),
                  CustomTextField(
                    hintText: 'Enter your email',
                    controller: _emailController,
                  ),
                  const Gap(35),
                  state is AuthLoading
                      ? const Center(child: CircularProgressIndicator())
                      : CustomButton(
                          text: 'Send Code',
                          onPressed: () {
                            context.read<AuthCubit>().forgetPassword(_emailController.text);
                          },
                        ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Remember Password? "),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: const Text(
                          'Login',
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
}
