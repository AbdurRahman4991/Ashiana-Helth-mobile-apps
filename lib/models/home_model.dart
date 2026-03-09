class HomeModel {
  bool? status;
  HomeData? data;

  HomeModel({this.status, this.data});

  HomeModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    data = json['data'] != null ? HomeData.fromJson(json['data']) : null;
  }
}

class HomeData {
  List<SliderModel>? sliders;
  List<Product>? trendingProducts;
  List<Product>? newProducts;

  HomeData({this.sliders, this.trendingProducts, this.newProducts});

  HomeData.fromJson(Map<String, dynamic> json) {
    if (json['sliders'] != null) {
      sliders = [];
      json['sliders'].forEach((v) {
        sliders!.add(SliderModel.fromJson(v));
      });
    }

    if (json['trending_products'] != null) {
      trendingProducts = [];
      json['trending_products'].forEach((v) {
        trendingProducts!.add(Product.fromJson(v));
      });
    }

    if (json['new_products'] != null) {
      newProducts = [];
      json['new_products'].forEach((v) {
        newProducts!.add(Product.fromJson(v));
      });
    }
  }
}

class SliderModel {
  int? id;
  String? image;

  SliderModel({this.id, this.image});

  SliderModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}

class Product {
  int? id;
  String? name;
  String? sellingPrice;
  String? discountedPrice;
  String? image;

  Product({
    this.id,
    this.name,
    this.sellingPrice,
    this.discountedPrice,
    this.image,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sellingPrice = json['selling_price'];
    discountedPrice = json['discounted_price'];
    image = json['image'];
  }
}