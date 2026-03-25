import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/feature/place_order/data/models/governorate.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class GovernorateBottomSheet extends StatelessWidget {
  const GovernorateBottomSheet({
    super.key,
    required this.governorates,
    required this.onSelected,
  });

  final List<GovernorateData> governorates;
  final void Function(GovernorateData) onSelected;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      height: 450, // Added fixed height to prevent expanded layout errors and keep it half-screen
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          const Gap(16),
          Text('Select Governorate', style: TextStyles.title),
          const Gap(16),
          Expanded(
            child: ListView.separated(
              itemCount: governorates.length,
              separatorBuilder: (context, index) => const Divider(height: 1),
              itemBuilder: (context, index) {
                final governorate = governorates[index];
                return ListTile(
                  title: Text(governorate.governorateNameEn ?? '',
                      style: TextStyles.body),
                  onTap: () {
                    onSelected(governorate);
                    Navigator.pop(context);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
