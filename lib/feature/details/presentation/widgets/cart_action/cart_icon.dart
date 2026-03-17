import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/core/widgets/main_button.dart';
import 'package:bookia/feature/details/presentation/widgets/cart_action/cubit/cart_action_cubit.dart';
import 'package:bookia/feature/details/presentation/widgets/cart_action/cubit/cart_action_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CartIcon extends StatelessWidget {
  const CartIcon({super.key, required this.id});

  final int id;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CartActionCubit, CartActionState>(
      listener: (context, state) {
        if (state is CartActionSuccessState) {
          Navigator.pop(context); // Close loading
          showMyDialog(context, state.msg, type: DialogType.success);
        } else if (state is CartActionErrorState) {
          Navigator.pop(context); // Close loading
          showMyDialog(context, state.msg, type: DialogType.error);
        } else if (state is CartActionLoadingState) {
          showLoadingDialog(context);
        }
      },
      builder: (context, state) {
        var cubit = context.read<CartActionCubit>();
        bool isInCart = cubit.isProductInCart(id);
        return MainButton(
          bgColor: isInCart ? AppColors.primaryColor : AppColors.darkColor,
          minWidth: 200,
          text: isInCart ? 'Added to cart' : 'Add to cart',
          onPressed: () {
            if (!isInCart) {
              cubit.addToCart(id);
            }
          },
        );
      },
    );
  }
}
