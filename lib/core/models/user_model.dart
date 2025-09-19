import 'package:car_app/core/models/country_model.dart';
import 'package:car_app/core/models/location_model.dart';
import 'package:car_app/core/models/tokens_model.dart';

class UserModel {
  final String message;
  final int id;
  final String fullName;
  final String email;
  final String phone;
  final bool phoneIsVerified;
  final CountryModel country;
  final LocationModel location;
  final TokensModel tokens;

  UserModel({
    required this.message,
    required this.id,
    required this.fullName,
    required this.email,
    required this.phone,
    required this.phoneIsVerified,
    required this.country,
    required this.location,
    required this.tokens,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      message: json['message'],
      id: json['user']['id'],
      fullName: json['user']['full_name'],
      email: json['user']['email'],
      phone: json['user']['phone'],
      phoneIsVerified: json['user']['phone_is_verified'],
      country: CountryModel.fromJson(json['user']['country']),
      location: LocationModel.fromJson(json['user']['location']),
      tokens: TokensModel.fromJson(json['tokens']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "message": message,
      "user": {
        "id": id,
        "full_name": fullName,
        "email": email,
        "phone": phone,
        "phone_is_verified": phoneIsVerified,
        "country": country.toJson(),
        "location": location.toJson(),
      },
      "tokens": tokens.toJson(),
    };
  }
}
