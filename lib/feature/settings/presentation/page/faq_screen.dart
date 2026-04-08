import 'package:bookia/core/di/service_locator.dart';
import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/functions/navigation.dart';

import 'package:bookia/core/styles/text_styles.dart';

import 'package:bookia/feature/settings/presentation/cubit/settings_cubit.dart';
import 'package:bookia/feature/settings/presentation/cubit/settings_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SettingsCubit>()..getFaqs(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => pop(context),
            icon: SvgPicture.asset(AppAssets.backSvg),
          ),
          title: Text('FAQ', style: TextStyles.title),
        ),
        body: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            if (state is SettingsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SettingsFaqsLoaded) {
              final faqs = state.faqs['data'] as List? ?? [];
              if (faqs.isEmpty) {
                return const Center(child: Text('No FAQs found.'));
              }
              return ListView.builder(
                padding: const EdgeInsets.all(20),
                itemCount: faqs.length,
                itemBuilder: (context, index) {
                  final faq = faqs[index];
                  return ExpansionTile(
                    title: Text(faq['question'] ?? 'Question', style: TextStyles.body.copyWith(fontWeight: FontWeight.bold)),
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Text(faq['answer'] ?? 'Answer', style: TextStyles.body),
                      ),
                    ],
                  );
                },
              );
            } else if (state is SettingsError) {
              return Center(child: Text('Failed to load FAQs: ${state.message}'));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
