class AddProductRequestModel {
  final String? sellerId;
  final String name;
  final String description;
  final String nameArabic;
  final String descriptionArabic;
  final String coverPictureUrl;
  final double price;
  final int stock;
  final double weight;
  final String color;
  final int discountPercentage;
  final List<String> categoryIds;
  final List<String> productPictureUrls;

  AddProductRequestModel({
    this.sellerId,
    required this.name,
    required this.description,
    required this.coverPictureUrl,
    required this.price,
    required this.stock,
    required this.categoryIds,
    this.nameArabic = '',
    this.descriptionArabic = '',
    this.weight = 0,
    this.color = '',
    this.discountPercentage = 0,
    this.productPictureUrls = const [],
  });

  Map<String, dynamic> toJson() {
    return {
      if (sellerId != null) 'sellerId': sellerId,
      'name': name,
      'description': description,
      'nameArabic': nameArabic,
      'descriptionArabic': descriptionArabic,
      'coverPictureUrl': coverPictureUrl,
      'price': price,
      'stock': stock,
      'weight': weight,
      'color': color,
      'discountPercentage': discountPercentage,
      'categoryIds': categoryIds,
      'productPictureUrls': productPictureUrls,
    };
  }
}
