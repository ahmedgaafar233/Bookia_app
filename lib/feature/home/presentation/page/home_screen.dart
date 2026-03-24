import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/routes/app_routes.dart';
import 'package:bookia/core/network/dio_consumer.dart';
import 'package:bookia/feature/home/data/repos/home_repo.dart';
import 'package:bookia/feature/home/presentation/cubit/home_cubit.dart';
import 'package:bookia/feature/home/presentation/widgets/best_seller_books.dart';
import 'package:bookia/feature/home/presentation/widgets/home_banner.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(HomeRepository(DioConsumer()))
        ..getSliders()
        ..getBestSeller(),
      child: Scaffold(
        appBar: AppBar(
          title: Row(
            children: [
              Image.asset(AppAssets.logo, height: 30.h),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () {
                context.push(AppRoutes.search);
              },
              icon: SvgPicture.asset(AppAssets.searchNormal),
            ),
            Gap(10.w),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Gap(20.h),
              HomeBanner(),
              Gap(30.h),
              BestSellerBooks(),
              Gap(20.h),
            ],
          ),
        ),
      ),
    );
  }
}
