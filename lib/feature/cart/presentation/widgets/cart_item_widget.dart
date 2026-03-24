import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/feature/cart/data/models/cart_response/cart_item.dart';
import 'package:bookia/feature/cart/presentation/cubit/cart_cubit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';

class CartItemWidget extends StatelessWidget {
  final CartItem item;
  const CartItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xfff5f5f5),
        borderRadius: BorderRadius.circular(10.r),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(10.r),
            child: CachedNetworkImage(
              imageUrl: item.itemProductImage ?? '',
              width: 100.w, // Matching redline dimension
              height: 118.h, // Matching redline dimension
              fit: BoxFit.cover,
            ),
          ),
          Gap(15.w),
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 10.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          item.itemProductName ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.secondaryColor,
                          ),
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          // Removed redundant onRemove callback if it was there before
                          context
                              .read<CartCubit>()
                              .removeFromCart(cartItemId: item.itemId ?? 0);
                        },
                        icon: Icon(Icons.delete_outline_rounded,
                            color: Colors.red, size: 24.sp),
                      ),
                    ],
                  ),
                  Gap(5.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${item.itemProductPriceAfterDiscount} EGP',
                        style: TextStyle(
                          fontSize: 14.sp,
                          fontWeight: FontWeight.bold,
                          color: AppColors.primaryColor,
                        ),
                      ),
                      Row(
                        children: [
                          _buildQuantityButton(
                            icon: Icons.remove,
                            onTap: () {
                              if ((item.itemQuantity ?? 0) > 1) {
                                context.read<CartCubit>().updateCart(
                                      cartItemId: item.itemId ?? 0,
                                      quantity: (item.itemQuantity ?? 0) - 1,
                                    );
                              }
                            },
                          ),
                          Gap(10.w),
                          Text(
                            '${item.itemQuantity}',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Gap(10.w),
                          _buildQuantityButton(
                            icon: Icons.add,
                            onTap: () {
                              context.read<CartCubit>().updateCart(
                                    cartItemId: item.itemId ?? 0,
                                    quantity: (item.itemQuantity ?? 0) + 1,
                                  );
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuantityButton({
    required IconData icon,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.all(5.w),
        decoration: BoxDecoration(
          color: AppColors.white,
          borderRadius: BorderRadius.circular(5.r),
          border: Border.all(color: AppColors.borderColor),
        ),
        child: Icon(icon, size: 15.sp, color: AppColors.secondaryColor),
      ),
    );
  }
}
