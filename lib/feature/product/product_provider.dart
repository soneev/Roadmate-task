import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:partnerapp/model/cart_list_model.dart';
import 'package:partnerapp/model/category_list_model.dart';
import 'package:partnerapp/model/product_by_category_model.dart';
import 'package:partnerapp/model/product_detail_model.dart';
import 'package:partnerapp/model/product_list_model.dart';
import 'package:partnerapp/model/subcategory_list_model.dart';
import 'package:partnerapp/service/cart_repo/cart_service.dart';
import 'package:partnerapp/service/category_repo/category_service.dart';
import 'package:partnerapp/service/prodduct_repo/product_service.dart';
import 'package:provider/provider.dart';

import '../home_page/homepage_provider.dart';

class ProductProvider extends ChangeNotifier {
  ProductProvider() {
    init();
  }
  Future<void> init() async {
    await getCategorylist();
    await getAllProductslist();
    await getCartList();
  }

  int currentIndex = 0;

  void setPageIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }

  var selectedSubcategory = "";
  void setSelectedSubcategory(String subcategory) {
    selectedSubcategory = subcategory;
    notifyListeners();
  }

  var selectedTabindex = 0;

  setTabIndex(int index) {
    selectedTabindex = index;
    notifyListeners();
  }

  bool isSearchable = true;
  setSearchbar(bool value) {
    isSearchable = value;
    notifyListeners();
  }

  final int _tabCount = 0;

  int get tabCount => _tabCount;

  bool isLoading = true;

  setLoader(bool value) {
    isLoading = value;
    notifyListeners();
  }

  bool isMoreLoading = true;

  setMoreLoader(bool value) {
    isMoreLoading = value;
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

  List<Product> allProduct = [];

  Future<void> getAllProductslist() async {
    try {
      final response = await ProductService().getProductlist();
      if (response.error == false) {
        setLoader(false);
        allProduct = response.product;
        log("${allProduct[0].toJson()}");
      } else {
        setLoader(false);
      }
    } catch (e) {
      print('Dio Error: $e');
    }
  }

  List<Subcategorylist> subCategoryList = [];

  Future<void> getSubCategoryList(int catId) async {
    try {
      final response = await CategoryService().getSubCategorylist(catId);
      if (response.error == false) {
        setLoader(false);
        setSelectedSubcategory("");
        subCategoryList.clear();

        subCategoryList = response.subcategorylist;
        log("${subCategoryList[0].toJson()}");
      } else {
        setLoader(false);
      }
    } catch (e) {
      print('Dio Error: $e');
    }
  }

  List<SubProductlist> subCatProductList = [];

  Future<void> getSubCategoryProductList(int catId) async {
    try {
      final response = await CategoryService().getPrdouctBySubcategory(catId);
      if (response.error == false) {
        setLoader(false);

        subCatProductList.clear();

        subCatProductList = response.productlist;
        log("${subCatProductList[0].toJson()}");
      } else {
        setLoader(false);
      }
    } catch (e) {
      print('Dio Error: $e');
    }
  }

  String? message;

  Future<void> addToCart({required int proId, required int qty}) async {
    try {
      final response = await CartService().addToCart(proId, qty);
      if (response.error == false) {
        setMoreLoader(false);
        message = response.message;
        await getCartList();

        log("${response.toJson()}");
      } else {
        setMoreLoader(false);
      }
    } catch (e) {
      print('Dio Error: $e');
    }
  }

  List<CartItems>? cartList = [];

  Future<void> getCartList() async {
    try {
      final response = await CartService().getCart();
      if (response.error == false) {
        log("cxtxtxcxtcxcx-------->>>>${response.cart.toString()}");
        setMoreLoader(false);
        cartList!.clear();
        cartList = response.cart;

        log("cart---->${cartList![0].toJson()}");
      } else {
        setMoreLoader(false);
      }
    } catch (e) {
      print('Dio Error: $e');
    }
  }

  Future<void> deleteCartItem(int id) async {
    try {
      final response = await CartService().delete(id);
    } catch (e) {
      print('Dio Error: $e');
    }
  }
}
