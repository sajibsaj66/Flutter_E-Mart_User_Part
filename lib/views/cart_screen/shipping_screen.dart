import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/cart_controller.dart';
import 'package:emart_app/views/cart_screen/payment_method.dart';
import 'package:emart_app/widgets_common/custom_textField.dart';
import 'package:emart_app/widgets_common/our_button.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

class ShippingScreen extends StatelessWidget {
  const ShippingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<CartController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: 'Shipping info'
            .text
            .color(darkFontGrey)
            .fontFamily(semibold)
            .make(),
      ),
      bottomNavigationBar: SizedBox(
        height: 60,
        child: ourButton(
            our_onPress: () {
              if (controller.addressController.text.length > 10) {
                Get.to(() => PaymentMethods());
              } else {
                VxToast.show(context, msg: 'Please, Fill the form');
              }
            },
            our_color: redColor,
            our_textColor: whiteColor,
            our_title: 'Continue'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(children: [
          customTextField(
              hint: 'Address',
              isPass: false,
              title: 'Address',
              controller: controller.addressController),
          customTextField(
              hint: 'City',
              isPass: false,
              title: 'City',
              controller: controller.cityController),
          customTextField(
              hint: 'State',
              isPass: false,
              title: 'State',
              controller: controller.stateController),
          customTextField(
              hint: 'Postal code',
              isPass: false,
              title: 'Postal code',
              controller: controller.postalCodeController),
          customTextField(
              hint: 'Phone',
              isPass: false,
              title: 'Phone',
              controller: controller.phoneController),
        ]),
      ),
    );
  }
}
