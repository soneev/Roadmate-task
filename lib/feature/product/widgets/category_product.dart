import 'package:flutter/material.dart';
import 'package:partnerapp/feature/product/product_provider.dart';
import 'package:partnerapp/feature/product_detail/product_detail_provider.dart';
import 'package:partnerapp/feature/product_detail/product_detail_screen.dart';
import 'package:partnerapp/utils/route/route_name.dart';
import 'package:partnerapp/widgets/custom_image.dart';
import 'package:partnerapp/widgets/custom_text.dart';
import 'package:provider/provider.dart';
import 'dart:io';

class CategoryProduct extends StatelessWidget {
  const CategoryProduct({super.key});

  @override
  Widget build(BuildContext context) {
    final detailProvider = Provider.of<DetailProvider>(context, listen: false);
    final staticProvider = Provider.of<ProductProvider>(context, listen: false);
    return Consumer<ProductProvider>(builder: (context, provider, child) {
      return provider.subCategoryList.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 10),
                    child: Row(
                      children: [
                        CustomText(
                          "Shop by subcategory",
                          fontSize: 14,
                        ),
                        const Spacer(),
                        Container(
                            width: 150,
                            height: 40,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey, width: 1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            alignment: Alignment.center,
                            child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(10, 5, 10, 5),
                                child: DropdownButton<String>(
                                  hint: const Text('All'),
                                  value:
                                      staticProvider.selectedSubcategory.isEmpty
                                          ? null
                                          : staticProvider.selectedSubcategory,
                                  onChanged: (newValue) {
                                    print(newValue);
                                    staticProvider
                                        .setSelectedSubcategory(newValue!);
                                    staticProvider.getSubCategoryProductList(
                                        int.parse(newValue));
                                  },
                                  items: provider.subCategoryList.map((item) {
                                    return DropdownMenuItem<String>(
                                      value: item.id != null
                                          ? item.id.toString()
                                          : "",
                                      child: Text(item.categoryName ?? ''),
                                    );
                                  }).toList(),
                                ))),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      CustomText("Tools"),
                      Spacer(),
                      Align(
                        alignment: Alignment.topRight,
                        child: CustomSvgImage(
                          imageName: "filter",
                          height: 50,
                          width: 150,
                          boxFit: BoxFit.contain,
                        ),
                      ),
                    ],
                  ),
                  provider.subCatProductList.isEmpty
                      ? const Center(child: Text("select a subcategory"))
                      : SizedBox(
                          height: 500,
                          child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 200 / 220,
                                      crossAxisCount: 3,
                                      mainAxisExtent: 170),
                              itemCount: provider.subCatProductList.length,
                              itemBuilder: (context, index) {
                                var item = provider.subCatProductList[index];
                                return GestureDetector(
                                  onTap: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) => ProductDetail(
                                    //               data: staticProvider
                                    //                   .allProduct[index],
                                    //             )));

                                    detailProvider
                                        .getProduct(staticProvider
                                            .subCatProductList[index].id!)
                                        .then((value) => showDialog(
                                              context: context,
                                              barrierDismissible: false,
                                              builder: (BuildContext context) {
                                                return const Center(
                                                    child:
                                                        CircularProgressIndicator()); // Custom ProgressDialog widget.
                                              },
                                            ));
                                    Future.delayed(const Duration(seconds: 5),
                                        () {
                                      Navigator.pop(context);

                                      Navigator.pushNamed(
                                        context,
                                        RouteName.productDetailRoute,
                                      );
                                    });
                                  },
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(5),
                                          color: Colors.white),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          item.images!.isEmpty
                                              ? const CustomDummyImage(
                                                  height: 90,
                                                  width: 80,
                                                  boxFit: BoxFit.cover,
                                                )
                                              : CachedImageLoader(
                                                  imageUrl:
                                                      item.images.toString(),
                                                  boxFit: BoxFit.cover,
                                                  height: 90,
                                                  width: 80,
                                                ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 5, bottom: 5),
                                                child: Text(
                                                  item.productName.toString(),
                                                  style: const TextStyle(
                                                      fontSize: 14,
                                                      fontWeight:
                                                          FontWeight.bold),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                ),
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.start,
                                                children: [
                                                  CustomText(
                                                      item.price.toString(),
                                                      fontSize: 12,
                                                      fontWeight:
                                                          FontWeight.w300,
                                                      color: Colors.grey,
                                                      underline: true),
                                                  const SizedBox(
                                                    width: 2,
                                                  ),
                                                  CustomText(
                                                    '₹${item.offerPrice.toString()}',
                                                    fontSize: 12,
                                                    fontWeight: FontWeight.w300,
                                                  ),
                                                  const Spacer(),
                                                  Row(
                                                    children: [
                                                      CustomText(
                                                        "4.5",
                                                        fontSize: 12,
                                                        fontWeight:
                                                            FontWeight.w300,
                                                      ),
                                                      const Icon(
                                                        Icons.star,
                                                        size: 10,
                                                        color: Colors.amber,
                                                      )
                                                    ],
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                ],
              ),
            );
    });
  }
}
