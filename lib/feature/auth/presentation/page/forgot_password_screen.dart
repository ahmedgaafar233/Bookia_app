import 'package:bookia/core/network/dio_consumer.dart';
import 'package:bookia/core/routes/app_routes.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/widgets/custom_button.dart';
import 'package:bookia/core/widgets/custom_text_field.dart';
import 'package:bookia/feature/auth/data/repos/auth_repository.dart';
import 'package:bookia/feature/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

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
      create: (context) => AuthCubit(AuthRepository(DioConsumer())),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            context.push(AppRoutes.otpVerification, extra: _emailController.text);
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
                        onPressed: () => context.pop(),
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
                    'Forgot Password?',
                    style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                   Gap(10.h),
                   Text(
                    "Don't worry! It occurs. Please enter the email address linked with your account.",
                    style: TextStyle(color: AppColors.darkGrey, fontSize: 16.sp),
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
                   Gap(35.h),
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
                       Text("Remember Password? ", style: TextStyle(fontSize: 15.sp)),
                      GestureDetector(
                        onTap: () => context.pop(),
                        child:  Text(
                          'Login',
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
}
