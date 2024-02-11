import 'package:carousel_slider/carousel_slider.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:partnerapp/feature/product/product_provider.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:partnerapp/feature/product_detail/product_detail_provider.dart';
import 'package:partnerapp/mixins/snackbar_mixin.dart';
import 'package:partnerapp/model/product_list_model.dart';
import 'package:partnerapp/utils/route/color/app_colors.dart';
import 'package:partnerapp/utils/route/route_name.dart';
import 'package:partnerapp/widgets/customButton.dart';
import 'package:partnerapp/widgets/custom_image.dart';
import 'package:partnerapp/widgets/custom_text.dart';
import 'package:provider/provider.dart';

class ProductDetail extends StatefulWidget {
  // final int id;
  const ProductDetail({
    super.key,
    //  required this.id
  });

  @override
  State<ProductDetail> createState() => _ProductDetailState();
}

class _ProductDetailState extends State<ProductDetail> with SnackbarMixin {
  late CarouselController _carouselController;

  @override
  void initState() {
    _carouselController = CarouselController();
    // WidgetsBinding.instance.addPostFrameCallback((_) async {
    //   await Provider.of<DetailProvider>(context, listen: false)
    //       .getProduct(widget.id);
    // });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final detailProvider = Provider.of<DetailProvider>(context, listen: false);
    final staticProvider = Provider.of<ProductProvider>(context, listen: false);

    return SafeArea(
      child: Container(
        color: Colors.grey.withOpacity(0.1),
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.grey.withOpacity(0.1),
            automaticallyImplyLeading: false,
            elevation: 0,
            title: Row(
              children: [
                GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: const Icon(
                    Icons.arrow_back_ios,
                    color: Colors.black,
                  ),
                ),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 5),
                    child: CustomText(
                      "Deliver to:",
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  Row(
                    children: [
                      const Icon(
                        Icons.location_on,
                        color: Colors.red,
                        size: 20,
                      ),
                      CustomText(
                        "My Shop",
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                      const Icon(
                        Icons.keyboard_arrow_down_rounded,
                        size: 20,
                        color: Colors.black,
                      )
                    ],
                  )
                ]),
              ],
            ),
            actions: [
              const Padding(
                  padding: EdgeInsets.all(5.0),
                  child: Icon(
                    Icons.favorite_border,
                    size: 30,
                    color: Colors.black,
                  )),
              Padding(
                padding: const EdgeInsets.only(
                    top: 5, bottom: 5, right: 20, left: 10),
                child: CustomSvgImage(
                  imageName: 'cart',
                ),
              ),
            ],
          ),
          body: Consumer<DetailProvider>(builder: (context, provider, child) {
            if (provider.isLoading) {
              return const Center(child: CircularProgressIndicator());
            } else {
              int currentIndex = detailProvider.currentIndex.toInt();
              int dotsCount = detailProvider.productdetails[0].images == null
                  ? 1
                  : detailProvider.productdetails[0].images!.length;
              // widget.data.images == null ? 1 : widget.data.images!.length;

              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(10, 5, 10, 5),
                  child: provider.productdetails.isEmpty
                      ? const Center(child: CircularProgressIndicator())
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(2.0),
                              child: CarouselSlider.builder(
                                carouselController: _carouselController,
                                itemCount:
                                    provider.productdetails[0].images!.length,
                                // widget.data.images != null
                                //     ? widget.data.images!.length
                                //     : 1,
                                itemBuilder: (BuildContext context, int index,
                                    int realIndex) {
                                  return Container(
                                    width: 350,
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(20),
                                        border: Border.all(
                                            color: Colors.grey.withOpacity(0.1),
                                            width: 1),
                                        boxShadow: const [
                                          BoxShadow(
                                            color: Color(0x7fe0e0e0),
                                            offset: Offset(5, 5),
                                            blurRadius: 20,
                                          ),
                                        ]),
                                    child: CachedImageLoader(
                                      boxFit: BoxFit.contain,
                                      imageUrl: provider
                                          .productdetails[0].images![index],
                                      // productProvider
                                      //     .shopifyProduct!.images![index].src
                                      //     .toString(),
                                      width: 1.sw,
                                    ),
                                  );
                                },
                                options: CarouselOptions(
                                  onPageChanged: (index, reason) {
                                    detailProvider.setPageIndex(index);
                                  },
                                  height: 250,
                                  autoPlay: false,
                                  enlargeCenterPage: false,
                                  viewportFraction: 1.3,
                                  aspectRatio: 4 / 3,
                                  initialPage: 0,
                                ),
                              ),
                            ),
                            Center(
                              child: DotsIndicator(
                                  decorator: const DotsDecorator(
                                      activeColor: Colors.red),
                                  dotsCount: dotsCount,

                                  // widget.products!.images!.length,
                                  position: currentIndex),
                            ),
                            Row(
                              children: [
                                Flexible(
                                  child: Text(
                                    provider.productdetails[0].productName!,
                                    style: GoogleFonts.rubik(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                const Spacer(),
                                RatingBar.builder(
                                  initialRating: 3,
                                  minRating: 1,
                                  direction: Axis.horizontal,
                                  allowHalfRating: false,
                                  itemCount: 4,
                                  itemSize: 20,
                                  itemPadding: const EdgeInsets.symmetric(
                                      horizontal: 1.0),
                                  itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Color(0xffB7DD29),
                                  ),
                                  onRatingUpdate: (rating) {},
                                ),
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: CustomText(
                                provider.productdetails[0].description,
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            offerCard(),
                            Row(
                              children: [
                                const Icon(
                                  Icons.location_on,
                                  color: Colors.red,
                                ),
                                CustomText(
                                  "Test Shop, 34/2246 kalamassery",
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                ),
                                const Spacer(),
                                CustomText(
                                  "Change",
                                  fontSize: 14,
                                  fontWeight: FontWeight.normal,
                                  color: Colors.red,
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              child: Container(
                                  width: 1.sw,
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(
                                          color: Colors.grey, width: 1)),
                                  height: 30,
                                  child: Row(
                                    children: [
                                      CustomText(
                                        "Available coupons for you",
                                        fontSize: 12,
                                      ),
                                      const Spacer(),
                                      const Icon(
                                        Icons.arrow_forward_ios_rounded,
                                        size: 15,
                                      )
                                    ],
                                  )),
                            ),
                            Row(
                              children: [
                                Expanded(
                                  child: CustomButtonBase(
                                    borderColor: Colors.black,
                                    color: Colors.white,
                                    textColor: Colors.black,
                                    text: "Add to cart",
                                    height: 40,
                                    width: 1.sw,
                                    onTap: () {
                                      int id = detailProvider
                                          .productdetails[0].id!
                                          .toInt();
                                      if (id != null) {
                                        staticProvider.addToCart(
                                            proId: detailProvider
                                                .productdetails[0].id!
                                                .toInt(),
                                            qty: 1);
                                        Navigator.pushNamed(
                                          context,
                                          RouteName.cartScreenRoute,
                                        );
                                      } else {
                                        showErrorSnackbar(context,
                                            title: "error",
                                            message: "Error occured");
                                      }
                                    },
                                  ),
                                ),
                                Expanded(
                                  child: CustomButton(
                                    textcolor: Colors.white,
                                    color: AppColors.buttonColor,
                                    text: "BuyNow",
                                    height: 40,
                                    width: 1.sw,
                                    onTap: () {},
                                  ),
                                )
                              ],
                            )
                          ],
                        ),
                ),
              );
            }
          }),
        ),
      ),
    );
  }

  Widget offerCard() {
    final productProvider = Provider.of<DetailProvider>(context, listen: false);
    return Container(
      padding: const EdgeInsets.all(10),
      height: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomText(
            "Exclusive Launch Offer",
            fontSize: 12,
            fontWeight: FontWeight.normal,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: Row(
              children: [
                CustomText(
                  "₹${productProvider.productdetails[0].offerPrice.toString()}",
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  productProvider.productdetails[0].price.toString(),
                  style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.normal,
                      color: Colors.grey,
                      decoration: TextDecoration.lineThrough),
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
          ),
          Row(
            children: [
              const CustomPngImage(
                imageName: 'tag',
                height: 10,
                width: 10,
              ),
              RichText(
                  text: const TextSpan(children: [
                TextSpan(
                    text: "Get assured",
                    style: TextStyle(color: Colors.black, fontSize: 12)),
                TextSpan(
                    text: "10% off",
                    style: TextStyle(color: Colors.red, fontSize: 12)),
                TextSpan(
                    text: "Every orders",
                    style: TextStyle(color: Colors.black, fontSize: 12)),
              ]))
            ],
          )
        ],
      ),
    );
  }
}
