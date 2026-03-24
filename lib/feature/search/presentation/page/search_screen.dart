import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/functions/navigation.dart';
import 'package:bookia/core/network/dio_consumer.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/custom_text_field.dart';
import 'package:bookia/feature/home/presentation/widgets/book_card.dart';
import 'package:bookia/feature/search/data/repos/search_repo.dart';
import 'package:bookia/feature/search/presentation/cubit/search_cubit.dart';
import 'package:bookia/feature/search/presentation/cubit/search_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SearchCubit(SearchRepository(DioConsumer())),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => pop(context),
            icon: SvgPicture.asset(AppAssets.backSvg),
          ),
          title: Text('Search', style: TextStyles.title),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            children: [
              Gap(20.h),
              BlocBuilder<SearchCubit, SearchState>(
                builder: (context, state) {
                  return CustomTextField(
                    hintText: 'Search for books...',
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: SvgPicture.asset(AppAssets.searchNormal),
                    ),
                    onChanged: (value) {
                      context.read<SearchCubit>().search(value);
                    },
                  );
                },
              ),
              Gap(20.h),
              Expanded(
                child: BlocBuilder<SearchCubit, SearchState>(
                  builder: (context, state) {
                    if (state is SearchLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is SearchSuccess) {
                      if (state.products.isEmpty) {
                        return const Center(child: Text('No books found.'));
                      }
                      return GridView.builder(
                        itemCount: state.products.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                          childAspectRatio: 0.65,
                        ),
                        itemBuilder: (context, index) {
                          return BookCard(product: state.products[index]);
                        },
                      );
                    } else if (state is SearchError) {
                      return Center(child: Text(state.message));
                    } else {
                      return const Center(
                        child: Text('Start searching for your favorite books!'),
                      );
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
