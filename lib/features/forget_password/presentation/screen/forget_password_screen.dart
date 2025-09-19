import 'package:car_app/core/theme/colors.dart';
import 'package:car_app/core/theme/text_styles.dart';
import 'package:car_app/core/utils/constants/primary/primary_app_bar.dart';
import 'package:car_app/core/utils/constants/primary/primary_button.dart';
import 'package:car_app/core/utils/constants/primary/primary_field.dart';
import 'package:car_app/core/utils/constants/routes.dart';
import 'package:car_app/core/utils/constants/spacing.dart';
import 'package:car_app/core/utils/cubit/home_cubit.dart';
import 'package:car_app/core/utils/cubit/home_state.dart';
import 'package:car_app/core/utils/extensions/context_extension.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ForgetPasswordScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (BuildContext context, HomeState state) {
        return Scaffold(
          appBar: const PrimaryAppBar(),
          body: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Reset your password',
                        style: TextStylesManager.semibold30,
                      ),
                      verticalSpace10,
                      Text(
                        'Enter the email address associated with your account and\nwe\'ll send you a link to reset your password.',
                        style: TextStylesManager.regular14.copyWith(
                          color: ColorsManager.textColor.withValues(alpha: 0.5),
                        ),
                        textAlign: TextAlign.center,
                      ),
                      verticalSpace20,
                      PrimaryField(
                        controller: homeCubit.forgetPasswordEmailController,
                        label: 'Email',
                        validator: (value) =>
                            value!.isEmpty ? 'Please enter your email' : null,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.emailAddress,
                      ),
                      verticalSpace20,
                      PrimaryButton(
                        padding: 0,
                        label: Text(
                          'Continue',
                          style: TextStylesManager.bold20,
                        ),
                        onPressed: () {
                          context.push<Widget>(Routes.verifyEmailRoute);
                        },
                      ),
                      verticalSpace10,
                      TextButton(
                        onPressed: () {
                          context.pop;
                        },
                        child: Text(
                          'Return To Login',
                          style: TextStylesManager.regular14.copyWith(
                            color: ColorsManager.primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Create a ', style: TextStylesManager.regular14),
                    TextButton(
                      onPressed: () {
                        context.push<Widget>(Routes.signUpRoute);
                      },
                      style: TextButton.styleFrom(padding: EdgeInsets.zero),
                      child: Text(
                        'New Account',
                        style: TextStylesManager.bold14.copyWith(
                          color: ColorsManager.primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
