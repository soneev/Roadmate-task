import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:partnerapp/model/category_list_model.dart';
import 'package:partnerapp/model/product_by_category_model.dart';

import 'package:partnerapp/model/subcategory_list_model.dart';
import 'package:partnerapp/utils/route/service_utils.dart';

class CategoryService {
  final dio = Dio();

  Future<CategoryListModel> getCategorylist() async {
    try {
      var response = await dio.request(
        Api.baseUrl + Api.categoryList,
        options: Options(
          method: 'GET',
        ),
      );

      if (response.statusCode == 200) {
        print(response.data);

        if (response.data is String) {
          Map<String, dynamic> jsonData = json.decode(response.data);
          return CategoryListModel.fromJson(jsonData);
        } else if (response.data is Map<String, dynamic>) {
          return CategoryListModel.fromJson(response.data);
        } else {
          throw Exception('Unexpected response type');
        }
      } else {
        return CategoryListModel.fromJson(response.data);
      }
    } catch (e) {
      print('Dio Error: $e');

      throw e;
    }
  }

  Future<SubCategoryListModel> getSubCategorylist(int catId) async {
    try {
      var response = await dio.request(Api.baseUrl + Api.subCategoryList,
          options: Options(
            method: 'Post',
          ),
          data: {"cat_id": catId});

      if (response.statusCode == 200) {
        print(response.data);

        if (response.data is String) {
          Map<String, dynamic> jsonData = json.decode(response.data);
          return SubCategoryListModel.fromJson(jsonData);
        } else if (response.data is Map<String, dynamic>) {
          return SubCategoryListModel.fromJson(response.data);
        } else {
          throw Exception('Unexpected response type');
        }
      } else {
        return SubCategoryListModel.fromJson(response.data);
      }
    } catch (e) {
      print('Dio Error: $e');

      throw e;
    }
  }

  Future<SubCategoryProductListModel> getPrdouctBySubcategory(int catId) async {
    try {
      var response = await dio.request(Api.baseUrl + Api.subCategoryProductList,
          options: Options(
            method: 'Post',
          ),
          data: {"categoryid": catId, "index": 0});

      if (response.statusCode == 200) {
        print(response.data);
        if (response.data != null) {}
        if (response.data is String) {
          Map<String, dynamic> jsonData = json.decode(response.data);
          return SubCategoryProductListModel.fromJson(jsonData);
        } else if (response.data is Map<String, dynamic>) {
          return SubCategoryProductListModel.fromJson(response.data);
        } else {
          throw Exception('Unexpected response type');
        }
      } else {
        return SubCategoryProductListModel.fromJson(response.data);
      }
    } catch (e) {
      print('Dio Error: $e');

      throw e;
    }
  }
}
