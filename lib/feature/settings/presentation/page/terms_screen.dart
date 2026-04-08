import 'package:bookia/core/di/service_locator.dart';
import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/functions/navigation.dart';

import 'package:bookia/core/styles/text_styles.dart';

import 'package:bookia/feature/settings/presentation/cubit/settings_cubit.dart';
import 'package:bookia/feature/settings/presentation/cubit/settings_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class PrivacyTermsScreen extends StatelessWidget {
  const PrivacyTermsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SettingsCubit>()..getSettings(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => pop(context),
            icon: SvgPicture.asset(AppAssets.backSvg),
          ),
          title: Text('Privacy & Terms', style: TextStyles.title),
        ),
        body: BlocBuilder<SettingsCubit, SettingsState>(
          builder: (context, state) {
            if (state is SettingsLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is SettingsSettingsLoaded) {
              final settings = state.settings['data'];
              final terms = settings?['terms'] ?? 'Terms not available.';
              final about = settings?['about'] ?? '';
              return SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (about.isNotEmpty) ...[
                      Text('About Us', style: TextStyles.title),
                      const SizedBox(height: 10),
                      Text(about, style: TextStyles.body),
                      const SizedBox(height: 20),
                    ],
                    Text('Privacy & Terms', style: TextStyles.title),
                    const SizedBox(height: 10),
                    Text(terms, style: TextStyles.body),
                  ],
                ),
              );
            } else if (state is SettingsError) {
              return Center(child: Text('Failed to load settings: ${state.message}'));
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
