import 'package:bookia/core/di/service_locator.dart';


import 'package:bookia/feature/cart/presentation/cubit/cart_cubit.dart';
import 'package:bookia/feature/cart/presentation/widgets/cart_books.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<CartCubit>()..getCart(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Cart'),
        ),
        body: const CartBooks(),
      ),
    );
  }
}
