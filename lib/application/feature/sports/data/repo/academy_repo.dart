import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:smart_sport_club/core/services/apis/apis.dart';
import 'package:smart_sport_club/core/services/apis/dio_provider.dart';
import 'package:smart_sport_club/application/feature/sports/data/model/academy_model.dart';

class AcademyRepo {
  static Future<({List<AcademyModel>? response, String? error})> getAcademies() async {
    try {
      log("Fetching academies from API...");
      var request = await DioProvider.get(path: Apis.academiesScreen);

      log("Raw Academies Response: ${request.data}");

      if (request.statusCode == 200) {
        print("=== ACADEMY DETAILS RESPONSE ===");
        print("${request.data}");
        
        final allAcademies = _extractAcademiesList(request.data);

        final List<AcademyModel> academiesList = allAcademies
            .whereType<Map>()
            .map((academy) => AcademyModel.fromJson(_toStringKeyMap(academy)))
            .toList();
        return (response: academiesList, error: null);
      } else {
        print("=== ACADEMY API ERROR: status code ${request.statusCode} ===");
        return (response: null, error: "Something went wrong");
      }
    } on DioException catch (e) {
      print("=== ACADEMY API DIO EXCEPTION ===");
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

  static Future<({AcademyModel? response, String? error})> getAcademyById(
    int id,
  ) async {
    try {
      log("Fetching academy by id from API... id: $id");
      var request = await DioProvider.get(path: "${Apis.academies}/$id");

      if (request.statusCode == 200) {
        print("=== ACADEMY DETAILS RESPONSE (ID: $id) ===");
        print("${request.data}");
        
        return (
          response: AcademyModel.fromJson(_toStringKeyMap(request.data as Map)),
          error: null,
        );
      } else {
        print("=== ACADEMY DETAILS API ERROR (ID: $id): status code ${request.statusCode} ===");
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
      log("Adding academy to API... data: $requestBody");

      var request = await DioProvider.post(
        path: Apis.academies,
        data: requestBody,
      );

      log("Response Status Code: ${request.statusCode}");
      log("Response Data: ${request.data}");

      if (request.statusCode == 200 || request.statusCode == 201) {
        return (
          response: AcademyModel.fromJson(_toStringKeyMap(request.data as Map)),
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

  static Future<({AcademyModel? response, String? error})> updateAcademy(
    int id,
    AcademyModel academy,
  ) async {
    try {
      log("Updating academy in API... id: $id, data: ${academy.toJson()}");
      var request = await DioProvider.put(
        path: "${Apis.academies}/$id",
        data: academy.toJson(),
      );
      if (request.statusCode == 200 || request.statusCode == 204) {
        final responseData = request.data != null && request.data is Map
            ? AcademyModel.fromJson(_toStringKeyMap(request.data as Map))
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

  static Future<({bool success, String? error})> deleteAcademy(int id) async {
    try {
      log("Deleting academy from API... id: $id");
      var request = await DioProvider.delete(path: "${Apis.academies}/$id");
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

  static List<dynamic> _extractAcademiesList(dynamic data) {
    if (data is List) return data;

    if (data is Map) {
      final list =
          data['data'] ?? data['all'] ?? data['items'] ?? data['academies'];
      if (list is List) return list;
      if (list is Map) return _extractAcademiesList(list);
    }

    return [];
  }

  static Map<String, dynamic> _toStringKeyMap(Map data) {
    return data.map((key, value) => MapEntry(key.toString(), value));
  }
}
