
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'provider/auth_provider.dart';
import 'provider/login_provider.dart';
import 'package:ashianahealth_mobile_app/splash_screen.dart';
import 'provider/home_provider.dart';
import 'provider/product_provider.dart';
import 'provider/category_product_provider.dart';
import 'provider/new_product_provider.dart';
import 'provider/search_provider.dart';
import 'core/services/cart_service.dart';
import 'provider/order_detail_provider.dart';
import 'provider/invoice_provider.dart';
import 'provider/user_provider.dart';
import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'provider/product_details_provider.dart';
import 'provider/CategoryListProvider.dart';
import 'provider/manufacturer_provider.dart';
import 'provider/FilterProvider.dart';
import 'provider/TrendingProvider.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await CartService.loadCartCount();
  runApp(
        MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => LoginProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => ProductProvider()),
        ChangeNotifierProvider(create: (_) => CategoryProductProvider()),
        ChangeNotifierProvider(create: (_) => NewProductProvider()),
        ChangeNotifierProvider(create: (_) => SearchProvider()),
        ChangeNotifierProvider(create: (_) => OrderDetailProvider()),
        ChangeNotifierProvider(create: (_) => InvoiceProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
        ChangeNotifierProvider(create: (_) => ProductDetailsProvider()),
        ChangeNotifierProvider(create: (_) => CategoryListProvider()),
        ChangeNotifierProvider(create: (_) => ManufacturingProvider()),
        ChangeNotifierProvider(create: (_) => FilterProvider()),
        ChangeNotifierProvider(create: (_) =>TrendingProvider()),

      ],
      child: const MyApp(),
    ),
   // const MyApp()
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
    );
  }
}
class MyCacheManager {
  static const key = "customCache";

  static CacheManager instance = CacheManager(
    Config(
      key,
      stalePeriod: const Duration(days: 7), // 7 দিন cache থাকবে
      maxNrOfCacheObjects: 100, // max 100 image
    ),
  );
}