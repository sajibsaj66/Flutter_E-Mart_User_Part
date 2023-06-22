import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/controllers/product_controller.dart';
import 'package:emart_app/views/cart_screen/cart_screen.dart';
import 'package:emart_app/views/category_screen/category_details.dart';
import 'package:emart_app/views/chat_screen/chat_screen.dart';
import 'package:emart_app/widgets_common/our_button.dart';
import 'package:get/get.dart';

class ItemDetails extends StatelessWidget {
  final String? title;
  final dynamic data;
  const ItemDetails({required this.title, required this.data, super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductController>();
    return WillPopScope(
      onWillPop: () async {
        controller.resetValues();
        return true;
      },
      child: Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
            leading: IconButton(
                onPressed: () {
                  controller.resetValues();
                  Get.back();
                },
                icon: Icon(Icons.arrow_back)),
            title: title!.text.make(),
            actions: [
              IconButton(onPressed: () {}, icon: Icon(Icons.share)),
              Obx(
                () => IconButton(
                    onPressed: () {
                      if (controller.isFav.value) {
                        controller.removeFromWishlist(data.id, context);
                      } else {
                        controller.addToWishlist(data.id, context);
                        controller.isFav(true);
                      }
                    },
                    icon: Icon(Icons.favorite_outlined),
                    color: controller.isFav.value ? redColor : darkFontGrey),
              )
            ]),
        body: Column(children: [
          Expanded(
              child: Padding(
            padding: EdgeInsets.all(8),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  //vs
                  VxSwiper.builder(
                    autoPlay: true,
                    height: 350,
                    aspectRatio: 16 / 9,
                    viewportFraction: 1.0,
                    itemCount: data['p_imgs'].length,
                    itemBuilder: (context, index) {
                      return Image.network(data['p_imgs'][index],
                          width: double.infinity, fit: BoxFit.cover);
                    },
                  ),
                  10.heightBox,
                  title!.text
                      .color(darkFontGrey)
                      .fontFamily(bold)
                      .size(16)
                      .make(),
                  10.heightBox,
                  VxRating(
                    isSelectable: false,
                    value: double.parse(data['p_rating']),
                    onRatingUpdate: (value) {},
                    normalColor: textfieldGrey,
                    selectionColor: golden,
                    maxRating: 5,
                    size: 25,
                    stepInt: true,
                  ),
                  10.heightBox,
                  '${data['p_price']}'
                      .text
                      .color(redColor)
                      .fontFamily(bold)
                      .size(18)
                      .make(),
                  10.heightBox,
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            '${data['p_seller']}'
                                .text
                                .white
                                .fontFamily(semibold)
                                .make(),
                            10.heightBox,
                            'In house Brands'
                                .text
                                .color(darkFontGrey)
                                .fontFamily(semibold)
                                .make()
                          ],
                        ),
                      ),
                      const CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Icon(
                          Icons.message_rounded,
                          color: darkFontGrey,
                        ),
                      ).onTap(() {
                        Get.to(ChatScreen(),
                            arguments: [data['p_seller'], data['vendor_id']]);
                      })
                    ],
                  )
                      .box
                      .height(60)
                      .color(textfieldGrey)
                      .padding(EdgeInsets.symmetric(horizontal: 16))
                      .make(),
                  //color section
                  20.heightBox,
                  Obx(
                    () => Column(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: 'Color'.text.make(),
                            ),
                            Row(
                                children: List.generate(
                                    data['p_colors'].length,
                                    (index) => Stack(
                                          //if we use Column widget instead of stack, tick icons will be shown under colors.
                                          alignment: Alignment.center,
                                          children: [
                                            VxBox()
                                                .color(Color(
                                                        data['p_colors'][index])
                                                    .withOpacity(1.0))
                                                .size(40, 40)
                                                .roundedFull
                                                .margin(EdgeInsets.symmetric(
                                                    horizontal: 4))
                                                .make()
                                                .onTap(() {
                                              controller
                                                  .changeColorIndex(index);
                                            }),
                                            Visibility(
                                              visible: index ==
                                                  controller.colorIndex.value,
                                              child: Icon(
                                                Icons.done,
                                                color: Colors.white,
                                              ),
                                            )
                                          ],
                                        )))
                          ],
                        ).box.padding(EdgeInsets.all(8)).make(),
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: '${data['p_quantity']}'.text.make(),
                            ),
                            Obx(
                              () => Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        controller.decreaseQuantity();
                                        controller.totalPriceCalculation(
                                            int.parse(data['p_price']));
                                      },
                                      icon: Icon(Icons.remove)),
                                  controller.quantity.value.text
                                      .size(20)
                                      .fontFamily(bold)
                                      .make(),
                                  IconButton(
                                      onPressed: () {
                                        controller.increaseQuantity(
                                            int.parse(data['p_quantity']));
                                        controller.totalPriceCalculation(
                                            int.parse(data['p_price']));
                                      },
                                      icon: Icon(Icons.add)),
                                  '( ${data['p_quantity']} available )'
                                      .text
                                      .make()
                                ],
                              ),
                            )
                          ],
                        ).box.padding(EdgeInsets.all(8)).make(),
                        Row(
                          children: [
                            SizedBox(
                              width: 100,
                              child: 'Total'.text.make(),
                            ),
                            Row(
                              children: [
                                '${controller.totalPrice.value}'
                                    .text
                                    .color(redColor)
                                    .fontFamily(bold)
                                    .size(18)
                                    .make(),
                              ],
                            )
                          ],
                        ).box.padding(EdgeInsets.all(8)).make(),
                      ],
                    ).box.white.shadowSm.make(),
                  ),
                  10.heightBox,
                  'Description'
                      .text
                      .color(darkFontGrey)
                      .fontFamily(semibold)
                      .make(),
                  10.heightBox,
                  '${data['p_desc']}'.text.color(darkFontGrey).make(),
                  10.heightBox,
                  ListView(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      children: List.generate(
                          itemdetailsbuttonlist.length,
                          (index) => ListTile(
                                title: itemdetailsbuttonlist[index]
                                    .toString()
                                    .text
                                    .fontFamily(semibold)
                                    .color(darkFontGrey)
                                    .make(),
                                trailing: Icon(Icons.arrow_forward),
                              ))),

                  // Products you may like section
                  20.heightBox,
                  productsyoumaylike.text.fontFamily(bold).size(16).make(),
                  10.heightBox,
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: List.generate(
                          6,
                          (index) => Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Image.asset(imgP1,
                                      width: 150, fit: BoxFit.cover),
                                  10.heightBox,
                                  'Laptop, 8GB/1TB'
                                      .text
                                      .fontFamily(semibold)
                                      .color(fontGrey)
                                      .make(),
                                  10.heightBox,
                                  "\$500"
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
                                  .make()),
                    ),
                  )
                ],
              ).box.make(),
            ),
          )),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ourButton(
              our_color: purple2,
              our_onPress: () {
if(controller.quantity.value > 0){
  controller.addToCart(
      title: data['p_name'],
      img: data['p_imgs'][0],
      color: data['p_colors'][controller.colorIndex.value],
      qty: controller.quantity.value,
      sellername: ['p_seller'],
      tprice: controller.totalPrice.value,
      vendorId: data['vendor_id'],
      context: context);
  VxToast.show(context, msg: 'Added to cart');
  Get.to(CartScreen());
}else{
  VxToast.show(context, msg: 'Quantity can not be 0');
}
              },
              our_textColor: whiteColor,
              our_title: 'Add to cart',
            ),
          ),
        ]),
      ),
    );
  }
}
