import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/controllers/cart_controller.dart';
import 'package:emart_app/views/home_screen/home.dart';
import 'package:emart_app/widgets_common/loading_indication.dart';
import 'package:emart_app/widgets_common/our_button.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class PaymentMethods extends StatelessWidget {
  const PaymentMethods({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();

    return Obx(
      () => Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
          title: 'Choose payment method'
              .text
              .fontFamily(semibold)
              .color(darkFontGrey)
              .make(),
        ),
        bottomNavigationBar: SizedBox(
          height: 60,
          child: controller.placingOrder.value
              ? Center(
                  child: loadingIndicator(),
                )
              : ourButton(
                  our_color: redColor,
                  our_onPress: () async {
                    await controller.placeMyOrder(
                        orderPaymentMethod:
                            paymentMethods[controller.paymentIndex.value],
                        total_amount: controller.totalP.value);
                    await controller.clearCart();
                    VxToast.show(context, msg: 'Order placed successfully');
                    Get.offAll(Home());
                  },
                  our_textColor: whiteColor,
                  our_title: 'Place my order'),
        ),
        body: Obx(
          () => Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                  children: List.generate(paymentMethodsImg.length, (index) {
                return GestureDetector(
                  onTap: () {
                    controller.changePaymentIndex(index);
                  },
                  child: Stack(
                    alignment: Alignment.topRight,
                    children: [
                      Image.asset(
                        paymentMethodsImg[index],
                        width: double.infinity,
                        colorBlendMode: controller.paymentIndex.value == index
                            ? BlendMode.darken
                            : BlendMode.color,
                        color: controller.paymentIndex.value == index
                            ? Colors.black.withOpacity(0.4)
                            : Colors.transparent,
                        height: 160,
                        fit: BoxFit.cover,
                      )
                          .box
                          .margin(EdgeInsets.only(bottom: 12))
                          .rounded
                          .border(
                              color: controller.paymentIndex.value == index
                                  ? redColor
                                  : Colors.transparent,
                              width: 5)
                          .clip(Clip.antiAlias)
                          .make(),
                      controller.paymentIndex.value == index
                          ? Transform.scale(
                              scale: 1.5,
                              child: Checkbox(
                                value: true,
                                activeColor: Colors.green,
                                onChanged: (value) {},
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(60),
                                ),
                              ),
                            )
                          : Container(),
                      Positioned(
                          bottom: 23,
                          right: 15,
                          child: "${paymentMethods[index]}"
                              .text
                              .white
                              .fontFamily(bold)
                              .size(22)
                              .make()),
                    ],
                  ),
                );
              }))),
        ),
      ),
    );
  }
}
