import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:partnerapp/model/product_detail_model.dart';
import 'package:partnerapp/service/prodduct_repo/product_service.dart';

class DetailProvider extends ChangeNotifier {
  int currentIndex = 0;

  void setPageIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  bool isLoading = true;

  setLoader(bool value) {
    isLoading = value;
    notifyListeners();
  }

  List<Productdetail> productdetails = [];

  Future<void> getProduct(int proId) async {
    try {
      final response = await ProductService().getProductDetail(proId);
      if (response.error == false) {
        productdetails.clear();
        setLoader(false);

        productdetails = response.productdetails;

        log("${productdetails[0].toJson()}");
      } else {
        setLoader(false);
      }
    } catch (e) {
      print('Dio Error: $e');
    }
    notifyListeners();
  }
}
