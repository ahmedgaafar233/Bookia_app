import 'package:bookia/core/functions/navigation.dart';
import 'package:bookia/core/routes/app_routes.dart';
import 'package:bookia/core/styles/text_styles.dart';
import 'package:bookia/core/widgets/custom_text_field.dart';
import 'package:bookia/core/widgets/dialogs.dart';
import 'package:bookia/core/widgets/custom_button.dart';
import 'package:bookia/feature/place_order/data/models/governorate.dart';
import 'package:bookia/feature/place_order/presentation/cubit/place_order_cubit.dart';
import 'package:bookia/feature/place_order/presentation/widgets/gov_bottom_sheet.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';

class PlaceOrderScreen extends StatefulWidget {
  const PlaceOrderScreen({super.key, required this.total});

  final String total;

  @override
  State<PlaceOrderScreen> createState() => _PlaceOrderScreenState();
}

class _PlaceOrderScreenState extends State<PlaceOrderScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _phoneController = TextEditingController();
  final _governorateController = TextEditingController();
  GovernorateData? _selectedGovernorate;

  @override
  void initState() {
    super.initState();
    context.read<PlaceOrderCubit>().getGovernorates();
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _governorateController.dispose();
    super.dispose();
  }

  void _showGovernorateBottomSheet() {
    final cubit = context.read<PlaceOrderCubit>();
    if (cubit.governorates.isNotEmpty) {
      showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => GovernorateBottomSheet(
          governorates: cubit.governorates,
          onSelected: (selectedGov) {
            setState(() {
              _selectedGovernorate = selectedGov;
              _governorateController.text =
                  selectedGov.governorateNameEn ?? '';
            });
          },
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Place Your Order'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocConsumer<PlaceOrderCubit, PlaceOrderState>(
        listener: (context, state) {
          if (state is PlaceOrderLoadingState) {
            showLoadingDialog(context);
          } else if (state is PlaceOrderSuccessState) {
            Navigator.pop(context); // Close loading
            pushAndRemoveUntil(context, AppRoutes.checkoutSuccess);
          } else if (state is PlaceOrderErrorState) {
            Navigator.pop(context); // Close loading
            showErrorDialog(context, 'Failed to place order. Please try again.');
          }
        },
        builder: (context, state) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(20),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Don't worry! It occurs. Please enter the email address linked with your account.",
                    style: TextStyles.body.copyWith(color: Colors.grey),
                  ),
                  const Gap(30),
                  CustomTextField(
                    hintText: 'Full Name',
                    controller: _nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your name';
                      }
                      return null;
                    },
                  ),
                  const Gap(16),
                  CustomTextField(
                    hintText: 'Email',
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      return null;
                    },
                  ),
                  const Gap(16),
                  CustomTextField(
                    hintText: 'Address',
                    controller: _addressController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your address';
                      }
                      return null;
                    },
                  ),
                  const Gap(16),
                  CustomTextField(
                    hintText: 'Phone',
                    controller: _phoneController,
                    keyboardType: TextInputType.phone,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your phone number';
                      }
                      return null;
                    },
                  ),
                  const Gap(16),
                  CustomTextField(
                    hintText: 'Governorate',
                    controller: _governorateController,
                    readOnly: true,
                    onTap: _showGovernorateBottomSheet,
                    prefixIcon: const Icon(Icons.arrow_drop_down),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please select a governorate';
                      }
                      return null;
                    },
                  ),
                  const Gap(40),
                  Row(
                    children: [
                      Text('Total:', style: TextStyles.title),
                      const Spacer(),
                      Text('\$ ${widget.total}', style: TextStyles.title),
                    ],
                  ),
                  const Gap(20),
                  CustomButton(
                    text: 'Submit Order',
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        context.read<PlaceOrderCubit>().placeOrder(
                              name: _nameController.text,
                              email: _emailController.text,
                              address: _addressController.text,
                              phone: _phoneController.text,
                              governorateId: _selectedGovernorate?.id ?? 0,
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
    );
  }
}
