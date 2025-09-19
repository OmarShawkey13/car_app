import 'package:car_app/core/theme/colors.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  final VoidCallback onPressed;
  final Widget? icon;
  final Widget label;
  final bool withBorder;
  final double padding;
  final Color color;
  final Color textColor;
  final Color borderColor;

  const PrimaryButton({
    super.key,
    required this.onPressed,
    this.icon,
    required this.label,
    this.withBorder = false,
    this.padding = 16,
    this.color = ColorsManager.buttonColor,
    this.textColor = ColorsManager.whiteColor,
    this.borderColor = ColorsManager.blackColor,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: padding),
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: icon,
        label: label,
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(double.infinity, 56),
          backgroundColor: color,
          foregroundColor: textColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(65),
            side: withBorder
                ? BorderSide(
                    color: borderColor,
                    width: 1,
                  )
                : BorderSide.none,
          ),
        ),
      ),
    );
  }
}
