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
  static Future<void> _saveAuthSession({
    required String source,
    String? userId,
    String? firstName,
    String? lastName,
    String? token,
    String? refreshToken,
    String? membershipId,
    String? fallbackFullName,
  }) async {
    final fullName = "${firstName ?? ''} ${lastName ?? ''}".trim();
    final userName = fullName.isNotEmpty ? fullName : fallbackFullName?.trim();

    log("=== AUTH CACHE LOG ($source) ===");
    log("User ID: ${userId ?? ''}");
    log("Membership ID: ${membershipId ?? ''}");

    await SharedPref.setToken(token);
    if (token != null && token.isNotEmpty) {
      log("Token Saved");
    }

    await SharedPref.setRefreshToken(refreshToken);
    if (refreshToken != null && refreshToken.isNotEmpty) {
      log("Refresh Token Saved");
    }

    await SharedPref.setMembershipId(membershipId);

    if (userName != null && userName.isNotEmpty) {
      log("Saving username to cache from ${source.toLowerCase()}: '$userName'");
      await SharedPref.setUserName(userName);
    }
  }

  static Future<({AuthRegisterResponse? response, String? error})> register(
    AuthRegisterParams params,
  ) async {
    try {
      log("Register Request Data: ${params.toJson()}");
      var request = await DioProvider.post(
        path: Apis.register,
        data: params.toJson(),
      );
      if (request.statusCode != null &&
          request.statusCode! >= 200 &&
          request.statusCode! < 300) {
        final data = AuthRegisterResponse.fromJson(request.data);
        await _saveAuthSession(
          source: "REGISTER",
          userId: data.id,
          firstName: data.firstName,
          lastName: data.lastName,
          token: data.token,
          refreshToken: data.refreshToken,
          membershipId: data.membershipId,
          fallbackFullName: params.fullName,
        );

        return (response: data, error: null);
      } else {
        return (response: null, error: "Something went wrong");
      }
    } on DioException catch (e) {
      log("Dio Error Type: ${e.type}");
      log("Dio Error Message: ${e.message}");
      log("Dio Error Detail: ${e.error}");
      log("Dio Error: ${e.response?.statusCode}");
      log("Error Response Body: ${e.response?.data}");

      String errorMessage = "An error occurred";
      if (e.response?.data != null && e.response?.data is Map) {
        final data = e.response?.data as Map;
        if (data.containsKey('errors')) {
          final errors = data['errors'];
          if (errors is List) {
            if (errors.isNotEmpty) {
              errorMessage = errors.first.toString();
            }
          } else if (errors is Map) {
            if (errors.values.isNotEmpty) {
              final firstVal = errors.values.first;
              if (firstVal is List && firstVal.isNotEmpty) {
                errorMessage = firstVal.first.toString();
              } else {
                errorMessage = firstVal.toString();
              }
            }
          } else {
            errorMessage = errors.toString();
          }
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
      if (request.statusCode != null &&
          request.statusCode! >= 200 &&
          request.statusCode! < 300) {
        final data = AuthLoginResponse.fromJson(request.data);
        await _saveAuthSession(
          source: "LOGIN",
          userId: data.id,
          firstName: data.firstName,
          lastName: data.lastName,
          token: data.token,
          refreshToken: data.refreshToken,
          membershipId: data.membershipId,
        );

        return (response: data, error: null);
      } else {
        return (response: null, error: "Something went wrong");
      }
    } on DioException catch (e) {
      log("Dio Error Type: ${e.type}");
      log("Dio Error Message: ${e.message}");
      log("Dio Error Detail: ${e.error}");
      log("Dio Error: ${e.response?.statusCode}");
      log("Error Response Body: ${e.response?.data}");

      String errorMessage = "An error occurred";
      if (e.response?.data != null && e.response?.data is Map) {
        final data = e.response?.data as Map;
        if (data.containsKey('errors')) {
          final errors = data['errors'];
          if (errors is List) {
            if (errors.isNotEmpty) {
              errorMessage = errors.first.toString();
            }
          } else if (errors is Map) {
            if (errors.values.isNotEmpty) {
              final firstVal = errors.values.first;
              if (firstVal is List && firstVal.isNotEmpty) {
                errorMessage = firstVal.first.toString();
              } else {
                errorMessage = firstVal.toString();
              }
            }
          } else {
            errorMessage = errors.toString();
          }
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
