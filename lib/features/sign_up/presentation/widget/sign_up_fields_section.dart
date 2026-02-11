import 'package:car_app/core/utils/constants/assets_helper.dart';
import 'package:car_app/core/utils/constants/primary/primary_field.dart';
import 'package:car_app/core/utils/constants/spacing.dart';
import 'package:car_app/core/utils/cubit/home_cubit.dart';
import 'package:car_app/core/utils/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpFieldsSection extends StatefulWidget {
  const SignUpFieldsSection({super.key});

  @override
  State<SignUpFieldsSection> createState() => _SignUpFieldsSectionState();
}

class _SignUpFieldsSectionState extends State<SignUpFieldsSection> {
  @override
  void initState() {
    super.initState();
    homeCubit.getCountries();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PrimaryField(
          controller: homeCubit.fullNameController,
          label: 'Full Name',
          validator: (value) =>
              value!.isEmpty ? 'Please enter your name' : null,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.name,
        ),
        verticalSpace20,
        PrimaryField(
          controller: homeCubit.signUpEmailController,
          label: 'Email',
          validator: (value) =>
              value!.isEmpty ? 'Please enter your email' : null,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
        ),
        verticalSpace20,
        PrimaryField(
          controller: homeCubit.signUpPasswordController,
          label: 'Password',
          validator: (value) =>
              value!.isEmpty ? 'Please enter your password' : null,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.visiblePassword,
          obscureText: homeCubit.passwordVisibility['signUpPassword'],
          suffixIcon: IconButton(
            icon: Image.asset(
              homeCubit.passwordVisibility['signUpPassword']
                  ? AssetsHelper.visibilityOff
                  : AssetsHelper.visibility,
              width: 24,
              height: 24,
            ),
            color: Colors.grey,
            onPressed: () {
              homeCubit.togglePasswordVisibility = 'signUpPassword';
            },
          ),
        ),
        verticalSpace20,
        BlocBuilder<HomeCubit, HomeState>(
          buildWhen: (previous, current) =>
              current is HomeCountriesSuccessState ||
              current is HomeCountriesErrorState ||
              current is HomeCountriesLoadingState,
          builder: (context, state) {
            if (state is HomeCountriesLoadingState) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            return DropdownButtonFormField<int>(
              initialValue: homeCubit.selectedCountryId,
              decoration: InputDecoration(
                label: const Text("Select Country"),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              items: homeCubit.countries.map((c) {
                return DropdownMenuItem<int>(
                  value: c.id,
                  child: Text(c.country),
                );
              }).toList(),
              onChanged: (value) {
                  homeCubit.selectedCountryId = value;
              },
              validator: (value) =>
                  value == null ? "Please select a country" : null,
            );
          },
        ),
      ],
    );
  }
}
