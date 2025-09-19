import 'package:dartz/dartz.dart';
import 'package:car_app/core/di/injections.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class DioHelper {
  static Dio get dio => sl<Dio>();

  static Future<Either<String, Response>> getData({
    required String url,
    Map<String, dynamic>? query,
    String? token,
  }) async {
    try {
      final Response response = await dio.get(
        url,
        queryParameters: query,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            if (token != null) 'Authorization': 'Bearer $token',
          },
        ),
      );
      return Right(response);
    } on DioException catch (error) {
      return Left(
        error.response?.data['message'] ??
            'something went wrong, please try again later',
      );
    } catch (e) {
      debugPrint('DioHelper.get error: $e');
      return const Left('something went wrong, please try again later');
    }
  }

  static Future<Either<String, Response>> postData({
    required String url,
    required dynamic data,
    String? token,
  }) async {
    try {
      final Response response = await dio.post(
        url,
        data: data,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
            if (token != null) 'Authorization': 'Bearer $token',
          },
        ),
      );
      return Right(response);
    } on DioException catch (error) {
      String message = 'something went wrong, please try again later';
      if (error.response?.data is Map &&
          error.response?.data['message'] != null) {
        message = error.response?.data['message'];
      } else if (error.response?.data is String) {
        message = error.response?.data;
      }
      return Left(message);
    } catch (e) {
      debugPrint('DioHelper.post error: $e');
      return const Left('something went wrong, please try again later');
    }
  }
}
