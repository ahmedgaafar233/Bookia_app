import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/network/dio_consumer.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/widgets/custom_button.dart';
import 'package:bookia/features/auth/data/repos/auth_repository.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/features/auth/presentation/screens/create_new_password_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String email;
  const OTPVerificationScreen({super.key, required this.email});

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final List<TextEditingController> _controllers = List.generate(4, (_) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(AuthRepository(DioConsumer(Dio()))),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            String code = _controllers.map((e) => e.text).join();
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => CreateNewPasswordScreen(verifyCode: code),
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
                    'OTP Verification',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                  const Gap(10),
                  const Text(
                    "Enter the verification code we just sent on your email address.",
                    style: TextStyle(color: AppColors.darkGrey, fontSize: 16),
                  ),
                  const Gap(32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(4, (index) => _otpBox(_controllers[index])),
                  ),
                  const Gap(35),
                  state is AuthLoading
                      ? const Center(child: CircularProgressIndicator())
                      : CustomButton(
                          text: 'Verify',
                          onPressed: () {
                            String code = _controllers.map((e) => e.text).join();
                            context.read<AuthCubit>().checkCode(widget.email, code);
                          },
                        ),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Didn't receive code? "),
                      GestureDetector(
                        onTap: () {
                          context.read<AuthCubit>().forgetPassword(widget.email);
                        },
                        child: const Text(
                          'Resend',
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

  Widget _otpBox(TextEditingController controller) {
    return Container(
      width: 70,
      height: 60,
      decoration: BoxDecoration(
        color: AppColors.textFieldBackground,
        border: Border.all(color: AppColors.borderColor),
        borderRadius: BorderRadius.circular(8),
      ),
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        keyboardType: TextInputType.number,
        maxLength: 1,
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        decoration: const InputDecoration(
          counterText: '',
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}
