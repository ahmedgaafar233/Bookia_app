import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/functions/navigation.dart';
import 'package:bookia/core/routes/app_routes.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';

class CheckoutSuccessScreen extends StatelessWidget {
  const CheckoutSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(22),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(AppAssets.congrats, width: 200),
            const Gap(30),
            Text(
              'SUCCESS!',
              style: TextStyles.title.copyWith(
                fontSize: 30,
              ),
            ),
            const Gap(10),
            Text(
              'Your order will be delivered soon.\nThank you for choosing our app!',
              textAlign: TextAlign.center,
              style: TextStyles.body.copyWith(
                color: Colors.grey,
              ),
            ),
            const Gap(40),
            CustomButton(
              text: 'Back To Home',
              onPressed: () => pushAndRemoveUntil(context, AppRoutes.main),
            ),
          ],
        ),
      ),
    );
  }
}
