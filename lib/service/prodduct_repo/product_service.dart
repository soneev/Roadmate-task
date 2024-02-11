import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:partnerapp/model/product_detail_model.dart';
import 'package:partnerapp/model/product_list_model.dart';
import 'package:partnerapp/utils/route/service_utils.dart';

class ProductService {
  final dio = Dio();

  Future<ProductListModel> getProductlist() async {
    try {
      var response = await dio.request(Api.baseUrl + Api.productList,
          options: Options(
            method: 'Post',
          ),
          data: {"index": 0});

      if (response.statusCode == 200) {
        print(response.data);

        if (response.data is String) {
          Map<String, dynamic> jsonData = json.decode(response.data);
          return ProductListModel.fromJson(jsonData);
        } else if (response.data is Map<String, dynamic>) {
          return ProductListModel.fromJson(response.data);
        } else {
          throw Exception('Unexpected response type');
        }
      } else {
        return ProductListModel.fromJson(response.data);
      }
    } catch (e) {
      print('Dio Error: $e');

      throw e;
    }
  }

  Future<ProductDetailModel> getProductDetail(int proId) async {
    try {
      var response = await dio.request(Api.baseUrl + Api.productdetails,
          options: Options(
            method: 'Post',
          ),
          data: {"productid": proId});

      if (response.statusCode == 200) {
        print(response.data);

        if (response.data is String) {
          Map<String, dynamic> jsonData = json.decode(response.data);
          return ProductDetailModel.fromJson(jsonData);
        } else if (response.data is Map<String, dynamic>) {
          return ProductDetailModel.fromJson(response.data);
        } else {
          throw Exception('Unexpected response type');
        }
      } else {
        return ProductDetailModel.fromJson(response.data);
      }
    } catch (e) {
      print('Dio Error: $e');

      throw e;
    }
  }
}
