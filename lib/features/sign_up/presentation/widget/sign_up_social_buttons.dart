import 'package:car_app/core/theme/colors.dart';
import 'package:car_app/core/theme/text_styles.dart';
import 'package:car_app/core/utils/constants/assets_helper.dart';
import 'package:car_app/core/utils/constants/primary/primary_button.dart';
import 'package:car_app/core/utils/constants/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpSocialButtons extends StatelessWidget {
  const SignUpSocialButtons({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PrimaryButton(
          padding: 0,
          label: Text('Apple Pay', style: TextStylesManager.bold16),
          icon: SvgPicture.asset(AssetsHelper.applePay),
          color: ColorsManager.secondaryColor,
          textColor: ColorsManager.textColor,
          withBorder: true,
          onPressed: () {},
        ),
        verticalSpace20,
        PrimaryButton(
          padding: 0,
          label: Text('Google Pay', style: TextStylesManager.bold16),
          icon: SvgPicture.asset(AssetsHelper.googlePay),
          color: ColorsManager.secondaryColor,
          textColor: ColorsManager.textColor,
          withBorder: true,
          onPressed: () {},
        ),
      ],
    );
  }
}
