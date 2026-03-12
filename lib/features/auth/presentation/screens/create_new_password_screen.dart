import 'package:bookia/core/network/dio_consumer.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/widgets/custom_button.dart';
import 'package:bookia/core/widgets/custom_text_field.dart';
import 'package:bookia/features/auth/data/repos/auth_repository.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:bookia/features/auth/presentation/screens/password_changed_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
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
      create: (context) => AuthCubit(AuthRepository(DioConsumer())),
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
            body: Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Gap(30.h),
                   Text(
                    'Create new password',
                    style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                   Gap(10.h),
                   Text(
                    "Your new password must be unique from those previously used.",
                    style: TextStyle(color: AppColors.darkGrey, fontSize: 16.sp),
                  ),
                   Gap(32.h),
                  SizedBox(
                    width: 331.w,
                    height: 56.h,
                    child: CustomTextField(
                      hintText: 'New Password',
                      obscureText: true,
                      controller: _passwordController,
                    ),
                  ),
                   Gap(12.h),
                  SizedBox(
                    width: 331.w,
                    height: 56.h,
                    child: CustomTextField(
                      hintText: 'Confirm Password',
                      obscureText: true,
                      controller: _confirmPasswordController,
                    ),
                  ),
                   Gap(35.h),
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
