import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/services/local/shared_prefs.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/feature/details/presentation/widgets/wishlist_action/cubit/wishlist_action_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WishlistIcon extends StatelessWidget {
  final int productId;
  final Color? color;
  const WishlistIcon({super.key, required this.productId, this.color});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistActionCubit, WishlistActionState>(
      builder: (context, state) {
        var cubit = context.read<WishlistActionCubit>();
        bool isInWishlist = cubit.isProductInWishlist(productId);
        
        return CircleAvatar(
          radius: 16.r,
          backgroundColor: Colors.white,
          child: GestureDetector(
            onTap: () {
              cubit.toggleWishlist(productId);
            },
            child: SvgPicture.asset(
              AppAssets.bookmarkSvg,
              width: 16.w,
              height: 16.h,
              colorFilter: ColorFilter.mode(
                isInWishlist ? AppColors.primaryColor : AppColors.secondaryColor,
                BlendMode.srcIn,
              ),
            ),
          ),
        );
      },
    );
  }
}
