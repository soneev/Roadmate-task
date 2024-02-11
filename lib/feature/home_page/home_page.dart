import 'package:flutter/material.dart';
import 'package:partnerapp/feature/home_page/homepage_provider.dart';
import 'package:partnerapp/feature/product/product_provider.dart';
import 'package:partnerapp/utils/route/route_name.dart';

import 'package:partnerapp/widgets/custom_app_bar.dart';
import 'package:partnerapp/widgets/custom_image.dart';
import 'package:partnerapp/widgets/custom_text.dart';
import 'package:provider/provider.dart';

import 'widgets/feature_product_card.dart';
import 'package:badges/badges.dart' as badges;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    Provider.of<ProductProvider>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final staticProvider =
        Provider.of<HomePageProvider>(context, listen: false);
    final screenWidth = MediaQuery.of(context).size.width;
    const itemWidthPercentage = 0.7;
    final itemWidth = screenWidth * itemWidthPercentage;
    return Scaffold(
      backgroundColor: Colors.grey.withOpacity(0.1),
      appBar: CustomAppBar(
        title: "Good Morning",
        actions: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: CustomSvgImage(
              imageName: 'bell',
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.pushNamed(
                context,
                RouteName.cartScreenRoute,
              );
            },
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 5, bottom: 5, right: 20, left: 10),
              child:
                  Consumer<ProductProvider>(builder: (context, value, child) {
                return badges.Badge(
                  showBadge: value.cartList!.isEmpty ? false : true,
                  badgeContent: Text(
                    value.cartCount.toString(),
                    style: const TextStyle(color: Colors.black),
                  ),
                  badgeStyle: const badges.BadgeStyle(badgeColor: Colors.red),
                  child: CustomSvgImage(
                    imageName: 'cart',
                  ),
                );
              }),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(10, 20, 10, 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 120,
                child: ListView.separated(
                  separatorBuilder: (BuildContext context, int index) {
                    return const SizedBox(
                      width: 20,
                    );
                  },
                  padding: EdgeInsets.zero,
                  scrollDirection: Axis.horizontal,
                  itemCount: staticProvider.todoList.length,
                  itemBuilder: (context, index) {
                    return Container(
                      width: itemWidth / 1.55,
                      padding: const EdgeInsets.only(
                          top: 20, bottom: 20, left: 10, right: 10),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              CustomText(
                                staticProvider.todoList[index].name,
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              const Spacer(),
                              const Icon(
                                Icons.arrow_forward_ios,
                                size: 20,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomSvgImage(
                                imageName: staticProvider.todoList[index].icon,
                                height: 50,
                                width: 50,
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              Expanded(
                                child: CustomText(
                                  staticProvider.todoList[index].text,
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: CustomText("Products Categories"),
              ),
              SizedBox(
                  height: 80,
                  child: Consumer<HomePageProvider>(
                      builder: (context, value, child) {
                    return value.isLoading
                        ? const Center(child: CircularProgressIndicator())
                        : ListView.separated(
                            scrollDirection: Axis.horizontal,
                            separatorBuilder: (context, index) =>
                                const SizedBox(
                                  width: 18,
                                ),
                            itemCount: value.categoryList.length + 1,
                            itemBuilder: (context, index) {
                              if (index < value.categoryList.length) {
                                var item = value.categoryList[index];
                                return Container(
                                  width: 80,
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      CustomImageNetwork(
                                        imageUrl: item.image,
                                        height: 31,
                                        width: 31,
                                        boxFit: BoxFit.contain,
                                        color: Colors.black,
                                      ),
                                      Text(
                                        item.categoryName.toString(),
                                        style: const TextStyle(fontSize: 12),
                                        overflow: TextOverflow.ellipsis,
                                      )
                                    ],
                                  ),
                                );
                              } else {
                                return Container(
                                  width: 80,
                                  padding: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      Text(
                                        "View all",
                                        style: TextStyle(
                                            fontSize: 12,
                                            fontWeight: FontWeight.w300),
                                      ),
                                      Spacer(),
                                      Icon(
                                        Icons.arrow_forward_ios,
                                        size: 10,
                                      ),
                                    ],
                                  ),
                                );
                              }
                            });
                  })),
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  children: [
                    CustomText("Featured Products"),
                    const Spacer(),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(
                            context, RouteName.productScreenRoute);
                      },
                      child: const Text(
                        "View all",
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                    )
                  ],
                ),
              ),
              const FeaturedProducts()
            ],
          ),
        ),
      ),
    );
  }
}
