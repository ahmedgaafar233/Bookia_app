import 'package:bookia/core/network/dio_consumer.dart';
import 'package:bookia/feature/cart/data/repos/cart_repo.dart';
import 'package:bookia/feature/cart/presentation/cubit/cart_cubit.dart';
import 'package:bookia/feature/cart/presentation/widgets/cart_books.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit(CartRepository(DioConsumer()))..getCart(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('My Cart'),
        ),
        body: const CartBooks(),
      ),
    );
  }
}
