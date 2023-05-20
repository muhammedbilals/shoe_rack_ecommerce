class Address {
  final String name;
  final String addressType;
  final int phoneNumber;
  final String houseName;
  final String roadName;
  final int pinCode;
  final String city;
  final String state;
  final String? id;

  Address(
      {required this.addressType,
      required this.name,
      required this.phoneNumber,
      required this.houseName,
      required this.roadName,
      required this.pinCode,
      required this.city,
      required this.state,
      this.id});

  static Address fromJason(Map<String, dynamic> json) => Address(
      name: json['name'],
      addressType: json['addressType'],
      phoneNumber: json['phoneNumber'],
      houseName: json['houseName'],
      roadName: json['roadName'],
      pinCode: json['pinCode'],
      city: json['city'],
      state: json['state'],
      id: json['id']);

  Map<String, dynamic> toJason() => {
        'name': name,
        'addressType':addressType,
        'phoneNumber': phoneNumber,
        'houseName': houseName,
        'roadName': roadName,
        'pinCode': pinCode,
        'city': city,
        'state': state
      };
}
