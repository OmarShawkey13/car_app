import 'package:car_app/core/theme/colors.dart';
import 'package:car_app/core/theme/text_styles.dart';
import 'package:car_app/core/utils/constants/primary/primary_app_bar.dart';
import 'package:car_app/core/utils/constants/primary/primary_button.dart';
import 'package:car_app/core/utils/constants/spacing.dart';
import 'package:car_app/core/utils/cubit/home_cubit.dart';
import 'package:car_app/core/utils/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (BuildContext context, HomeState state) {
        return Scaffold(
          appBar: const PrimaryAppBar(),
          body: Column(
            children: [
              verticalSpace20,
              Text(
                "Enter verification code",
                style: TextStylesManager.semibold30,
              ),
              verticalSpace10,
              Text(
                "We have sent a Code to : +100******00",
                style: TextStylesManager.regular14,
              ),
              verticalSpace32,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  4,
                  (index) => SizedBox(
                    width: 60,
                    height: 60,
                    child: TextFormField(
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      readOnly: true,
                      controller: TextEditingController(
                        text: homeCubit.otpDigits[index],
                      ),
                      style: TextStylesManager.bold22,
                      maxLength: 1,
                      decoration: InputDecoration(
                        counterText: "",
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              verticalSpace32,
              PrimaryButton(
                onPressed: () {},
                label: Text("Continue", style: TextStylesManager.semibold16),
              ),
              verticalSpace16,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Didn’t receive the OTP? "),
                  GestureDetector(
                    onTap: () {},
                    child: const Text(
                      "Resend",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadiusDirectional.only(
                    topEnd: Radius.circular(12),
                    topStart: Radius.circular(12),
                  ),
                  color: ColorsManager.strokeColor,
                ),
                padding: const EdgeInsets.all(16),
                child: GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1.6,
                    crossAxisSpacing: 12,
                    mainAxisSpacing: 12,
                  ),
                  itemCount: 12,
                  itemBuilder: (context, index) {
                    if (index < 9) {
                      return _buildKey(context, "${index + 1}");
                    } else if (index == 9) {
                      return const SizedBox.shrink();
                    } else if (index == 10) {
                      return _buildKey(context, "0");
                    } else {
                      return _buildKey(context, "⌫", isDelete: true);
                    }
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildKey(
    BuildContext context,
    String label, {
    bool isDelete = false,
  }) {
    final cubit = HomeCubit.get(context);
    return InkWell(
      onTap: () {
        if (isDelete) {
          cubit.removeOtpDigit();
        } else {
          cubit.addOtpDigit(label);
        }
      },
      borderRadius: BorderRadius.circular(12),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          color: isDelete ? Colors.transparent : Colors.white,
          // زر المسح ملوش لون
          border: Border.all(color: Colors.grey.shade400),
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: 20,
              fontWeight: isDelete ? FontWeight.normal : FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
