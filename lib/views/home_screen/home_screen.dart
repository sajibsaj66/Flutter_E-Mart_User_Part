import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/controllers/home_controller.dart';
import 'package:emart_app/controllers/product_controller.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/views/category_screen/item_details.dart';
import 'package:emart_app/views/home_screen/components/featured_buttons.dart';
import 'package:emart_app/views/home_screen/search_screen.dart';
import 'package:emart_app/widgets_common/home_buttons.dart';
import 'package:emart_app/widgets_common/loading_indication.dart';
import 'package:get/get.dart';

import '../../consts/consts.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<HomeController>();
    var controller2 = Get.put(ProductController());

    print(Colors.black.value);
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(12),
        color: lightGrey,
        width: context.screenWidth,
        height: context.screenHeight,
        child: SafeArea(
            child: Column(children: [
          Container(
            height: 60,
            color: lightGrey,
            child: TextFormField(
              controller: controller.searchController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  filled: true,
                  fillColor: whiteColor,
                  hintText: searchAnything,
                  hintStyle: TextStyle(color: textfieldGrey),
                  suffixIcon: Icon(Icons.search).onTap(() {
                    if (controller.searchController.text.isNotEmptyAndNotNull) {
                      Get.to(() => SearchScreen(
                            title: controller.searchController.text,
                          ));
                    } else {
                      
                    }
                  })),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Column(
                children: [
                  //Swipers Brands
                  //1st Swiper
                  VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      autoPlay: true,
                      height: 150,
                      enlargeCenterPage: true,
                      itemCount: slidersLists.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          slidersLists[index],
                          fit: BoxFit.fill,
                        )
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(EdgeInsets.symmetric(horizontal: 5))
                            .make();
                      }),
                  10.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                        2,
                        (index) => homeButtons(
                              height: context.screenHeight * 0.17,
                              width: context.screenWidth / 3,
                              title: index == 0 ? todaydeal : flashSale,
                              icon: index == 0 ? icTodaysDeal : icFlashDeal,
                            )),
                  ),
                  10.heightBox,

                  //2nd Swiper
                  VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      height: 150,
                      enlargeCenterPage: true,
                      itemCount: secondSlidersLists.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          secondSlidersLists[index],
                          fit: BoxFit.fill,
                        )
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(EdgeInsets.symmetric(horizontal: 5))
                            .make();
                      }),
                  10.heightBox,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: List.generate(
                        3,
                        (index) => homeButtons(
                            height: context.screenHeight * 0.13,
                            width: context.screenWidth * 0.25,
                            icon: index == 0
                                ? icTopCategories
                                : index == 1
                                    ? icBrands
                                    : icTopSeller,
                            title: index == 0
                                ? topCategories
                                : index == 1
                                    ? brand
                                    : topSellers)),
                  ),
                  //featured categories
                  20.heightBox,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: featuredCategories.text
                        .color(darkFontGrey)
                        .size(18)
                        .fontFamily(semibold)
                        .make(),
                  ),
                  10.heightBox,
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                          3,
                          (index) => Column(
                                children: [
                                  featuredButtons(
                                      icons: featuredImages1[index],
                                      title: featuredTitles1[index]),
                                  10.heightBox,
                                  featuredButtons(
                                      icons: featuredImages2[index],
                                      title: featuredTitles2[index])
                                ],
                              )).toList(),
                    ),
                  ),

                  //Featured Products
                  20.heightBox,
                  Container(
                    width: double.infinity,
                    padding: EdgeInsets.all(12),
                    color: purple2,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          featuredProducts.text
                              .fontFamily(bold)
                              .size(18)
                              .white
                              .make(),
                          10.heightBox,
                          SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: FutureBuilder(
                                future: FirestoreServices.getFeaturedProducts(),
                                builder: (context,
                                    AsyncSnapshot<QuerySnapshot> snapshot) {
                                  if (!snapshot.hasData) {
                                    return Center(
                                      child: loadingIndicator(),
                                    );
                                  } else if (snapshot.data!.docs.isEmpty) {
                                    return "No Featured Product"
                                        .text
                                        .white
                                        .makeCentered();
                                  } else {
                                    var featuredData = snapshot.data!.docs;

                                    return Row(
                                      children: List.generate(
                                          featuredData.length,
                                          (index) => Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Image.network(
                                                      featuredData[index]
                                                          ['p_imgs'][0],
                                                      width: 160,
                                                      height: 220,
                                                      fit: BoxFit.cover),
                                                  10.heightBox,
                                                  '${featuredData[index]['p_name']}'
                                                      .text
                                                      .fontFamily(semibold)
                                                      .color(fontGrey)
                                                      .make(),
                                                  10.heightBox,
                                                  "${featuredData[index]['p_price']}"
                                                      .numCurrency
                                                      .text
                                                      .color(redColor)
                                                      .bold
                                                      .size(16)
                                                      .make()
                                                ],
                                              )
                                                  .box
                                                  .white
                                                  .roundedSM
                                                  .margin(EdgeInsets.symmetric(
                                                      horizontal: 6))
                                                  .padding(EdgeInsets.all(8))
                                                  .make()
                                                  .onTap(() {
                                                Get.to(ItemDetails(
                                                    title:
                                                        "${featuredData[index]['p_name']}",
                                                    data: featuredData[index]));
                                              })),
                                    );
                                  }
                                }),
                          )
                        ]),
                  ),
                  10.heightBox,
                  //3rd Swiper
                  VxSwiper.builder(
                      aspectRatio: 16 / 9,
                      height: 150,
                      enlargeCenterPage: true,
                      itemCount: secondSlidersLists.length,
                      itemBuilder: (context, index) {
                        return Image.asset(
                          secondSlidersLists[index],
                          fit: BoxFit.fill,
                        )
                            .box
                            .rounded
                            .clip(Clip.antiAlias)
                            .margin(EdgeInsets.symmetric(horizontal: 5))
                            .make();
                      }),
                  20.heightBox,
                  StreamBuilder(
                      stream: FirestoreServices.allProducts(),
                      builder: (BuildContext context,
                          AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (!snapshot.hasData) {
                          return loadingIndicator();
                        } else {
                          var allProductsData = snapshot.data!.docs;
                          return GridView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: allProductsData.length,
                              gridDelegate:
                                  SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 8,
                                      mainAxisSpacing: 8,
                                      mainAxisExtent: 250),
                              itemBuilder: ((context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Image.network(
                                        allProductsData[index]['p_imgs'][0],
                                        height: 150,
                                        width: 200,
                                        fit: BoxFit.cover),
                                    Spacer(),
                                    '${allProductsData[index]['p_name']}'
                                        .text
                                        .fontFamily(semibold)
                                        .color(fontGrey)
                                        .make(),
                                    10.heightBox,
                                    '${allProductsData[index]['p_price']}'
                                        .text
                                        .color(redColor)
                                        .bold
                                        .size(16)
                                        .make()
                                  ],
                                )
                                    .box
                                    .white
                                    .roundedSM
                                    .margin(EdgeInsets.symmetric(horizontal: 6))
                                    .padding(EdgeInsets.all(8))
                                    .make()
                                    .onTap(() {
                                  Get.to(ItemDetails(
                                      title:
                                          '${allProductsData[index]['p_name']}',
                                      data: allProductsData[index]));
                                });
                              }));
                        }
                      })
                ],
              ),
            ),
          )
        ])),
      ),
    );
  }
}
