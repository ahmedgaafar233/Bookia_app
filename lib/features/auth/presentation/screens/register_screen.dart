import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/network/dio_consumer.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/widgets/custom_button.dart';
import 'package:bookia/core/widgets/custom_text_field.dart';
import 'package:bookia/features/auth/data/repos/auth_repository.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/features/auth/presentation/screens/login_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

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
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const LoginScreen()),
              (route) => false,
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
            body: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 22),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Gap(30),
                  const Text(
                    'Hello! Register to get started',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                  const Gap(32),
                  CustomTextField(hintText: 'Username', controller: _nameController),
                  const Gap(12),
                  CustomTextField(hintText: 'Email', controller: _emailController),
                  const Gap(12),
                  CustomTextField(
                    hintText: 'Password',
                    obscureText: true,
                    controller: _passwordController,
                  ),
                  const Gap(12),
                  CustomTextField(
                    hintText: 'Confirm password',
                    obscureText: true,
                    controller: _confirmPasswordController,
                  ),
                  const Gap(30),
                  state is AuthLoading
                      ? const Center(child: CircularProgressIndicator())
                      : CustomButton(
                          text: 'Register',
                          onPressed: () {
                            context.read<AuthCubit>().register(
                                  name: _nameController.text,
                                  email: _emailController.text,
                                  password: _passwordController.text,
                                  passwordConfirmation: _confirmPasswordController.text,
                                );
                          },
                        ),
                  const Gap(50),
// ...
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text("Already have an account? "),
                GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => const LoginScreen()),
                    );
                  },
                  child: const Text(
                    'Login Now',
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
