import 'package:bookia/feature/home/data/models/product_response_model.dart';
import 'package:bookia/feature/home/presentation/widgets/book_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductGridView extends StatelessWidget {
  final List<Product> products;
  final bool isWishlist;
  final VoidCallback? onRefresh;

  const ProductGridView({
    super.key,
    required this.products,
    this.isWishlist = false,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
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
        return BookCard(
          product: products[index],
          isWishlist: isWishlist,
          onRefresh: onRefresh,
        );
      },
    );
  }
}
