class CategoryModel {
  final int id; // 👈 رجعت int زي ما كنت حابب تماماً
  final String name;
  final String description;
  final String coverPictureUrl;

  CategoryModel({
    required this.id,
    required this.name,
    required this.description,
    required this.coverPictureUrl,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    final rawName = json['name']?.toString() ?? '';
    // الـ id هنا هيكون الـ hashCode بتاع الاسم عشان يطابق الـ categoryId اللي عملناه في المنتج!
    final int parsedId = rawName.hashCode;

    return CategoryModel(
      id: parsedId,
      name: rawName,
      description: json['description'] as String? ?? '',
      coverPictureUrl: json['coverPictureUrl'] as String? ?? '',
    );
  }
}