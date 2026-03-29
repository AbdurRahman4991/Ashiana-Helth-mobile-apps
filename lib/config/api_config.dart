class ApiConfig {
  //static const String baseUrl = "http://119.148.28.173:92/api";
  static const String baseUrl = "http://192.168.0.113:8000/api";

  // Optional: helper for images
  static String productImage(String fileName) {
    return "$baseUrl/storage/products/$fileName";
  }


}
