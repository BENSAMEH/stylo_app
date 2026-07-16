import 'package:dio/dio.dart';
import 'package:stylo_app/core/api/api_client.dart';
import 'package:stylo_app/core/api/api_constants.dart';
import 'package:stylo_app/features/home/data/models/category_model.dart';
import '../../../../core/services/shared_pref_service.dart';
import '../models/offer_model.dart';
import '../models/product_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeRemoteDatasource {
  final ApiClient apiClient;
  final Dio dio = Dio();
  HomeRemoteDatasource(this.apiClient);

  Future<List<CategoryModel>> getCategories() async {
    try {
      final String? token = SharedPrefService.getAccessToken();


      final response = await apiClient.get(ApiConstants.categories);


      final Map<String, dynamic> responseData = response.data as Map<String, dynamic>;
      final List categoriesData = responseData['categories'] as List;

      return categoriesData.map((e) => CategoryModel.fromJson(e)).toList();

    } on DioException catch (e) {

      print("❌ Error Status Code: ${e.response?.statusCode}");
      print("❌ Error Server Response Data: ${e.response?.data}");
      print("❌ Error Message: ${e.message}");

      throw Exception(e.response?.data?['message'] ?? e.response?.data ?? e.message);
    }
  }





  Future<List<ProductModel>> getProducts() async {
    try {

      final token = SharedPrefService.getAccessToken();


      final url = Uri.parse("https://accessories-eshop.runasp.net/api/products");


      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          if (token != null && token.isNotEmpty && token != "null")
            'Authorization': 'Bearer $token',
        },
      );


      if (response.statusCode == 200) {

        final rawData = jsonDecode(utf8.decode(response.bodyBytes));

        final List items = (rawData is Map && rawData['items'] != null)
            ? rawData['items']
            : (rawData is List ? rawData : []);

        return items.map((e) => ProductModel.fromJson(e)).toList();
      } else {
        print("❌ HTTP Package Error Code: ${response.statusCode}");
        print("💬 HTTP Server Response: ${response.body}");
        throw Exception("Failed to load products");
      }
    } catch (e) {
      print("💥 Critical Catch Error in http get: $e");
      throw Exception("One or more errors occurred!");
    }
  }

  Future<List<ProductModel>> getProductsByCategory(int categoryId) async {


    return getProducts();
  }
  Future<List<OfferModel>> getOffers({int pageSize = 30}) async {
    try {
      final response = await dio.request(
        'https://accessories-eshop.runasp.net/api/offers',
        data: {"pageSize": pageSize},
        options: Options(method: 'GET'),
      );

      if (response.statusCode == 200 && response.data != null) {
        final responseData = response.data as Map<String, dynamic>;
        final List<dynamic> items = responseData['offers']?['items'] ?? [];


        List<OfferModel> allOffers = items.map((json) => OfferModel.fromJson(json)).toList();

        if (allOffers.length > 4) {
          return allOffers.sublist(allOffers.length - 4);
        }
        return allOffers;
      }
      return [];
    } catch (e) {
      return [];
    }
  }
}