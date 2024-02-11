import 'package:flutter/material.dart';
import 'package:partnerapp/feature/home_page/homepage_provider.dart';
import 'package:partnerapp/feature/product_detail/product_detail_provider.dart';
import 'package:partnerapp/utils/route/route_name.dart';
import 'package:partnerapp/widgets/custom_image.dart';
import 'package:partnerapp/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class FeaturedProducts extends StatelessWidget {
  const FeaturedProducts({super.key});

  @override
  Widget build(BuildContext context) {
    final detailProvider = Provider.of<DetailProvider>(context, listen: false);
    final staticProvider =
        Provider.of<HomePageProvider>(context, listen: false);

    return SizedBox(
      height: 350,
      child: Consumer<HomePageProvider>(builder: (context, value, child) {
        return value.isLoading
            ? const Center(child: CircularProgressIndicator())
            : GridView.builder(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 200 / 220,
                    crossAxisCount: 3,
                    mainAxisExtent: 170),
                itemCount:
                    value.productList.length > 6 ? 6 : value.productList.length,
                itemBuilder: (context, index) {
                  var item = value.productList[index];
                  return GestureDetector(
                    onTap: () {
                      detailProvider
                          .getProduct(item.id!)
                          .then((value) => showDialog(
                                context: context,
                                barrierDismissible: false,
                                builder: (BuildContext context) {
                                  return const Center(
                                      child:
                                          CircularProgressIndicator()); // Custom ProgressDialog widget.
                                },
                              ));
                      Future.delayed(const Duration(seconds: 5), () {
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
                            borderRadius: BorderRadius.circular(5),
                            color: Colors.white),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            // CustomImageNetwork(
                            //   imageUrl: item.images,
                            //   boxFit: BoxFit.cover,
                            //   height: 90,
                            //   width: 80,
                            // ),
                            CachedImageLoader(
                              imageUrl: item.images.toString(),
                              boxFit: BoxFit.cover,
                              height: 90,
                              width: 80,
                            ),

                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 5, bottom: 5),
                                  child: Text(
                                    item.productName.toString(),
                                    style: const TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CustomText(item.price.toString(),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w300,
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
                                          fontWeight: FontWeight.w300,
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
                });
      }),
    );
  }
}
