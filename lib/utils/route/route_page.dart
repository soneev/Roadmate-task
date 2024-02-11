import 'package:flutter/material.dart';
import 'package:partnerapp/feature/cart/cart_screen.dart';
import 'package:partnerapp/feature/landing_page/landing_screen.dart';
import 'package:partnerapp/feature/product/product_list_screen.dart';
import 'package:partnerapp/feature/product_detail/product_detail_screen.dart';
import 'package:partnerapp/utils/route/route_name.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    dynamic parameterData = settings.arguments;
    switch (settings.name) {
      case RouteName.masterRunnerRoute:
        return MaterialPageRoute(builder: (context) => LandingScreen());
        break;

      case RouteName.productScreenRoute:
        return MaterialPageRoute(
            builder: (context) => const ProductListScreen());
        break;
      case RouteName.productDetailRoute:
        return MaterialPageRoute(builder: (context) => const ProductDetail());
        break;
      case RouteName.cartScreenRoute:
        return MaterialPageRoute(builder: (context) => const CartScreen());
        break;
      default:
        return MaterialPageRoute(builder: (context) => LandingScreen());
    }
  }
}
