import 'package:bookia/core/di/service_locator.dart';
import 'package:bookia/core/constants/app_assets.dart';
import 'package:bookia/core/functions/navigation.dart';

import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/custom_button.dart';
import 'package:bookia/core/widgets/custom_text_field.dart';

import 'package:bookia/feature/settings/presentation/cubit/settings_cubit.dart';
import 'package:bookia/feature/settings/presentation/cubit/settings_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';

class ContactUsScreen extends StatefulWidget {
  const ContactUsScreen({super.key});

  @override
  State<ContactUsScreen> createState() => _ContactUsScreenState();
}

class _ContactUsScreenState extends State<ContactUsScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _subjectController = TextEditingController();
  final _messageController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<SettingsCubit>(),
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            onPressed: () => pop(context),
            icon: SvgPicture.asset(AppAssets.backSvg),
          ),
          title: Text('Contact Us', style: TextStyles.title),
        ),
        body: BlocConsumer<SettingsCubit, SettingsState>(
          listener: (context, state) {
            if (state is SettingsContactUsSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
              pop(context);
            } else if (state is SettingsError) {
              ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.message)));
            }
          },
          builder: (context, state) {
            return SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20.w, vertical: 20.h),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    CustomTextField(
                      hintText: 'Name',
                      controller: _nameController,
                      validator: (v) => v!.isEmpty ? 'Enter your name' : null,
                    ),
                    Gap(15.h),
                    CustomTextField(
                      hintText: 'Email',
                      controller: _emailController,
                      validator: (v) => v!.isEmpty ? 'Enter your email' : null,
                    ),
                    Gap(15.h),
                    CustomTextField(
                      hintText: 'Phone',
                      controller: _phoneController,
                      validator: (v) => v!.isEmpty ? 'Enter your phone' : null,
                    ),
                    Gap(15.h),
                    CustomTextField(
                      hintText: 'Subject',
                      controller: _subjectController,
                      validator: (v) => v!.isEmpty ? 'Enter subject' : null,
                    ),
                    Gap(15.h),
                    CustomTextField(
                      hintText: 'Message',
                      controller: _messageController,
                      maxLines: 4,
                      validator: (v) => v!.isEmpty ? 'Enter message' : null,
                    ),
                    Gap(30.h),
                    state is SettingsLoading
                        ? const CircularProgressIndicator()
                        : CustomButton(
                            text: 'Send Message',
                            onPressed: () {
                              if (_formKey.currentState!.validate()) {
                                context.read<SettingsCubit>().contactUs(
                                  name: _nameController.text,
                                  email: _emailController.text,
                                  phone: _phoneController.text,
                                  subject: _subjectController.text,
                                  message: _messageController.text,
                                );
                              }
                            },
                          ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
