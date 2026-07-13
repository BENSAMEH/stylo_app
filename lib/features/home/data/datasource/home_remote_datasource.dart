import 'package:dio/dio.dart';
import 'package:stylo_app/core/api/api_client.dart';
import 'package:stylo_app/core/api/api_constants.dart';
import '../../../../core/services/shared_pref_service.dart';
import '../models/category_model.dart';
import '../models/product_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomeRemoteDatasource {
  final ApiClient apiClient;
  HomeRemoteDatasource(this.apiClient);

  Future<List<CategoryModel>> getCategories() async {
    try {
      final String? token = SharedPrefService.getAccessToken();

      // طباعة التوكن بشكل نظيف وواضح لنسخه لـ Postman عند الحاجة
      print("🔑 Copy this Token for Postman:\n$token");

      final response = await apiClient.get(ApiConstants.categories);

      // الـ تصحيح السحري هنا: السيرفر يرجع Map يحتوي على مفتاح 'categories' وبداخله الـ List
      final Map<String, dynamic> responseData = response.data as Map<String, dynamic>;
      final List categoriesData = responseData['categories'] as List;

      return categoriesData.map((e) => CategoryModel.fromJson(e)).toList();

    } on DioException catch (e) {
      // طباعة تفاصيل الخطأ القادم من السيرفر بالتفصيل
      print("❌ Error Status Code: ${e.response?.statusCode}");
      print("❌ Error Server Response Data: ${e.response?.data}");
      print("❌ Error Message: ${e.message}");

      throw Exception(e.response?.data?['message'] ?? e.response?.data ?? e.message);
    }
  }


// حافظ على الـ imports الباقية زي ما هي

// داخل الـ HomeRemoteDatasource class:
  Future<List<ProductModel>> getProducts() async {
    try {
      // 1. هنجيب التوكن الكاش مباشرة من السيرفيس
      final token = SharedPrefService.getAccessToken();

      // 2. هنركب الرابط الكامل للـ products
      final url = Uri.parse("https://accessories-eshop.runasp.net/api/products");

      // 3. نرسل الـ Request النظيف تماماً عبر كائن الـ http المعياري
      final response = await http.get(
        url,
        headers: {
          'Accept': 'application/json',
          if (token != null && token.isNotEmpty && token != "null")
            'Authorization': 'Bearer $token',
        },
      );

      // 4. تشيك على الـ Status Code
      if (response.statusCode == 200) {
        // فك تشفير الـ UTF-8 والـ JSON
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
    // الفلتر شغال Local بالـ int جوه الـ Cubit، فالدالة دي هترجع كل المنتجات عادي
    return getProducts();
  }

}