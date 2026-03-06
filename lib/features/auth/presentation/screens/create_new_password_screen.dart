import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/network/dio_consumer.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/widgets/custom_button.dart';
import 'package:bookia/core/widgets/custom_text_field.dart';
import 'package:bookia/features/auth/data/repos/auth_repository.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/features/auth/presentation/screens/password_changed_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  final String verifyCode;
  const CreateNewPasswordScreen({super.key, required this.verifyCode});

  @override
  State<CreateNewPasswordScreen> createState() => _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(AuthRepository(DioConsumer(Dio()))),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const PasswordChangedScreen()),
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
                    'Create new password',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                  const Gap(10),
                  const Text(
                    "Your new password must be unique from those previously used.",
                    style: TextStyle(color: AppColors.darkGrey, fontSize: 16),
                  ),
                  const Gap(32),
                  CustomTextField(
                    hintText: 'New Password',
                    obscureText: true,
                    controller: _passwordController,
                  ),
                  const Gap(12),
                  CustomTextField(
                    hintText: 'Confirm Password',
                    obscureText: true,
                    controller: _confirmPasswordController,
                  ),
                  const Gap(35),
                  state is AuthLoading
                      ? const Center(child: CircularProgressIndicator())
                      : CustomButton(
                          text: 'Reset Password',
                          onPressed: () {
                            context.read<AuthCubit>().resetPassword(
                                  code: widget.verifyCode,
                                  password: _passwordController.text,
                                  confirmPassword: _confirmPasswordController.text,
                                );
                          },
                        ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
