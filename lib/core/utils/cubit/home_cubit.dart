import 'package:car_app/core/models/user_model.dart';
import 'package:car_app/core/network/remote/api_endpoints.dart';
import 'package:car_app/core/network/remote/dio_helper.dart';
import 'package:car_app/core/utils/cubit/home_state.dart';
import 'package:car_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

HomeCubit get homeCubit => HomeCubit.get(navigatorKey.currentContext!);

class HomeCubit extends Cubit<HomeState> {
  HomeCubit() : super(HomeInitialState());

  static HomeCubit get(BuildContext context) => BlocProvider.of(context);
  final loginEmailController = TextEditingController();
  final loginPasswordController = TextEditingController();
  final fullNameController = TextEditingController();
  final signUpEmailController = TextEditingController();
  final signUpPasswordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final forgetPasswordEmailController = TextEditingController();
  final phoneNumberController = TextEditingController();

  Map<String, dynamic> passwordVisibility = {
    'loginPassword': false,
    'signUpPassword': false,
    'confirmPassword': false,
  };

  set togglePasswordVisibility(String type) {
    passwordVisibility[type] = !passwordVisibility[type]!;
    emit(HomeTogglePasswordVisibilityState());
  }

  bool _isRememberMe = false;

  bool get isRememberMe => _isRememberMe;

  set isRememberMe(bool value) {
    _isRememberMe = value;
    emit(HomeToggleRememberMeState());
  }

  void login() async {
    emit(HomeLoginLoadingState());
    final result = await DioHelper.postData(
      url: loginApi,
      data: {
        'email': loginEmailController.text,
        'password': loginPasswordController.text,
      },
    );
    result.fold(
      (l) {
        debugPrint(l);
        emit(HomeLoginErrorState(l));
      },
      (r) {
        final data = r.data;
        if (data['user'] != null) {
          final userModel = UserModel.fromJson(data);
          emit(HomeLoginSuccessState(userModel));
        } else {
          final message = data['errors']?['message'] ?? data['message'];
          emit(HomeLoginErrorState(message));
        }
      },
    );
  }

  // 🔥 OTP Management
  List<String> otpDigits = ["", "", "", ""];

  void addOtpDigit(String digit) {
    for (int i = 0; i < otpDigits.length; i++) {
      if (otpDigits[i].isEmpty) {
        otpDigits[i] = digit;
        break;
      }
    }
    emit(HomeOtpAddedState());
  }

  void removeOtpDigit() {
    for (int i = otpDigits.length - 1; i >= 0; i--) {
      if (otpDigits[i].isNotEmpty) {
        otpDigits[i] = "";
        break;
      }
    }
    emit(HomeOtpRemovedState());
  }

  void clearOtp() {
    otpDigits = ["", "", "", ""];
    emit(HomeOtpClearedState());
  }

  String get otpCode => otpDigits.join();
}
