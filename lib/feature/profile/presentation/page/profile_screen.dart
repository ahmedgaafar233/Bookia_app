import 'package:bookia/core/di/service_locator.dart';
import 'package:bookia/core/constants/app_assets.dart';

import 'package:bookia/core/routes/app_routes.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/widgets/custom_button.dart';

import 'package:bookia/feature/profile/presentation/cubit/profile_cubit.dart';
import 'package:bookia/feature/profile/presentation/cubit/profile_state.dart';
import 'package:bookia/feature/auth/presentation/cubit/auth_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<ProfileCubit>()..getProfile(),
        ),
        BlocProvider(
          create: (context) => sl<AuthCubit>(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text('Profile', style: TextStyles.title),
          actions: [
            BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthSuccess) {
                    context.go(AppRoutes.welcome);
                  } else if (state is AuthError) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
                  }
                },
                builder: (context, state) {
                  return IconButton(
                    onPressed: () {
                      context.read<AuthCubit>().logout();
                    },
                    icon: state is AuthLoading
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : SvgPicture.asset(AppAssets.logoutSvg),
                  );
                },
              ),
            Gap(10.w),
          ],
        ),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          buildWhen: (previous, current) => current is GetProfileLoading || current is GetProfileSuccess || current is GetProfileError,
          builder: (context, state) {
            if (state is GetProfileLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GetProfileSuccess) {
              final user = state.user;
              return SingleChildScrollView(
                padding: EdgeInsets.symmetric(horizontal: 20.w),
                child: Column(
                  children: [
                    Gap(20.h),
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 40.r,
                          backgroundImage: user.image != null
                              ? NetworkImage(user.image!)
                              : const AssetImage(AppAssets.profilePng) as ImageProvider,
                        ),
                        Gap(20.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(user.name ?? '', style: TextStyles.title.copyWith(fontSize: 20.sp)),
                              Text(user.email ?? '', style: TextStyles.body.copyWith(color: AppColors.darkGrey)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Gap(30.h),
                    _ProfileTile(
                      title: 'My Orders',
                      onTap: () => context.push(AppRoutes.myOrders),
                    ),
                    _ProfileTile(
                      title: 'Edit Profile',
                      onTap: () => context.push(AppRoutes.editProfile),
                    ),
                    _ProfileTile(
                      title: 'Update Password',
                      onTap: () => context.push(AppRoutes.resetPasswordPage),
                    ),
                    _ProfileTile(
                      title: 'FAQ',
                      onTap: () => context.push(AppRoutes.faqs),
                    ),
                    _ProfileTile(
                      title: 'Contact Us',
                      onTap: () => context.push(AppRoutes.contactUs),
                    ),
                    _ProfileTile(
                      title: 'Privacy & Terms',
                      onTap: () => context.push(AppRoutes.privacyTerms),
                    ),
                  ],
                ),
              );
            } else {
              return Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Session expired. Please log in again.', style: TextStyles.body),
                    Gap(20.h),
                    CustomButton(
                      text: 'Login Again',
                      width: 200.w,
                      onPressed: () {
                        context.read<AuthCubit>().logout();
                      },
                    ),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final String title;
  final VoidCallback onTap;

  const _ProfileTile({required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 15.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: ListTile(
        title: Text(title, style: TextStyles.body.copyWith(fontWeight: FontWeight.bold)),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.secondaryColor),
        onTap: onTap,
      ),
    );
  }
}
