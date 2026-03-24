import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/functions/navigation.dart';
import 'package:bookia/core/network/dio_consumer.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/feature/profile/data/repos/profile_repo.dart';
import 'package:bookia/feature/profile/presentation/cubit/profile_cubit.dart';
import 'package:bookia/feature/profile/presentation/cubit/profile_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProfileCubit(ProfileRepository(DioConsumer()))..getOrderHistory(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => pop(context),
            icon: SvgPicture.asset(AppAssets.backSvg),
          ),
          title: Text('My Orders', style: TextStyles.title),
        ),
        body: BlocBuilder<ProfileCubit, ProfileState>(
          builder: (context, state) {
            if (state is GetOrderHistoryLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is GetOrderHistorySuccess) {
              if (state.orders.isEmpty) {
                return const Center(child: Text('No orders found.'));
              }
              return ListView.builder(
                padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
                itemCount: state.orders.length,
                itemBuilder: (context, index) {
                  final order = state.orders[index];
                  return Container(
                    padding: const EdgeInsets.all(15),
                    margin: EdgeInsets.only(bottom: 15.h),
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.circular(10.r),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(order.orderNumber ?? '', style: TextStyles.title.copyWith(fontSize: 16.sp)),
                            Text(order.date ?? '', style: TextStyles.body.copyWith(color: AppColors.darkGrey)),
                          ],
                        ),
                        const Divider(height: 25),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text('Total Amount: ${order.total} LE', style: TextStyles.body.copyWith(fontWeight: FontWeight.bold)),
                            Container(
                              padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 5.h),
                              decoration: BoxDecoration(
                                color: AppColors.primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(5.r),
                              ),
                              child: Text(
                                order.status ?? '',
                                style: TextStyles.body.copyWith(color: AppColors.primaryColor, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              );
            } else {
              return const Center(child: Text('Failed to load orders.'));
            }
          },
        ),
      ),
    );
  }
}
