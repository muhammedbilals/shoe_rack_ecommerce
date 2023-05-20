class Address {
   String name='';
   String addressType='';
   int phoneNumber;
   String houseName='';
   String roadName='';
   int pinCode;
   String city='';
   String state='';
  String? id;
  bool isDefault = false;

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

        'id': id,
        'addressType': addressType,
        'phoneNumber': phoneNumber,
        'houseName': houseName,
        'roadName': roadName,
        'pinCode': pinCode,
        'city': city,
        'state': state
      };
}
