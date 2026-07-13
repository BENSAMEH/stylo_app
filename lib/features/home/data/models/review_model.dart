class ReviewModel {
  final int    id;
  final String userName;
  final String comment;
  final double rating;

  const ReviewModel({
    required this.id,
    required this.userName,
    required this.comment,
    required this.rating,
  });

  factory ReviewModel.fromJson(Map<String, dynamic> json) {
    return ReviewModel(
      id:       json['id']       ?? 0,
      userName: json['userName'] ?? json['user'] ?? 'Anonymous',
      comment:  json['comment']  ?? json['review'] ?? '',
      rating:   (json['rating']  as num? ?? 0).toDouble(),
    );
  }
}