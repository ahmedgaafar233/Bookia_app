import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/functions/navigation.dart';
import 'package:bookia/core/network/dio_consumer.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/custom_button.dart';
import 'package:bookia/core/widgets/custom_text_field.dart';
import 'package:bookia/feature/profile/data/repos/profile_repo.dart';
import 'package:bookia/feature/profile/presentation/cubit/profile_cubit.dart';
import 'package:bookia/feature/profile/presentation/cubit/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({super.key});

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _currentPasswordController = TextEditingController();
  final _newPasswordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(ProfileRepository(DioConsumer())),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => pop(context),
            icon: SvgPicture.asset(AppAssets.backSvg),
          ),
          title: Text('Update Password', style: TextStyles.title),
        ),
        body: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is ResetPasswordSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Password reset successfully!')),
              );
              pop(context);
            } else if (state is ResetPasswordError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 22.w),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Gap(30.h),
                    CustomTextField(
                      hintText: 'Current Password',
                      controller: _currentPasswordController,
                      obscureText: true,
                      validator: (value) => value!.isEmpty ? 'Enter current password' : null,
                    ),
                    Gap(15.h),
                    CustomTextField(
                      hintText: 'New Password',
                      controller: _newPasswordController,
                      obscureText: true,
                      validator: (value) => value!.isEmpty ? 'Enter new password' : null,
                    ),
                    Gap(15.h),
                    CustomTextField(
                      hintText: 'Confirm New Password',
                      controller: _confirmPasswordController,
                      obscureText: true,
                      validator: (value) {
                        if (value!.isEmpty) return 'Confirm your password';
                        if (value != _newPasswordController.text) return 'Passwords do not match';
                        return null;
                      },
                    ),
                    Gap(40.h),
                    state is ResetPasswordLoading
                        ? const CircularProgressIndicator()
                        : CustomButton(
                            text: 'Update Password',
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<ProfileCubit>().resetPassword(
                                      currentPassword: _currentPasswordController.text,
                                      newPassword: _newPasswordController.text,
                                      newPasswordConfirmation: _confirmPasswordController.text,
                                    );
                              }
                            },
                          ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
