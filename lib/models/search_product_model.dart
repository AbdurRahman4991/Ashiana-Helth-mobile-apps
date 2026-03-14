class Product {
  final int id;
  final String name;
  final String sellingPrice;
  final Manufacturing? manufacturing;

  Product({
    required this.id,
    required this.name,
    required this.sellingPrice,
    this.manufacturing,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'],
      name: json['name'] ?? "",
      sellingPrice: json['selling_price'] ?? "0",
      manufacturing: json['manufacturing'] != null
          ? Manufacturing.fromJson(json['manufacturing'])
          : null,
    );
  }
}

class Manufacturing {
  final String name;

  Manufacturing({required this.name});

  factory Manufacturing.fromJson(Map<String, dynamic> json) {
    return Manufacturing(
      name: json['name'] ?? "",
    );
  }
}