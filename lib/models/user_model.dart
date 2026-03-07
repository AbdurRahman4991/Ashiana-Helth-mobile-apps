
class User {
  final int id;
  final String pharmacyName;
  final String contactNo;
  final String name;
  final String address;
  final String roleName;

  User({
    required this.id,
    required this.pharmacyName,
    required this.contactNo,
    required this.name,
    required this.address,
    required this.roleName,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      pharmacyName: json['pharmacy_name'],
      contactNo: json['contact_no'],
      name: json['name'],
      address: json['address'],
      roleName: json['role_name'],
    );
  }
}