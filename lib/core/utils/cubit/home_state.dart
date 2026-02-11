import 'package:car_app/core/models/country_model.dart';
import 'package:car_app/core/models/location_model.dart';
import 'package:car_app/core/models/user_model.dart';

abstract class HomeState {}

class HomeInitialState extends HomeState {}

class HomeTogglePasswordVisibilityState extends HomeState {}

class HomeToggleRememberMeState extends HomeState {}

class HomeLoginLoadingState extends HomeState {}

class HomeLoginSuccessState extends HomeState {
  final UserModel userModel;

  HomeLoginSuccessState(this.userModel);
}

class HomeLoginErrorState extends HomeState {
  final String error;

  HomeLoginErrorState(this.error);
}

class HomeSignupLoadingState extends HomeState {}

class HomeSignupSuccessState extends HomeState {
  final UserModel userModel;

  HomeSignupSuccessState(this.userModel);
}

class HomeSignupErrorState extends HomeState {
  final String error;

  HomeSignupErrorState(this.error);
}

class HomeCountriesLoadingState extends HomeState {}

class HomeCountriesSuccessState extends HomeState {}

class HomeCountriesErrorState extends HomeState {
  final String error;

  HomeCountriesErrorState(this.error);
}

class HomeOtpAddedState extends HomeState {}

class HomeOtpRemovedState extends HomeState {}

class HomeOtpClearedState extends HomeState {}
