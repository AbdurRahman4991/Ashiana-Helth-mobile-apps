import 'package:flutter/material.dart';
import '../models/home_model.dart';
import '../core/services/home_service.dart';

class HomeProvider extends ChangeNotifier {

  HomeModel? homeData;

  bool isLoading = false;

  Future<void> getHomeData() async {

    isLoading = true;
    notifyListeners();

    homeData = await HomeService().fetchHomeData();

    isLoading = false;
    notifyListeners();
  }
}
