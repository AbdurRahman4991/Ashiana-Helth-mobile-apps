class Manufacturing {
  int id;
  String name;
  String slug;
  String logo;

  Manufacturing({
    required this.id,
    required this.name,
    required this.slug,
    required this.logo,
  });

  factory Manufacturing.fromJson(Map<String, dynamic> json) {
    return Manufacturing(
      id: int.parse(json['id'].toString()),
      name: json['name'] ?? '',
      slug: json['slug'] ?? '',
      logo: json['logo'] ?? '',
    );
  }
}