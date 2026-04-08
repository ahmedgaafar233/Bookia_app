import 'package:bookia/core/di/service_locator.dart';
import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/functions/navigation.dart';

import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/custom_button.dart';
import 'package:bookia/core/widgets/custom_text_field.dart';
import 'package:bookia/core/utils/app_colors.dart';

import 'package:bookia/feature/profile/presentation/cubit/profile_cubit.dart';
import 'package:bookia/feature/profile/presentation/cubit/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<ProfileCubit>()..getProfile(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => pop(context),
            icon: SvgPicture.asset(AppAssets.backSvg),
          ),
          title: Text('Edit Profile', style: TextStyles.title),
        ),
        body: BlocConsumer<ProfileCubit, ProfileState>(
          listener: (context, state) {
            if (state is GetProfileSuccess) {
              _nameController.text = state.user.name ?? '';
              _phoneController.text = state.user.phone ?? '';
              _addressController.text = state.user.address ?? '';
            } else if (state is UpdateProfileSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Profile updated successfully!')),
              );
              pop(context);
            } else if (state is UpdateProfileError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            if (state is GetProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            }
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 22.w),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    Gap(30.h),
                    Center(
                      child: Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            radius: 40.r,
                            backgroundImage: const AssetImage(AppAssets.profilePng),
                          ),
                          Container(
                            padding: const EdgeInsets.all(4),
                            decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              color: AppColors.secondaryColor,
                            ),
                            child: Icon(Icons.camera_alt, size: 14.r, color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                    Gap(30.h),
                    CustomTextField(
                      hintText: 'Full Name',
                      controller: _nameController,
                      validator: (value) => value!.isEmpty ? 'Enter your name' : null,
                    ),
                    Gap(15.h),
                    CustomTextField(
                      hintText: 'Phone Number',
                      controller: _phoneController,
                      validator: (value) => value!.isEmpty ? 'Enter your phone' : null,
                    ),
                    Gap(15.h),
                    CustomTextField(
                      hintText: 'Address',
                      controller: _addressController,
                      validator: (value) => value!.isEmpty ? 'Enter your address' : null,
                    ),
                    Gap(40.h),
                    state is UpdateProfileLoading
                        ? const CircularProgressIndicator()
                        : CustomButton(
                            text: 'Update Profile',
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<ProfileCubit>().updateProfile(
                                      name: _nameController.text,
                                      phone: _phoneController.text,
                                      address: _addressController.text,
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
