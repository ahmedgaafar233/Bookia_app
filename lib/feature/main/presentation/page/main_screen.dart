import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/utils/app_colors.dart';
import 'package:bookia/core/network/dio_consumer.dart';
import 'package:bookia/feature/home/presentation/page/home_screen.dart';
import 'package:bookia/feature/wishlist/data/repos/wishlist_repo.dart';
import 'package:bookia/feature/wishlist/presentation/cubit/wishlist_cubit.dart';
import 'package:bookia/feature/wishlist/presentation/page/wishlist_screen.dart';
import 'package:bookia/feature/cart/presentation/page/cart_screen.dart';
import 'package:bookia/feature/profile/presentation/page/profile_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  final List<Widget> _screens = [
    const HomeScreen(),
    const WishlistScreen(),
    const CartScreen(),
    const ProfileScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          WishlistCubit(WishlistRepository(DioConsumer()))..getWishlist(),
      child: Scaffold(
        body: _screens[_selectedIndex],
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _selectedIndex,
          onTap: (index) {
            setState(() {
              _selectedIndex = index;
            });
          },
          type: BottomNavigationBarType.fixed,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedItemColor: AppColors.primaryColor,
          unselectedItemColor: AppColors.darkGrey,
          items: [
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppAssets.homeSvg,
                colorFilter: ColorFilter.mode(
                  _selectedIndex == 0
                      ? AppColors.primaryColor
                      : AppColors.darkGrey,
                  BlendMode.srcIn,
                ),
              ),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppAssets.bookmarkSvg,
                colorFilter: ColorFilter.mode(
                  _selectedIndex == 1
                      ? AppColors.primaryColor
                      : AppColors.darkGrey,
                  BlendMode.srcIn,
                ),
              ),
              label: 'Wishlist',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppAssets.categorySvg,
                colorFilter: ColorFilter.mode(
                  _selectedIndex == 2
                      ? AppColors.primaryColor
                      : AppColors.darkGrey,
                  BlendMode.srcIn,
                ),
              ),
              label: 'Cart',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                AppAssets.profileSvg,
                colorFilter: ColorFilter.mode(
                  _selectedIndex == 3
                      ? AppColors.primaryColor
                      : AppColors.darkGrey,
                  BlendMode.srcIn,
                ),
              ),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
