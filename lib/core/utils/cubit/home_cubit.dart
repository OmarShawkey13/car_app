import 'package:car_app/core/models/country_model.dart';
import 'package:car_app/core/models/location_model.dart';
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
  final signUpPhoneNumberController = TextEditingController();
  final signUpPasswordController = TextEditingController();
  final forgetPasswordEmailController = TextEditingController();
  final phoneNumberController = TextEditingController();

  Map<String, dynamic> passwordVisibility = {
    'loginPassword': false,
    'signUpPassword': false,
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

  void signUp() async {
    emit(HomeSignupLoadingState());

    final result = await DioHelper.postData(
      url: signUpApi,
      data: {
        'full_name': fullNameController.text,
        'email': signUpEmailController.text,
        'phone': signUpPhoneNumberController.text,
        'password': signUpPasswordController.text,
        'country_id': selectedCountryId.toString(),
        'location_id': selectedLocationId.toString(),
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
        } else {
          final message =
              data['errors']?['email'] ??
              data['errors']?['phone'] ??
              data['message'];
          emit(HomeSignupErrorState(message));
        }
      },
    );
  }

  bool isLoading = false;

  void loadData() async {
    if (isLoading) return;
    getCountries();
    getLocations();
    isLoading = true;
    emit(HomeLoadDataSuccessState());
  }

  int? selectedCountryId;
  int? selectedLocationId;

  List<CountryModel> countries = [];
  List<LocationModel> locations = [];

  void getCountries() async {
    emit(HomeCountriesLoadingState());
    final result = await DioHelper.getData(url: countriesApi);
    result.fold(
      (l) {
        emit(HomeCountriesErrorState(l));
      },
      (r) {
        final data = r.data['data'] as List;
        countries = data.map((e) => CountryModel.fromJson(e)).toList();
        emit(HomeCountriesSuccessState(countries));
      },
    );
  }

  void getLocations() async {
    emit(HomeLocationsLoadingState());
    final result = await DioHelper.getData(url: locationsApi);
    result.fold(
      (l) {
        emit(HomeLocationsErrorState(l));
      },
      (r) {
        final data = r.data['data'] as List;
        locations = data.map((e) => LocationModel.fromJson(e)).toList();
        emit(HomeLocationsSuccessState(locations));
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
