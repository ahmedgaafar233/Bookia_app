import 'package:bookia/features/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:bookia/core/widgets/product_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WishlistBooks extends StatelessWidget {
  const WishlistBooks({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<WishlistCubit, WishlistState>(
      builder: (context, state) {
        var products = context.read<WishlistCubit>().wishlistModel?.data?.products;
        if (state is GetWishlistLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        return ProductGridView(
          products: products ?? [],
          isWishlist: true,
          onRefresh: () {
            context.read<WishlistCubit>().getWishlist();
          },
        );
      },
    );
  }
}
