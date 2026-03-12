import 'package:bookia/core/services/local/shared_prefs.dart';
import 'package:bookia/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/widgets/custom_button.dart';
import 'package:bookia/features/home/data/models/product_response_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class BookDetailsScreen extends StatelessWidget {
  final Product product;
  const BookDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Padding(
          padding: EdgeInsets.symmetric(horizontal: 10.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
              BlocBuilder<WishlistCubit, WishlistState>(
                buildWhen: (previous, current) =>
                    current is GetWishlistSuccess ||
                    current is AddToWishlistSuccess ||
                    current is RemoveFromWishlistSuccess,
                builder: (context, state) {
                  bool isInWishlist = SharedPrefs.getWishlistIds()
                      .contains(product.id.toString());
                  return Container(
                    width: 41.w,
                    height: 41.h,
                    decoration: BoxDecoration(
                      border: Border.all(color: AppColors.borderColor),
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    child: IconButton(
                      onPressed: () {
                        if (isInWishlist) {
                          context
                              .read<WishlistCubit>()
                              .removeFromWishlist(productId: product.id ?? 0);
                        } else {
                          context
                              .read<WishlistCubit>()
                              .addToWishlist(productId: product.id ?? 0);
                        }
                      },
                      icon: SvgPicture.asset(
                        AppAssets.bookmarkSvg,
                        width: 24.w,
                        height: 24.h,
                        colorFilter: ColorFilter.mode(
                          isInWishlist
                              ? AppColors.primaryColor
                              : AppColors.secondaryColor,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
      body: BlocListener<WishlistCubit, WishlistState>(
        listener: (context, state) {
          if (state is AddToWishlistSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Added to wishlist successfully'),
                backgroundColor: AppColors.primaryColor,
              ),
            );
          } else if (state is RemoveFromWishlistSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Removed from wishlist successfully'),
                backgroundColor: Colors.red,
              ),
            );
          } else if (state is AddToWishlistError ||
              state is RemoveFromWishlistError) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Something went wrong'),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              Gap(30.h),
              Center(
                child: Hero(
                  tag: product.id.toString(),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(12.r),
                    child: Image.network(
                      product.image ?? '',
                      width: 183.w,
                      height: 271.h,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              Gap(25.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 22.w),
                child: Column(
                  children: [
                    Text(
                      product.name ?? 'No Name',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondaryColor,
                      ),
                    ),
                    Gap(12.h),
                    Text(
                      'Description',
                      style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.secondaryColor,
                      ),
                    ),
                    Gap(10.h),
                    Text(
                      product.description ?? 'No Description available',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppColors.darkGrey,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
              Gap(30.h),
            ],
          ),
        ),
      ),
      bottomNavigationBar: Container(
        height: 100.h,
        padding: EdgeInsets.symmetric(horizontal: 22.w, vertical: 15.h),
        decoration: BoxDecoration(
          color: AppColors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.05),
              blurRadius: 10,
              offset: const Offset(0, -5),
            ),
          ],
        ),
        child: Row(
          children: [
            Text(
              '${product.price} EGP',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.secondaryColor,
              ),
            ),
            const Spacer(),
            CustomButton(
              text: 'Add to cart',
              width: 212.w,
              height: 56.h,
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}
