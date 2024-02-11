import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:partnerapp/feature/product/product_provider.dart';
import 'package:partnerapp/widgets/custom_app_bar.dart';
import 'package:partnerapp/widgets/custom_image.dart';
import 'package:partnerapp/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final staticProvider = Provider.of<ProductProvider>(context, listen: false);
    return Scaffold(
      appBar: CustomAppBar(
          leading: GestureDetector(
              onTap: () {
                Navigator.of(context).pop();
              },
              child: const Icon(
                Icons.arrow_back_ios_new,
                color: Colors.black,
              )),
          title: "Cart"),
      body: Consumer<ProductProvider>(builder: (context, provider, child) {
        return provider.isLoading
            ? const Center(child: CircularProgressIndicator())
            : SizedBox(
                height: 600,
                child: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(),
                    itemCount: provider.cartList!.length,
                    itemBuilder: (context, index) {
                      var item = provider.cartList![index];
                      return Padding(
                        padding: const EdgeInsets.all(10),
                        child: Stack(
                          children: [
                            Container(
                              height: 150,
                              decoration: BoxDecoration(
                                  boxShadow: const [
                                    BoxShadow(
                                      color: Color(0x7fe0e0e0),
                                      offset: Offset(5, 5),
                                      blurRadius: 20,
                                    ),
                                  ],
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                children: [
                                  Row(
                                    children: [
                                      CachedImageLoader(
                                        imageUrl: item.images.toString(),
                                        height: 100,
                                        width: 100,
                                        boxFit: BoxFit.contain,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 10),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            SizedBox(
                                              width: 150,
                                              child: Text(
                                                item.productName!,
                                                style: GoogleFonts.rubik(
                                                  fontSize: 14,
                                                  fontWeight: FontWeight.w500,
                                                ),
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                            Padding(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                vertical: 5,
                                              ),
                                              child: Row(
                                                children: [
                                                  CustomText(
                                                    "₹${item.offerPrice.toString()}",
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    item.price.toString(),
                                                    style: const TextStyle(
                                                        fontSize: 14,
                                                        fontWeight:
                                                            FontWeight.normal,
                                                        color: Colors.grey,
                                                        decoration:
                                                            TextDecoration
                                                                .lineThrough),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  CustomText(
                                                    "10% off",
                                                    fontSize: 14,
                                                    fontWeight: FontWeight.w500,
                                                    color: Colors.red,
                                                  )
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Container(
                                          height: 50,
                                          decoration: const BoxDecoration(
                                              color: Colors.white,
                                              borderRadius: BorderRadius.only(
                                                  bottomLeft:
                                                      Radius.circular(10))),
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Row(
                                              children: [
                                                CustomText("Qty"),
                                                const Spacer(),
                                                CustomText("1"),
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 10, right: 10),
                                                  child: Icon(
                                                      Icons.arrow_drop_down),
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          height: 50,
                                          decoration: const BoxDecoration(
                                              color: Colors.red,
                                              borderRadius: BorderRadius.only(
                                                  bottomRight:
                                                      Radius.circular(10))),
                                          child: CustomText("whsilist"),
                                        ),
                                      )
                                    ],
                                  )
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                staticProvider.deleteCartItem(item.id!.toInt());
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Align(
                                  alignment: Alignment.topRight,
                                  child: CircleAvatar(
                                      radius: 8,
                                      backgroundColor: Colors.red,
                                      child: Icon(
                                        Icons.close,
                                        color: Colors.white,
                                        size: 10,
                                      )),
                                ),
                              ),
                            )
                          ],
                        ),
                      );
                    }));
      }),
    );
  }
}
