import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/feature/details/presentation/widgets/wishlist_action/cubit/wishlist_action_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WishlistIcon extends StatelessWidget {
  const WishlistIcon({super.key, required this.productId});

  final int productId;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<WishlistActionCubit, WishlistActionState>(
      listener: (context, state) {
        if (state is WishlistActionSuccessState) {
          showSuccessDialog(context, state.msg);
        } else if (state is WishlistActionErrorState) {
          showErrorDialog(context, state.msg);
        }
      },
      builder: (context, state) {
        var cubit = context.read<WishlistActionCubit>();
        bool isWishlisted = cubit.isProductInWishlist(productId);
        return IconButton(
          onPressed: () => cubit.toggleWishlist(productId),
          icon: Icon(
            isWishlisted ? Icons.bookmark : Icons.bookmark_border_outlined,
            color: isWishlisted ? AppColors.primaryColor : AppColors.secondaryColor,
            size: 24.sp,
          ),
        );
      },
    );
  }
}
