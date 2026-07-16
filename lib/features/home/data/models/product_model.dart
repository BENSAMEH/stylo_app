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
    
    final rawId = json['id']?.toString() ?? '';
    final int parsedId = int.tryParse(rawId) ?? rawId.hashCode;

   
    final List? categoriesList = json['categories'] as List?;
    final String rawCategoryId = (categoriesList != null && categoriesList.isNotEmpty)
        ? categoriesList.first.toString()
        : '';
    final int parsedCategoryId = rawCategoryId.hashCode;

    return ProductModel(
      originalId: rawId, 
      id: rawId.hashCode,

      name:        json['name']        ?? '',
      description: json['description'] ?? '',
      price:       (json['price']      as num? ?? 0).toDouble(),
      imageUrl:    json['coverPictureUrl'] ?? json['imageUrl'] ?? json['image'] ?? '',
      categoryId:  parsedCategoryId, 
      isAvailable: (json['stock'] as num? ?? 0) > 0,
    );
  }
}