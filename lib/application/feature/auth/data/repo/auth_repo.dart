import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:smart_sport_club/core/local/shared_pref.dart';

import 'package:smart_sport_club/core/services/apis/apis.dart';
import 'package:smart_sport_club/core/services/apis/dio_provider.dart';
import 'package:smart_sport_club/application/feature/auth/data/model/params/auth_login_params.dart';
import 'package:smart_sport_club/application/feature/auth/data/model/object_response/auth_login_response..dart';
import 'package:smart_sport_club/application/feature/auth/data/model/object_response/auth_register_response.dart';
import 'package:smart_sport_club/application/feature/auth/data/model/params/auth_register_params.dart';

class AuthRepo {
  static Future<({AuthRegisterResponse? response, String? error})> register(
    AuthRegisterParams params,
  ) async {
    try {
      log("Register Request Data: ${params.toJson()}");
      var request = await DioProvider.post(
        path: Apis.register,
        data: params.toJson(),
      );
      if (request.statusCode == 200) {
        return (
          response: AuthRegisterResponse.fromJson(request.data),
          error: null,
        );
      } else {
        return (response: null, error: "Something went wrong");
      }
    } on DioException catch (e) {
      log("Dio Error: ${e.response?.statusCode}");
      log("Error Response Body: ${e.response?.data}");

      String errorMessage = "An error occurred";
      if (e.response?.data != null && e.response?.data is Map) {
        final data = e.response?.data as Map;
        if (data.containsKey('errors')) {
          final errors = data['errors'] as Map;
          errorMessage = errors.values.first[0].toString();
        } else if (data.containsKey('message')) {
          errorMessage = data['message'].toString();
        }
      }

      return (response: null, error: errorMessage);
    } catch (e) {
      log("General Error: ${e.toString()}");
      return (response: null, error: e.toString());
    }
  }

  static Future<({AuthLoginResponse? response, String? error})> login(
    AuthLoginParams params,
  ) async {
    try {
      var request = await DioProvider.post(
        path: Apis.login,
        data: params.toJson(),
      );
      if (request.statusCode == 200) {
        var data = AuthLoginResponse.fromJson(request.data);
        SharedPref.setToken(data.token);
        return (response: data, error: null);
      } else {
        return (response: null, error: "Something went wrong");
      }
    } on DioException catch (e) {
      log("Dio Error: ${e.response?.statusCode}");
      log("Error Response Body: ${e.response?.data}");

      String errorMessage = "An error occurred";
      if (e.response?.data != null && e.response?.data is Map) {
        final data = e.response?.data as Map;
        if (data.containsKey('errors')) {
          final errors = data['errors'] as Map;
          errorMessage = errors.values.first[0].toString();
        } else if (data.containsKey('message')) {
          errorMessage = data['message'].toString();
        }
      }

      return (response: null, error: errorMessage);
    } catch (e) {
      log("General Error: ${e.toString()}");
      return (response: null, error: e.toString());
    }
  }
}
