import 'package:car_app/core/utils/constants/assets_helper.dart';
import 'package:car_app/core/utils/constants/primary/primary_field.dart';
import 'package:car_app/core/utils/constants/spacing.dart';
import 'package:car_app/core/utils/cubit/home_cubit.dart';
import 'package:flutter/material.dart';

class SignUpFieldsSection extends StatelessWidget {
  const SignUpFieldsSection({super.key});

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
          label: 'Email/Phone Number',
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
        PrimaryField(
          controller: homeCubit.confirmPasswordController,
          label: 'Confirm Password',
          validator: (value) =>
              value!.isEmpty ? 'Please enter your Confirm Password' : null,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.visiblePassword,
          obscureText: !homeCubit.passwordVisibility['confirmPassword'],
          suffixIcon: IconButton(
            icon: Image.asset(
              homeCubit.passwordVisibility['confirmPassword']
                  ? AssetsHelper.visibility
                  : AssetsHelper.visibilityOff,
              width: 24,
              height: 24,
            ),
            color: Colors.grey,
            onPressed: () {
              homeCubit.togglePasswordVisibility = 'confirmPassword';
            },
          ),
        ),
      ],
    );
  }
}
