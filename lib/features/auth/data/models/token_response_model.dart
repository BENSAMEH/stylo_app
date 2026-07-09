class TokenResponseModel {
  final String accessToken;
  final String refreshToken;
  final DateTime expiresAtUtc;

  TokenResponseModel({
    required this.accessToken,
    required this.refreshToken,
    required this.expiresAtUtc,
  });

  factory TokenResponseModel.fromJson(Map<String, dynamic> json) {
    return TokenResponseModel(
      accessToken: json["accessToken"],
      refreshToken: json["refreshToken"],
      expiresAtUtc: DateTime.parse(json["expiresAtUtc"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "accessToken": accessToken,
      "refreshToken": refreshToken,
      "expiresAtUtc": expiresAtUtc.toIso8601String(),
    };
  }
}