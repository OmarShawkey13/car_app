import 'package:car_app/core/theme/colors.dart';
import 'package:car_app/core/theme/text_styles.dart';
import 'package:car_app/core/utils/constants/primary/primary_button.dart';
import 'package:car_app/core/utils/constants/routes.dart';
import 'package:car_app/core/utils/constants/spacing.dart';
import 'package:car_app/core/utils/cubit/home_cubit.dart';
import 'package:car_app/core/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';

class LoginAuthButtons extends StatelessWidget {
  final GlobalKey<FormState> formKey;

  const LoginAuthButtons({super.key, required this.formKey});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PrimaryButton(
          padding: 0,
          label: Text('Login', style: TextStylesManager.bold16),
          onPressed: () {
            if (formKey.currentState!.validate()) {
              homeCubit.login();
            }
          },
        ),
        verticalSpace10,
        PrimaryButton(
          padding: 0,
          withBorder: true,
          color: ColorsManager.secondaryColor,
          textColor: ColorsManager.textColor,
          onPressed: () {
            context.push<Widget>(Routes.signUpRoute);
          },
          label: Text('Sign Up', style: TextStylesManager.bold16),
        ),
      ],
    );
  }
}
