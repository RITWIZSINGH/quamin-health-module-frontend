
class Address {
  final String houseNo;
  final String street;
  final String society;
  final String locality;
  final String landmark;
  final String city;
  final String state;
  final String pincode;
  final String phone;

  Address({
    required this.houseNo,
    required this.street,
    required this.society,
    required this.locality,
    required this.landmark,
    required this.city,
    required this.state,
    required this.pincode,
    required this.phone,
  });

  String get formattedAddress {
    return '$houseNo, $street\n$society, $locality\nNear: $landmark\n$city, $state - $pincode\nPhone: $phone';
  }

  String get shortAddress {
    return '$houseNo, $society, $city - $pincode';
  }
}