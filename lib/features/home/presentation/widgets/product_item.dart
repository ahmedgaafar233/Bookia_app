import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/routes/app_routes.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/features/home/data/models/product_response_model.dart';
import 'package:bookia/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class ProductItem extends StatelessWidget {
  final Product product;
  const ProductItem({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(AppRoutes.bookDetails, extra: product);
      },
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xfff5f5f5),
          borderRadius: BorderRadius.circular(10.r),
        ),
        padding: EdgeInsets.all(10.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Hero(
                    tag: product.id.toString(),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10.r),
                      child: Image.network(
                        product.image ?? '',
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  Positioned(
                    top: 10.h,
                    right: 10.w,
                    child: GestureDetector(
                      onTap: () {
                        context
                            .read<WishlistCubit>()
                            .addToWishlist(productId: product.id ?? 0);
                      },
                      child: SvgPicture.asset(
                        AppAssets.bookmarkSvg,
                        colorFilter: const ColorFilter.mode(
                          AppColors.white,
                          BlendMode.srcIn,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Gap(10.h),
            Text(
              product.name ?? '',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.secondaryColor,
              ),
            ),
            Gap(5.h),
            Row(
              children: [
                Text(
                  '${product.price} EGP',
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.secondaryColor,
                  ),
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.secondaryColor,
                    foregroundColor: Colors.white,
                    minimumSize: Size(60.w, 30.h),
                    padding: EdgeInsets.zero,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5.r),
                    ),
                  ),
                  child: Text('Buy', style: TextStyle(fontSize: 12.sp)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
