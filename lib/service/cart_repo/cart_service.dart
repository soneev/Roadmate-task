import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:partnerapp/model/cart_list_model.dart';
import 'package:partnerapp/model/cart_success_model.dart';
import 'package:partnerapp/utils/route/service_utils.dart';

class CartService {
  final dio = Dio();

  Future<CartSuccessModel> addToCart(int proId, int qty) async {
    try {
      var response = await dio.request(Api.baseUrl + Api.addtoCart,
          options: Options(
            method: 'Post',
          ),
          data: {"shop_id": Api.shopId, "product_id": proId, "qty": qty});

      if (response.statusCode == 200) {
        print(response.data);

        if (response.data is String) {
          Map<String, dynamic> jsonData = json.decode(response.data);
          return CartSuccessModel.fromJson(jsonData);
        } else if (response.data is Map<String, dynamic>) {
          return CartSuccessModel.fromJson(response.data);
        } else {
          throw Exception('Unexpected response type');
        }
      } else {
        return CartSuccessModel.fromJson(response.data);
      }
    } catch (e) {
      print('Dio Error: $e');

      throw e;
    }
  }

  Future<CartListModel> getCart() async {
    try {
      var response = await dio.request(Api.baseUrl + Api.cart,
          options: Options(
            method: 'Post',
          ),
          data: {
            "shop_id": Api.shopId,
          });

      if (response.statusCode == 200) {
        print("cart datat---->${response.data}");

        if (response.data is String) {
          Map<String, dynamic> jsonData = json.decode(response.data);
          return CartListModel.fromJson(jsonData);
        } else if (response.data is Map<String, dynamic>) {
          return CartListModel.fromJson(response.data);
        } else {
          throw Exception('Unexpected response type');
        }
      } else {
        return CartListModel.fromJson(response.data);
      }
    } catch (e) {
      print('Dio Error: $e');

      throw e;
    }
  }

  Future<void> delete(int cartId) async {
    try {
      var response = await dio.request(Api.baseUrl + Api.cartDelete,
          options: Options(
            method: 'Post',
          ),
          data: {
            "id": cartId,
          });

      if (response.statusCode == 200) {
        print(response.data);
      } else {}
    } catch (e) {
      print('Dio Error: $e');

      throw e;
    }
  }
}
