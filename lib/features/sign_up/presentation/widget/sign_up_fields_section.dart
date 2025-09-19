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
    homeCubit.loadData();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          current is HomeLoadDataSuccessState ||
          current is HomeCountriesSuccessState ||
          current is HomeCountriesErrorState ||
          current is HomeCountriesLoadingState ||
          current is HomeLocationsSuccessState ||
          current is HomeLocationsErrorState ||
          current is HomeLocationsLoadingState,
      builder: (context, state) {
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
              controller: homeCubit.signUpPhoneNumberController,
              label: 'Phone Number',
              validator: (value) =>
                  value!.isEmpty ? 'Please enter your phone number' : null,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.phone,
            ),
            verticalSpace20,
            PrimaryField(
              controller: homeCubit.signUpPasswordController,
              label: 'Password',
              validator: (value) =>
                  value!.isEmpty ? 'Please enter your password' : null,
              textInputAction: TextInputAction.done,
              keyboardType: TextInputType.visiblePassword,
              obscureText: !homeCubit.passwordVisibility['signUpPassword'],
              suffixIcon: IconButton(
                icon: Image.asset(
                  homeCubit.passwordVisibility['signUpPassword']
                      ? AssetsHelper.visibility
                      : AssetsHelper.visibilityOff,
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
            state is HomeCountriesLoadingState
                ? const Center(child: CircularProgressIndicator())
                : DropdownButtonFormField<int>(
                    initialValue: homeCubit.selectedCountryId,
                    decoration: InputDecoration(
                      label: const Text("Select Country"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          12,
                        ), // نفس الراديوس بتاع الـ PrimaryField
                      ),
                    ),
                    items: homeCubit.countries.map((c) {
                      return DropdownMenuItem<int>(
                        value: c.id,
                        child: Text(c.country),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        homeCubit.selectedCountryId = value;
                      });
                    },
                    validator: (value) =>
                        value == null ? "Please select a country" : null,
                  ),
            verticalSpace20,
            state is HomeLocationsLoadingState
                ? const Center(child: CircularProgressIndicator())
                : DropdownButtonFormField<int>(
                    initialValue: homeCubit.selectedLocationId,
                    decoration: InputDecoration(
                      label: const Text("Select Location"),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          12,
                        ),
                      ),
                    ),
                    items: homeCubit.locations.map((l) {
                      return DropdownMenuItem<int>(
                        value: l.id,
                        child: Text(l.name),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() {
                        homeCubit.selectedLocationId = value;
                      });
                    },
                    validator: (value) =>
                        value == null ? "Please select a location" : null,
                  ),
          ],
        );
      },
    );
  }
}
