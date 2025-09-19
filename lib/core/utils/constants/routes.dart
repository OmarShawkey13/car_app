import 'package:car_app/features/forget_password/presentation/screen/forget_password_screen.dart';
import 'package:car_app/features/home/presentation/screen/home_screen.dart';
import 'package:car_app/features/login/presentation/screen/login_screen.dart';
import 'package:car_app/features/on_boarding/presentation/screen/on_boarding_screen.dart';
import 'package:car_app/features/otp/presentation/screen/otp_screen.dart';
import 'package:car_app/features/sign_up/presentation/screen/sign_up_screen.dart';
import 'package:car_app/features/verify_email/presentation/screen/verify_email_screen.dart';
import 'package:flutter/material.dart';

class Routes {
  static const String onBoardingRoute = '/on_boarding';
  static const String loginRoute = '/login';
  static const String signUpRoute = '/sign_up';
  static const String homeRoute = '/home';
  static const String forgetPasswordRoute = '/forget_password';
  static const String verifyEmailRoute = '/verify_email';
  static const String otpRoute = '/otp';

  static Map<String, WidgetBuilder> get routes => {
    onBoardingRoute: (context) => const OnBoardingScreen(),
    loginRoute: (context) => LoginScreen(),
    homeRoute: (context) => const HomeScreen(),
    signUpRoute: (context) => SignUpScreen(),
    forgetPasswordRoute: (context) => ForgetPasswordScreen(),
    verifyEmailRoute: (context) => const VerifyEmailScreen(),
    otpRoute: (context) => const OtpScreen(),
  };
}
