class AddressModel {
  final String id;
  final String state;
  final String city;
  final String street;
  final String apartment;
  final String phoneNumber;
  final String notes;

  AddressModel({
    required this.id,
    required this.state,
    required this.city,
    required this.street,
    required this.apartment,
    required this.phoneNumber,
    required this.notes,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id']?.toString() ?? '',
      state: json['state'] ?? '',
      city: json['city'] ?? '',
      street: json['street'] ?? '',
      apartment: json['apartment'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
      notes: json['notes'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "state": state,
      "city": city,
      "street": street,
      "apartment": apartment,
      "phoneNumber": phoneNumber,
      "notes": notes,
    };
  }

  String get displayLine1 => "$street, $apartment";

  String get displayLine2 => "$city, $state";
}