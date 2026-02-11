import 'package:car_app/core/models/country_model.dart';
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

  final TextEditingController loginEmailController = .new();
  final TextEditingController loginPasswordController = .new();
  final TextEditingController fullNameController = .new();
  final TextEditingController signUpEmailController = .new();
  final TextEditingController signUpPasswordController = .new();
  final TextEditingController forgetPasswordEmailController = .new();
  final TextEditingController phoneNumberController = .new();

  Map<String, dynamic> passwordVisibility = {
    'loginPassword': true,
    'signUpPassword': true,
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

  Future<void> login() async {
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
        debugPrint(l.toString());
        emit(HomeLoginErrorState(l.toString()));
      },
      (r) {
        final data = r.data;
        if (data['user'] != null) {
          final userModel = UserModel.fromJson(data);
          emit(HomeLoginSuccessState(userModel));
        }
      },
    );
  }

  Future<void> signUp() async {
    emit(HomeSignupLoadingState());

    final result = await DioHelper.postData(
      url: signUpApi,
      data: {
        'full_name': fullNameController.text,
        'email': signUpEmailController.text,
        'password': signUpPasswordController.text,
        'country_id': selectedCountryId.toString(),
      },
    );

    result.fold(
      (l) {
        emit(HomeSignupErrorState(l));
      },
      (r) {
        final data = r.data;
        if (data['user'] != null) {
          final userModel = UserModel.fromJson(data);
          emit(HomeSignupSuccessState(userModel));
        }
      },
    );
  }

  int? selectedCountryId;

  List<CountryModel> countries = [];

  Future<void> getCountries() async {
    emit(HomeCountriesLoadingState());
    final result = await DioHelper.getData(url: countriesApi);
    result.fold(
      (l) {
        debugPrint(l.toString());
        emit(HomeCountriesErrorState(l));
      },
      (r) {
        final data = r.data['data'] as List;
        countries = data.map((e) => CountryModel.fromJson(e)).toList();
        emit(HomeCountriesSuccessState());
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
