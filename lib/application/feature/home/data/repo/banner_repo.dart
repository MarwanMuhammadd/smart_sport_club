import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:smart_sport_club/core/services/apis/apis.dart';
import 'package:smart_sport_club/core/services/apis/dio_provider.dart';
import 'package:smart_sport_club/application/feature/home/data/model/banner_model.dart';

class BannerRepo {
  static Future<({List<BannerModel>? response, String? error})> getBanners() async {
    try {
      log("Fetching banners from API...");
      var request = await DioProvider.get(
        path: Apis.banners,
      );
      log("Raw Banners Response: ${request.data}");
      if (request.statusCode == 200) {
        final List<dynamic> data = request.data as List<dynamic>;
        final List<BannerModel> bannersList = data
            .map((e) => BannerModel.fromJson(e as Map<String, dynamic>))
            .toList();
        return (response: bannersList, error: null);
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
