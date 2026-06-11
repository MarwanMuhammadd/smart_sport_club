import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:smart_sport_club/core/services/apis/apis.dart';
import 'package:smart_sport_club/core/services/apis/dio_provider.dart';
import 'package:smart_sport_club/application/feature/sports/data/model/coach_model.dart';

class CoachRepo {
  static Future<({CoachResponse? response, String? error})> addCoach(
    CoachRequest coach,
  ) async {
    try {
      final requestBody = coach.toJson();
      print("=== ADD COACH REQUEST ===");
      print("Request Body: $requestBody");
      log("Adding coach to API... data: $requestBody");

      var request = await DioProvider.post(
        path: Apis.coaches,
        data: requestBody,
      );

      print("=== ADD COACH RESPONSE ===");
      print("Response Status Code: ${request.statusCode}");
      print("Response Data: ${request.data}");
      log("Response Status Code: ${request.statusCode}");
      log("Response Data: ${request.data}");

      if (request.statusCode == 200 || request.statusCode == 201) {
        return (
          response: CoachResponse.fromJson(request.data as Map<String, dynamic>),
          error: null,
        );
      } else {
        return (response: null, error: "Something went wrong");
      }
    } on DioException catch (e) {
      print("=== ADD COACH DIO EXCEPTION ===");
      print("Dio Error Type: ${e.type}");
      print("Dio Error Message: ${e.message}");
      print("Dio Error Detail: ${e.error}");
      print("Dio Error Status Code: ${e.response?.statusCode}");
      print("Dio Error Response Body: ${e.response?.data}");

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

  static Future<List<CoachResponse>> getCoaches() async {
    try {
      log("Fetching coaches from API...");
      var request = await DioProvider.get(
        path: Apis.coaches,
      );

      log("Raw Coaches Response: ${request.data}");

      if (request.statusCode == 200) {
        print("=== COACHES RESPONSE FROM API ===");
        print("${request.data}");
        
        List<dynamic> allCoaches = [];
        if (request.data is List) {
          allCoaches = request.data as List<dynamic>;
        } else if (request.data is Map) {
          final Map<String, dynamic> data = request.data as Map<String, dynamic>;
          allCoaches = data['all'] as List<dynamic>? ?? [];
        }
        
        final list = allCoaches
            .map((e) => CoachResponse.fromJson(e as Map<String, dynamic>))
            .toList();

        print("=== PARSED COACH ACADEMY RELATIONSHIPS ===");
        for (var coach in list) {
          print("Coach: '${coach.fullName}' (ID: ${coach.id})");
          print("  * academyId received from API: ${coach.academyId}");
          print("  * coach academy relation (academyIds list): ${coach.academyIds}");
        }
        
        return list;
      } else {
        print("=== COACHES API ERROR: status code ${request.statusCode} ===");
        return [];
      }
    } on DioException catch (e) {
      log("Dio Error Type: ${e.type}");
      log("Dio Error Message: ${e.message}");
      log("Dio Error Detail: ${e.error}");
      log("Dio Error: ${e.response?.statusCode}");
      log("Error Response Body: ${e.response?.data}");
      return [];
    } catch (e) {
      log("General Error: ${e.toString()}");
      return [];
    }
  }

  static Future<({bool success, String? error})> deleteCoach(
    int id,
  ) async {
    try {
      log("Deleting coach from API... id: $id");
      var request = await DioProvider.delete(
        path: "${Apis.coaches}/$id",
      );
      if (request.statusCode == 200 || request.statusCode == 204) {
        return (success: true, error: null);
      } else {
        return (success: false, error: "Something went wrong");
      }
    } on DioException catch (e) {
      log("Dio Error: ${e.response?.statusCode}");
      return (success: false, error: e.message);
    } catch (e) {
      return (success: false, error: e.toString());
    }
  }
}
