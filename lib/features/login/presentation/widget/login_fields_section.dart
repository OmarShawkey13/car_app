import 'package:car_app/core/theme/colors.dart';
import 'package:car_app/core/theme/text_styles.dart';
import 'package:car_app/core/utils/constants/assets_helper.dart';
import 'package:car_app/core/utils/constants/primary/primary_field.dart';
import 'package:car_app/core/utils/constants/routes.dart';
import 'package:car_app/core/utils/constants/spacing.dart';
import 'package:car_app/core/utils/cubit/home_cubit.dart';
import 'package:car_app/core/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class LoginFieldsSection extends StatelessWidget {
  const LoginFieldsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        PrimaryField(
          controller: homeCubit.loginEmailController,
          label: 'Email/Phone Number',
          validator: (value) =>
              value!.isEmpty ? 'Please enter your email' : null,
          textInputAction: TextInputAction.next,
          keyboardType: TextInputType.emailAddress,
        ),
        verticalSpace20,
        PrimaryField(
          controller: homeCubit.loginPasswordController,
          label: 'Password',
          validator: (value) =>
              value!.isEmpty ? 'Please enter your password' : null,
          textInputAction: TextInputAction.done,
          keyboardType: TextInputType.visiblePassword,
          obscureText: !homeCubit.passwordVisibility['loginPassword'],
          suffixIcon: IconButton(
            icon: Image.asset(
              homeCubit.passwordVisibility['loginPassword']
                  ? AssetsHelper.visibility
                  : AssetsHelper.visibilityOff,
              width: 24,
              height: 24,
            ),
            color: Colors.grey,
            onPressed: () {
              homeCubit.togglePasswordVisibility = 'loginPassword';
            },
          ),
        ),
        verticalSpace20,
        Row(
          children: [
            Checkbox(
              value: homeCubit.isRememberMe,
              onChanged: (value) {
                homeCubit.isRememberMe = value!;
              },
              checkColor: ColorsManager.whiteColor,
              activeColor: ColorsManager.primaryColor,
            ),
            const Text('Remember me'),
            const Spacer(),
            TextButton(
              onPressed: () {
                context.push<Widget>(Routes.forgetPasswordRoute);
              },
              style: TextButton.styleFrom(padding: EdgeInsets.zero),
              child: Text(
                'Forgot Password',
                style: TextStylesManager.regular14.copyWith(
                  color: ColorsManager.primaryColor,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
