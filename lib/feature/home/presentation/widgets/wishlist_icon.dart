import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/services/local/shared_prefs.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/feature/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WishlistIcon extends StatelessWidget {
  final int productId;
  final Color? color;
  const WishlistIcon({super.key, required this.productId, this.color});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistCubit, WishlistState>(
      buildWhen: (previous, current) =>
          current is GetWishlistSuccess ||
          current is AddToWishlistSuccess ||
          current is RemoveFromWishlistSuccess,
      builder: (context, state) {
        bool isInWishlist = SharedPrefs.getWishlistIds()
            .contains(productId);
        return GestureDetector(
          onTap: () {
            if (isInWishlist) {
              context.read<WishlistCubit>().removeFromWishlist(
                  productId: productId);
            } else {
              context.read<WishlistCubit>().addToWishlist(
                  productId: productId);
            }
          },
          child: SvgPicture.asset(
            AppAssets.bookmarkSvg,
            colorFilter: ColorFilter.mode(
              isInWishlist
                  ? AppColors.primaryColor
                  : color ?? AppColors.white,
              BlendMode.srcIn,
            ),
          ),
        );
      },
    );
  }
}
