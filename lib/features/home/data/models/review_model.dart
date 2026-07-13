class ReviewModel {
  final String userName;
  final String comment;
  final double rating;
  final DateTime? createdAt;
  final String? userPicture;

  const ReviewModel({
    required this.userName,
    required this.comment,
    required this.rating,
    this.createdAt,
    this.userPicture,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      userName: json['userName'] ?? 'Anonymous',
      comment: json['comment'] ?? '',
      rating: (json['rating'] as num?)?.toDouble() ?? 0,
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : null,
      userPicture: json['userPicture'],
    );
  }
}