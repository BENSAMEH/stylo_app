class OfferModel {
  final String id;
  final String name;
  final String description;
  final String imageUrl;

  OfferModel({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
  });

  factory OfferModel.fromJson(Map<String, dynamic> json) {

    String rawUrl = json['coverUrl'] ?? '';


    String finalImageUrl = rawUrl;
    if (rawUrl.contains('jewellery.theknight.tech')) {
      finalImageUrl = 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=500'; // صورة بديلة جميلة
    }

    return OfferModel(
      id: json['id'] ?? '',
      name: json['name'] ?? 'No Name',
      description: json['description'] ?? '',
      imageUrl: finalImageUrl,
    );
  }
}