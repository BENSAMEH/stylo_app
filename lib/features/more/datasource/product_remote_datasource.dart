import 'package:dio/dio.dart';
import 'package:stylo_app/core/api/api_client.dart';
import 'package:stylo_app/core/api/api_constants.dart';
import 'package:stylo_app/features/more/models/add_product_request_model.dart';

class ProductRemoteDataSource {
  final ApiClient _apiClient = ApiClient();

  /// إضافة منتج جديد
 Future<void> addProduct(AddProductRequestModel request) async {
    try {
      final response = await _apiClient.post(
        ApiConstants.products,
        data: request.toJson(),
      );

      // 🔍 مؤقتًا للتأكد: يوريك المنتج اللي رجع من السيرفر فعلًا بعد الحفظ
      // ignore: avoid_print
      print('PRODUCT CREATED: ${response.data}');

      if (response.statusCode != 200 && response.statusCode != 201) {
        throw Exception('Failed to add product');
      }
    } on DioException catch (e) {
      print("STATUS CODE: ${e.response?.statusCode}");
      print("RESPONSE: ${e.response?.data}");
      throw Exception(e.response?.data.toString() ?? e.message);
    }
  }
  /// جلب كل الكاتيجوريز الحقيقية (id + name)
  Future<List<Map<String, dynamic>>> getCategories() async {
    try {
      final response = await _apiClient.get(ApiConstants.categories);
      final data = response.data;

      List<dynamic> rawList;
      if (data is List) {
        rawList = data;
      } else if (data is Map && data['categories'] != null) {
        rawList = data['categories'] as List;
      } else if (data is Map && data['items'] != null) {
        rawList = data['items'] as List;
      } else if (data is Map && data['data'] != null) {
        rawList = data['data'] as List;
      } else {
        rawList = [];
      }

      return rawList
          .map(
            (e) => {
              'id': e['id']?.toString() ?? '',
              'name': e['name']?.toString() ?? '',
            },
          )
          .where((e) => e['id']!.isNotEmpty && e['name']!.isNotEmpty)
          .toList();
    } on DioException catch (e) {
      // ignore: avoid_print
      print("STATUS CODE: ${e.response?.statusCode}");
      // ignore: avoid_print
      print("RESPONSE: ${e.response?.data}");
      throw Exception(e.response?.data.toString() ?? e.message);
    }
  }
}
