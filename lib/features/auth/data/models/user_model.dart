class UserModel {
  final String userId;
  final String email;
  final String fullName;
  final String? profilePicture;

  UserModel({
    required this.userId,
    required this.email,
    required this.fullName,
    this.profilePicture,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      userId: json["userId"],
      email: json["email"],
      fullName: json["fullName"],
      profilePicture: json["profilePicture"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "userId": userId,
      "email": email,
      "fullName": fullName,
      "profilePicture": profilePicture,
    };
  }
}