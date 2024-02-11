import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:partnerapp/model/category_list_model.dart';
import 'package:partnerapp/model/home_top_model.dart';
import 'package:partnerapp/model/product_list_model.dart';
import 'package:partnerapp/service/prodduct_repo/product_service.dart';

import '../../service/category_repo/category_service.dart';

class HomePageProvider extends ChangeNotifier {
  HomePageProvider() {
    _init();
  }

  Future<void> _init() async {
    await getCategorylist();
    await getProductlist();
  }

  List<HomeTop> todoList = [
    HomeTop(
      name: "Bookings",
      text: "View \n bookings",
      icon: 'task',
    ),
    HomeTop(
      name: "offers",
      text: "Add/view  \n offers",
      icon: 'offer',
    )
  ];

  bool isLoading = true;

  setLoader(bool value) {
    isLoading = value;
    notifyListeners();
  }

  List<Categorylist> categoryList = [];

  Future<void> getCategorylist() async {
    try {
      final response = await CategoryService().getCategorylist();
      if (response.error == false) {
        setLoader(false);
        categoryList = response.categorylist;
        log(categoryList.toString());
      } else {
        setLoader(false);
      }
    } catch (e) {
      print('Dio Error: $e');
    }
  }

  List<Product> productList = [];
  Future<void> getProductlist() async {
    try {
      final response = await ProductService().getProductlist();
      if (response.error == false) {
        setLoader(false);
        productList = response.product;
        log("${categoryList[0].toJson()}");
      } else {
        setLoader(false);
      }
    } catch (e) {
      print('Dio Error: $e');
    }
  }
}
