import 'package:car_app/core/theme/colors.dart';
import 'package:car_app/core/theme/text_styles.dart';
import 'package:car_app/core/utils/constants/primary/primary_app_bar.dart';
import 'package:car_app/core/utils/constants/routes.dart';
import 'package:car_app/core/utils/constants/spacing.dart';
import 'package:car_app/core/utils/cubit/home_cubit.dart';
import 'package:car_app/core/utils/cubit/home_state.dart';
import 'package:car_app/core/utils/extensions/context_extension.dart';
import 'package:car_app/features/login/presentation/widget/login_auth_buttons.dart';
import 'package:car_app/features/login/presentation/widget/login_fields_section.dart';
import 'package:car_app/features/login/presentation/widget/login_social_buttons.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginScreen extends StatelessWidget {
  final formKey = GlobalKey<FormState>();

  LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeCubit, HomeState>(
      buildWhen: (previous, current) =>
          current is HomeTogglePasswordVisibilityState ||
          current is HomeToggleRememberMeState ||
          current is HomeLoginLoadingState ||
          current is HomeLoginSuccessState ||
          current is HomeLoginErrorState,
      listener: (BuildContext context, HomeState state) {
        if (state is HomeLoginSuccessState) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(
            SnackBar(
              content: Text(
                state.userModel.message,
              ),
            ),
          );
        }
        if (state is HomeLoginErrorState) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(
            SnackBar(
              content: Text(
                state.error,
              ),
            ),
          );
        }
      },
      builder: (BuildContext context, HomeState state) {
        return Scaffold(
          appBar: const PrimaryAppBar(),
          body: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpace20,
                    Text(
                      'Welcome Back\nReady to hit the road.',
                      style: TextStylesManager.semibold30,
                    ),
                    verticalSpace40,
                    const LoginFieldsSection(),
                    verticalSpace20,
                    LoginAuthButtons(
                      formKey: formKey,
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
                    const LoginSocialButtons(),
                    verticalSpace30,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Don\'t have an account?',
                          style: TextStylesManager.regular14.copyWith(
                            color: ColorsManager.primaryColor,
                          ),
                        ),
                        TextButton(
                          style: TextButton.styleFrom(
                            padding: EdgeInsets.zero,
                          ),
                          onPressed: () {
                            context.push<Widget>(Routes.signUpRoute);
                          },
                          child: Text(
                            'Sign Up',
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
