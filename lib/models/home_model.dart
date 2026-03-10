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
  List<Manufacturer>? manufacturers;
  List<Category>? categories;

  HomeData({
    this.sliders,
    this.trendingProducts,
    this.newProducts,
    this.manufacturers,
    this.categories,
  });

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

    if (json['manufacturers'] != null) {
      manufacturers = [];
      json['manufacturers'].forEach((v) {
        manufacturers!.add(Manufacturer.fromJson(v));
      });
    }

    if (json['categories'] != null) {
      categories = [];
      json['categories'].forEach((v) {
        categories!.add(Category.fromJson(v));
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
  String? discountPercent;
  int? stock;
  String? image;

  Product({
    this.id,
    this.name,
    this.sellingPrice,
    this.discountedPrice,
    this.discountPercent,
    this.stock,
    this.image,
  });

  Product.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    sellingPrice = json['selling_price'];
    discountedPrice = json['discounted_price'];
    discountPercent = json['discount_percent'];
    stock = json['stock'];
    image = json['image'];
    
  }
}

class Manufacturer {
  int? id;
  String? logo;

  Manufacturer({this.id, this.logo});

  Manufacturer.fromJson(Map<String, dynamic> json) {
    //id = json['id'];
     id = int.parse(json['id'].toString());
    logo = json['logo'];
  }
}

class Category {
  int? id;
  String? image;

  Category({this.id, this.image});

  Category.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    image = json['image'];
  }
}