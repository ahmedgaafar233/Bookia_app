import 'package:bookia/core/routes/app_routes.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/core/widgets/custom_button.dart';
import 'package:go_router/go_router.dart';
import 'package:bookia/feature/cart/presentation/cubit/cart_cubit.dart';
import 'package:bookia/feature/cart/presentation/widgets/cart_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartBooks extends StatelessWidget {
  const CartBooks({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartCubit, CartState>(
      listener: (context, state) {
        var cubit = context.read<CartCubit>();
        if (state is CheckoutLoadingState) {
          showLoadingDialog(context);
        } else if (state is CheckoutSuccessState) {
          Navigator.pop(context); // Close loading
          context.push(AppRoutes.checkout, extra: cubit.total); // Updated to use AppRoutes
        } else if (state is CheckoutErrorState) {
          Navigator.pop(context); // Close loading
          showErrorDialog(context, 'Failed to checkout. Please try again.');
        }
      },
      builder: (context, state) {
        var cubit = context.read<CartCubit>();
        if (state is GetCartLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else {
          if (cubit.products.isEmpty) {
            return const Center(child: Text('No items in cart'));
          }
          return Column(
            children: [
              Expanded(
                child: ListView.separated(
                  padding: const EdgeInsets.all(20),
                  itemCount: cubit.products.length,
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 15),
                  itemBuilder: (context, index) {
                    return CartItemWidget(
                      item: cubit.products[index],
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        const Spacer(),
                        Text(
                          'Total: \$${cubit.total}',
                          style: TextStyles.title.copyWith(fontSize: 20),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      text: 'Checkout',
                      onPressed: () {
                        cubit.checkout();
                      },
                    ),
                  ],
                ),
              ),
            ],
          );
        }
      },
    );
  }
}
