class AddressModel {
  final String id;
  final String apartment;
  final String city;
  final String state;
  final String street;
  final String phoneNumber;
  final String notes;

  AddressModel({
    required this.id,
    required this.apartment,
    required this.city,
    required this.state,
    required this.notes,
    required this.street,
    required this.phoneNumber,
  });

  factory AddressModel.fromJson(Map<String, dynamic> json) {
    return AddressModel(
      id: json['id'] ?? '',
      apartment: json['apartment'] ?? '',
      city: json['city'] ?? '',
      state: json['state'] ?? '',
      notes: json['notes'] ?? '',
      street: json['street'] ?? '',
      phoneNumber: json['phoneNumber'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'apartment': apartment,
      'city': city,
      'state': state,
      'notes': notes,
      'street': street,
      'phoneNumber': phoneNumber,
    };
  }
}
