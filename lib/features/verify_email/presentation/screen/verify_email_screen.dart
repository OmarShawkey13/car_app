import 'package:car_app/core/theme/colors.dart';
import 'package:car_app/core/theme/text_styles.dart';
import 'package:car_app/core/utils/constants/assets_helper.dart';
import 'package:car_app/core/utils/constants/primary/primary_app_bar.dart';
import 'package:car_app/core/utils/constants/primary/primary_button.dart';
import 'package:car_app/core/utils/constants/primary/primary_field.dart';
import 'package:car_app/core/utils/constants/routes.dart';
import 'package:car_app/core/utils/constants/spacing.dart';
import 'package:car_app/core/utils/cubit/home_cubit.dart';
import 'package:car_app/core/utils/cubit/home_state.dart';
import 'package:car_app/core/utils/extensions/context_extension.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class VerifyEmailScreen extends StatelessWidget {
  const VerifyEmailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (BuildContext context, HomeState state) {
        return Scaffold(
          appBar: const PrimaryAppBar(),
          body: Padding(
            padding: const EdgeInsets.all(24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Verify your phone number',
                  style: TextStylesManager.semibold30,
                ),
                verticalSpace10,
                Text(
                  'We have sent you an SMS with a code to number',
                  style: TextStylesManager.regular14.copyWith(
                    color: ColorsManager.textColor.withValues(alpha: 0.5),
                  ),
                  textAlign: TextAlign.center,
                ),
                verticalSpace30,
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade400),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  alignment: Alignment.centerLeft,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CountryCodePicker(
                        initialSelection: 'EG',
                        favorite: const ['+20', 'EG'],
                        showCountryOnly: false,
                        showOnlyCountryWhenClosed: false,
                        padding: EdgeInsets.zero,
                        alignLeft: false,
                        onChanged: (value) {
                          homeCubit.phoneNumberController.text =
                              value.dialCode ?? '';
                        },
                      ),
                      SvgPicture.asset(
                        AssetsHelper.upDown,
                        width: 24,
                        height: 24,
                      ),
                    ],
                  ),
                ),
                verticalSpace12,
                PrimaryField(
                  controller: homeCubit.phoneNumberController,
                  label: 'Phone Number',
                  validator: (value) =>
                      value!.isEmpty ? 'Please enter your phone number' : null,
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.phone,
                ),
                verticalSpace24,
                PrimaryButton(
                  onPressed: () {
                    context.push<Widget>(Routes.otpRoute);
                  },
                  padding: 0,
                  label: Text(
                    'Continue',
                    style: TextStylesManager.semibold16,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
