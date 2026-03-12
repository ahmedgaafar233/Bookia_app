import 'package:bookia/core/network/dio_consumer.dart';
import 'package:bookia/core/routes/app_routes.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/widgets/custom_button.dart';
import 'package:bookia/features/auth/data/repos/auth_repository.dart';
import 'package:bookia/features/auth/presentation/cubit/auth_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class OTPVerificationScreen extends StatefulWidget {
  final String email;
  const OTPVerificationScreen({super.key, required this.email});

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final List<TextEditingController> _controllers = List.generate(6, (_) => TextEditingController());

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AuthCubit(AuthRepository(DioConsumer())),
      child: BlocConsumer<AuthCubit, AuthState>(
        listener: (context, state) {
          if (state is AuthSuccess) {
            String code = _controllers.map((e) => e.text).join();
            context.push(AppRoutes.createPassword, extra: code);
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
                    'OTP Verification',
                    style: TextStyle(
                      fontSize: 30.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.secondaryColor,
                    ),
                  ),
                   Gap(10.h),
                   Text(
                    "Enter the verification code we just sent on your email address.",
                    style: TextStyle(color: AppColors.darkGrey, fontSize: 16.sp),
                  ),
                   Gap(32.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: List.generate(6, (index) => _otpBox(_controllers[index])),
                  ),
                   Gap(35.h),
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
                       Text("Didn't receive code? ", style: TextStyle(fontSize: 15.sp)),
                      GestureDetector(
                        onTap: () {
                          context.read<AuthCubit>().forgetPassword(widget.email);
                        },
                        child:  Text(
                          'Resend',
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

  Widget _otpBox(TextEditingController controller) {
    return Container(
      width: 48.w,
      height: 60.h,
      decoration: BoxDecoration(
        color: AppColors.white,
        border: Border.all(color: AppColors.borderColor),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: TextField(
        controller: controller,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 22.sp, fontWeight: FontWeight.bold),
        keyboardType: TextInputType.number,
        maxLength: 1,
        onChanged: (value) {
          if (value.length == 1) {
            FocusScope.of(context).nextFocus();
          }
        },
        decoration: const InputDecoration(
          filled: false,
          counterText: '',
          border: InputBorder.none,
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
        ),
      ),
    );
  }
}
