import 'package:car_app/core/theme/colors.dart';
import 'package:car_app/core/theme/text_styles.dart';
import 'package:car_app/core/utils/constants/assets_helper.dart';
import 'package:car_app/core/utils/constants/spacing.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class OnBoardingPageItem extends StatelessWidget {
  final String title;
  final String description;

  const OnBoardingPageItem({
    super.key,
    required this.title,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SvgPicture.asset(AssetsHelper.carLogoWhite),
          verticalSpace20,
          Text(
            title,
            style: TextStylesManager.bold40.copyWith(
              color: ColorsManager.whiteColor,
            ),
            textAlign: TextAlign.start,
          ),
          const Spacer(),
          Text(
            description,
            style: TextStylesManager.regular14.copyWith(
              color: ColorsManager.whiteColor,
            ),
            textAlign: TextAlign.start,
          ),
          verticalSpace30,
        ],
      ),
    );
  }
}
