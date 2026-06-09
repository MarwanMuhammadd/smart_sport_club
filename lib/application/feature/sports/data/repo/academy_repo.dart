import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:smart_sport_club/core/services/apis/apis.dart';
import 'package:smart_sport_club/core/services/apis/dio_provider.dart';
import 'package:smart_sport_club/application/feature/sports/data/model/academy_model.dart';

class AcademyRepo {
  static Future<({List<AcademyModel>? response, String? error})>
      getAcademies() async {
    try {
      log("Fetching academies from API...");
      var request = await DioProvider.get(
        path: Apis.academiesScreen,
      );

      log("Raw Academies Response: ${request.data}");

      if (request.statusCode == 200) {
        List<dynamic> allAcademies = [];
        if (request.data is List) {
          allAcademies = request.data as List<dynamic>;
        } else if (request.data is Map) {
          final Map<String, dynamic> data = request.data as Map<String, dynamic>;
          allAcademies = data['all'] as List<dynamic>? ?? [];
        }
        
        final List<AcademyModel> academiesList = allAcademies
            .map((e) => AcademyModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return (response: academiesList, error: null);
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

  static Future<({AcademyModel? response, String? error})> getAcademyById(
    int id,
  ) async {
    try {
      log("Fetching academy by id from API... id: $id");
      var request = await DioProvider.get(
        path: "/api/academies/$id",
      );

      if (request.statusCode == 200) {
        return (
          response: AcademyModel.fromJson(request.data as Map<String, dynamic>),
          error: null,
        );
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

  static Future<({AcademyModel? response, String? error})> addAcademy(
    AcademyModel academy,
  ) async {
    try {
      final requestBody = academy.toJson();
      print("=== ADD ACADEMY REQUEST ===");
      print("Request Body: $requestBody");
      log("Adding academy to API... data: $requestBody");

      var request = await DioProvider.post(
        path: "/api/academies",
        data: requestBody,
      );

      print("=== ADD ACADEMY RESPONSE ===");
      print("Response Status Code: ${request.statusCode}");
      print("Response Data: ${request.data}");
      log("Response Status Code: ${request.statusCode}");
      log("Response Data: ${request.data}");

      if (request.statusCode == 200 || request.statusCode == 201) {
        return (
          response: AcademyModel.fromJson(request.data as Map<String, dynamic>),
          error: null,
        );
      } else {
        return (response: null, error: "Something went wrong");
      }
    } on DioException catch (e) {
      print("=== ADD ACADEMY DIO EXCEPTION ===");
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

  static Future<({AcademyModel? response, String? error})> updateAcademy(
    int id,
    AcademyModel academy,
  ) async {
    try {
      log("Updating academy in API... id: $id, data: ${academy.toJson()}");
      var request = await DioProvider.put(
        path: "/api/academies/$id",
        data: academy.toJson(),
      );
      if (request.statusCode == 200 || request.statusCode == 204) {
        final responseData = request.data != null && request.data is Map
            ? AcademyModel.fromJson(request.data as Map<String, dynamic>)
            : academy;
        return (response: responseData, error: null);
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

  static Future<({bool success, String? error})> deleteAcademy(
    int id,
  ) async {
    try {
      log("Deleting academy from API... id: $id");
      var request = await DioProvider.delete(
        path: "/api/academies/$id",
      );
      if (request.statusCode == 200 || request.statusCode == 204) {
        return (success: true, error: null);
      } else {
        return (success: false, error: "Something went wrong");
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
      return (success: false, error: errorMessage);
    } catch (e) {
      log("General Error: ${e.toString()}");
      return (success: false, error: e.toString());
    }
  }
}
