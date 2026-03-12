import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/features/home/presentation/cubit/home_cubit.dart';
import 'package:bookia/features/home/presentation/widgets/best_seller_shimmer.dart';
import 'package:bookia/features/home/presentation/widgets/product_item.dart';
import 'package:conditional_builder_null_safety/conditional_builder_null_safety.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class BestSellerBooks extends StatelessWidget {
  const BestSellerBooks({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          current is GetBestSellerLoading ||
          current is GetBestSellerSuccess ||
          current is GetBestSellerError,
      builder: (context, state) {
        var cubit = context.read<HomeCubit>();
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 22.w),
              child: Text(
                'Best Seller',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.secondaryColor,
                ),
              ),
            ),
            Gap(15.h),
            ConditionalBuilder(
              condition: state is! GetBestSellerLoading,
              builder: (context) {
                var products = cubit.productResponseModel?.data?.products;
                if (products == null || products.isEmpty) {
                  return const Center(child: Text('No Products Found'));
                }
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.symmetric(horizontal: 22.w),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 10.h,
                    crossAxisSpacing: 10.w,
                    childAspectRatio: 0.6,
                  ),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return ProductItem(product: products[index]);
                  },
                );
              },
              fallback: (context) => const BestSellerShimmer(),
            ),
          ],
        );
      },
    );
  }
}
