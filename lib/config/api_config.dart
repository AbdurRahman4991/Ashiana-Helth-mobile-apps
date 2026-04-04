class ApiConfig {
  //static const String baseUrl = "http://192.168.0.104:8000/api";
  static const String baseUrl = "https://demoapp.ashianahealth.com/api";

  // Optional: helper for images
  static String productImage(String fileName) {
    return "$baseUrl/storage/products/$fileName";
  }


}
