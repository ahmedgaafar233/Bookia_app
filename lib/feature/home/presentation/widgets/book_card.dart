import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/feature/home/data/models/product_response_model.dart';
import 'package:bookia/feature/home/presentation/widgets/wishlist_icon.dart';
import 'package:bookia/core/routes/app_routes.dart';
import 'package:bookia/core/functions/navigation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:gap/gap.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookia/feature/wishlist/presentation/cubit/wishlist_cubit.dart';

class BookCard extends StatelessWidget {
  final Product product;
  final bool isWishlist;
  final VoidCallback? onRefresh;

  const BookCard({
    super.key,
    required this.product,
    this.isWishlist = false,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        push(context, AppRoutes.bookDetails, extra: product).then((value) {
          onRefresh?.call();
        });
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
                      child: CachedNetworkImage(
                        imageUrl: product.image ?? '',
                        width: double.infinity,
                        fit: BoxFit.cover,
                        placeholder: (context, url) => const Center(
                          child: CircularProgressIndicator(
                            color: AppColors.primaryColor,
                          ),
                        ),
                        errorWidget: (context, url, error) =>
                            const Icon(Icons.error),
                      ),
                    ),
                  ),
                  if (!isWishlist)
                    Positioned(
                      top: 10.h,
                      right: 10.w,
                      child: WishlistIcon(productId: product.id ?? 0),
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
                if (isWishlist)
                  IconButton(
                    onPressed: () {
                      context.read<WishlistCubit>().removeFromWishlist(productId: product.id ?? 0);
                    },
                    icon: const Icon(Icons.cancel_outlined, color: AppColors.secondaryColor),
                  )
                else
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
