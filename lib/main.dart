import 'package:flutter/material.dart';
import 'package:partnerapp/feature/home_page/homepage_provider.dart';
import 'package:partnerapp/feature/landing_page/landing_provider.dart';
import 'package:partnerapp/feature/product/product_provider.dart';
import 'package:partnerapp/feature/product_detail/product_detail_provider.dart';
import 'package:partnerapp/utils/route/route_page.dart';
import 'package:provider/provider.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => LandingProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => HomePageProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => ProductProvider(),
      ),
      ChangeNotifierProvider(
        create: (context) => DetailProvider(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 800),
      minTextAdapt: true,
      splitScreenMode: true,
      useInheritedMediaQuery: true,
      builder: (context, child) => const MaterialApp(
        title: 'E-Commerce App',
        debugShowCheckedModeBanner: false,
// initialRoute: RouteName.masterRunnerRoute,
        // home: Splash(),
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
