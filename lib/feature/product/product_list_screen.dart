import 'package:flutter/material.dart';
import 'package:partnerapp/feature/product/product_provider.dart';
import 'package:partnerapp/feature/product/widgets/category_product.dart';
import 'package:partnerapp/feature/product/widgets/custom_search_bar.dart';
import 'package:partnerapp/feature/product/widgets/view_all_products.dart';
import 'package:partnerapp/model/subcategory_list_model.dart';
import 'package:partnerapp/widgets/custom_app_bar.dart';
import 'package:partnerapp/widgets/custom_image.dart';
import 'package:partnerapp/widgets/custom_text.dart';
import 'package:provider/provider.dart';

import 'widgets/circle_tab_bar_indicator.dart';

class ProductListScreen extends StatelessWidget {
  const ProductListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final staticProvider = Provider.of<ProductProvider>(context, listen: false);
    return Scaffold(
      appBar: CustomAppBar(
        leading: GestureDetector(
            onTap: () {
              Navigator.pop(context);
            },
            child: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        title: "Featured Products",
        actions: [
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: CustomSvgImage(
              imageName: 'bell',
            ),
          ),
          Padding(
            padding:
                const EdgeInsets.only(top: 5, bottom: 5, right: 20, left: 10),
            child: CustomSvgImage(
              imageName: 'cart',
            ),
          ),
        ],
      ),
      body: Consumer<ProductProvider>(builder: (context, provider, child) {
        return DefaultTabController(
            length: provider.categoryList.length + 1,
            child: Container(
              color: Colors.grey.withOpacity(0.1),
              child: Column(
                children: [
                  provider.isSearchable
                      ? const CustomTextField()
                      : const SizedBox(),
                  const SizedBox(
                    height: 20,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: TabBar(
                      onTap: (index) {
                        staticProvider.subCatProductList.clear();
                        staticProvider.setTabIndex(index);
                        print(index.toString());
                        if (index == 0) {
                          staticProvider.setSearchbar(true);
                          staticProvider.getAllProductslist();
                        } else {
                          staticProvider.setSearchbar(false);

                          staticProvider.getSubCategoryList(
                              provider.categoryList[index - 1].id!.toInt());
                        }
                      },
                      indicatorSize: TabBarIndicatorSize.label,
                      indicator:
                          CircleTabIndicator(color: Colors.orange, radius: 4),
                      isScrollable: true,
                      padding: EdgeInsets.zero,
                      labelPadding: const EdgeInsets.only(left: 10, right: 10),
                      indicatorPadding:
                          const EdgeInsets.only(top: 20, left: 10, right: 10),
                      labelColor: Colors.red,
                      unselectedLabelColor: Colors.black,
                      tabs: List.generate(provider.categoryList.length + 1,
                          (index) {
                        if (index == 0) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Container(
                              width: 75,
                              height: 60,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  boxShadow: provider.selectedTabindex == index
                                      ? [
                                          const BoxShadow(
                                              color: Color(0x7fe0e0e0),
                                              offset: Offset(5, 5),
                                              blurRadius: 5,
                                              spreadRadius: 3),
                                        ]
                                      : [],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: const Center(
                                  child: Text(
                                "   View\nProducts",
                              )),
                            ),
                          );
                        } else {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 20),
                            child: Container(
                              width: 75,
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  boxShadow: provider.selectedTabindex == index
                                      ? [
                                          const BoxShadow(
                                              color: Color(0x7fe0e0e0),
                                              offset: Offset(5, 5),
                                              blurRadius: 5,
                                              spreadRadius: 3),
                                        ]
                                      : [],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  CustomImageNetwork(
                                    imageUrl:
                                        provider.categoryList[index - 1].image,
                                    height: 31,
                                    width: 31,
                                    boxFit: BoxFit.contain,
                                    color: provider.selectedTabindex == index
                                        ? Colors.red
                                        : Colors.black,
                                  ),
                                  Text(
                                    provider
                                        .categoryList[index - 1].categoryName
                                        .toString(),
                                    style: const TextStyle(fontSize: 12),
                                    overflow: TextOverflow.ellipsis,
                                  )
                                ],
                              ),
                            ),
                          );
                        }
                      }),
                    ),
                  ),
                  Expanded(
                    child: TabBarView(
                        physics: const NeverScrollableScrollPhysics(),
                        children: List.generate(
                            provider.categoryList.length + 1, (index) {
                          if (index == 0) {
                            return const ViewAllProducts();
                          } else {
                            return const CategoryProduct();
                          }
                        })),
                  )
                ],
              ),
            ));
      }),
    );
  }
}
