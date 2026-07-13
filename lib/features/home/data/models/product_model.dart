class ProductModel {
  final int    id;
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final int    categoryId;
  final bool   isAvailable;
  final String ?originalId;

  const ProductModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.categoryId,
    required this.isAvailable, this.originalId,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    // 1. تحويل الـ id النصي (UUID) إلى int فريد باستخدام hashCode لعدم كسر السيستم
    final rawId = json['id']?.toString() ?? '';
    final int parsedId = int.tryParse(rawId) ?? rawId.hashCode;

    // 2. السيرفر باعت الـ Category كـ مصفوفة نصوص أو كائن، هنعمل لها Hash برضه عشان نربطها
    // بناءً على رد البوستمان: "categories": ["luxury watch"]
    final List? categoriesList = json['categories'] as List?;
    final String rawCategoryId = (categoriesList != null && categoriesList.isNotEmpty)
        ? categoriesList.first.toString()
        : '';
    final int parsedCategoryId = rawCategoryId.hashCode;

    return ProductModel(
      originalId: rawId, // 👈 حفظ الـ UUID النصي هنا
      id: rawId.hashCode,

      name:        json['name']        ?? '',
      description: json['description'] ?? '',
      price:       (json['price']      as num? ?? 0).toDouble(),
      // 3. السيرفر باعت المفتاح باسم coverPictureUrl وليس imageUrl
      imageUrl:    json['coverPictureUrl'] ?? json['imageUrl'] ?? json['image'] ?? '',
      categoryId:  parsedCategoryId, // 👈 اتربطت بالتصنيف بنجاح
      // 4. السيرفر باعت stock رقمي، لو أكبر من 0 يبقى متاح
      isAvailable: (json['stock'] as num? ?? 0) > 0,
    );
  }
}