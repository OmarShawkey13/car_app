import 'package:car_app/core/theme/colors.dart';
import 'package:car_app/core/theme/text_styles.dart';
import 'package:car_app/core/utils/constants/primary/primary_app_bar.dart';
import 'package:car_app/core/utils/constants/primary/primary_button.dart';
import 'package:car_app/core/utils/constants/routes.dart';
import 'package:car_app/core/utils/constants/spacing.dart';
import 'package:car_app/core/utils/cubit/home_cubit.dart';
import 'package:car_app/core/utils/cubit/home_state.dart';
import 'package:car_app/core/utils/extensions/context_extension.dart';
import 'package:car_app/features/sign_up/presentation/widget/sign_up_fields_section.dart';
import 'package:car_app/features/sign_up/presentation/widget/sign_up_social_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  SignUpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      listener: (BuildContext context, HomeState state) {
        if (state is HomeSignupSuccessState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.userModel.message)),
          );
        }
        if (state is HomeSignupErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(state.error)),
          );
        }
      },
      buildWhen: (previous, current) =>
          current is HomeSignupSuccessState ||
          current is HomeSignupErrorState ||
          current is HomeSignupLoadingState,
      builder: (BuildContext context, HomeState state) {
        return Scaffold(
          appBar: const PrimaryAppBar(),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    verticalSpace20,
                    Text(
                      'Sign Up',
                      style: TextStylesManager.semibold30,
                    ),
                    verticalSpace40,
                    const SignUpFieldsSection(),
                    verticalSpace20,
                    PrimaryButton(
                      padding: 0,
                      label: Text('Sign Up', style: TextStylesManager.bold16),
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          homeCubit.signUp();
                        }
                      },
                    ),
                    verticalSpace20,
                    Row(
                      spacing: 15,
                      children: [
                        Expanded(
                          child: Divider(
                            color: Colors.grey.withValues(alpha: 0.5),
                            thickness: 1.15,
                          ),
                        ),
                        const Text('Or'),
                        Expanded(
                          child: Divider(
                            color: Colors.grey.withValues(alpha: 0.5),
                            thickness: 1.15,
                          ),
                        ),
                      ],
                    ),
                    verticalSpace20,
                    const SignUpSocialButtons(),
                    verticalSpace20,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Already have an account?',
                          style: TextStylesManager.regular14.copyWith(
                            color: ColorsManager.primaryColor,
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                          ),
                          onPressed: () {
                            context.push<Widget>(Routes.loginRoute);
                          },
                          child: Text(
                            'Login',
                            style: TextStylesManager.regular14.copyWith(
                              color: ColorsManager.primaryColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
