import 'package:bookia/core/di/service_locator.dart';

import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/utils/app_colors.dart';

import 'package:bookia/feature/details/presentation/widgets/cart_action/cart_icon.dart';
import 'package:bookia/feature/details/presentation/widgets/cart_action/cubit/cart_action_cubit.dart';
import 'package:bookia/feature/details/presentation/widgets/wishlist_action/cubit/wishlist_action_cubit.dart';
import 'package:bookia/feature/details/presentation/widgets/wishlist_action/wishlist_icon.dart';
import 'package:bookia/feature/home/data/models/product_response_model.dart';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:gap/gap.dart';
import 'package:go_router/go_router.dart';

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({super.key, required this.product});

  final Product product;

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<CartActionCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<WishlistActionCubit>(),
        ),
      ],
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Row(
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
              WishlistIcon(productId: product.id ?? 0),
            ],
          ),
        ),
        body: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              const Gap(30),
              Hero(
                tag: product.id.toString(),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: CachedNetworkImage(
                    imageUrl: product.image ?? '',
                    width: 183.w,
                    height: 271.h,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const Gap(25),
              Text(
                product.name ?? '',
                style: TextStyles.title.copyWith(fontSize: 24),
                textAlign: TextAlign.center,
              ),
              const Gap(10),
              Text(
                '',
                style: TextStyles.body.copyWith(color: AppColors.primaryColor),
              ),
              const Gap(20),
              Text(
                (product.description ?? '').replaceAll(RegExp(r'<[^>]*>|&[^;]+;'), ''),
                style: TextStyles.body.copyWith(color: Colors.grey),
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Row(
            children: [
              Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (product.priceAfterDiscount != null &&
                      product.priceAfterDiscount != product.price &&
                      product.priceAfterDiscount != 'null')
                    Text(
                      '${product.price} \$',
                      style: TextStyles.body.copyWith(
                        fontSize: 14.sp,
                        color: Colors.grey,
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                  Text(
                    '${(product.priceAfterDiscount != null && product.priceAfterDiscount != 'null') ? product.priceAfterDiscount : product.price} \$',
                    style: TextStyles.title.copyWith(fontSize: 20.sp),
                  ),
                ],
              ),
              const Spacer(),
              CartIcon(id: product.id ?? 0),
            ],
          ),
        ),
      ),
    );
  }
}
