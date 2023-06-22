import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/controllers/cart_controller.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/views/cart_screen/shipping_screen.dart';
import 'package:emart_app/widgets_common/loading_indication.dart';
import 'package:emart_app/widgets_common/our_button.dart';
import 'package:get/get.dart';

import '../../consts/consts.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(CartController());

    return Scaffold(
        backgroundColor: whiteColor,
        appBar: AppBar(
            title: 'Shopping Cart'
                .text
                .color(darkFontGrey)
                .fontFamily(semibold)
                .make()),
        body: StreamBuilder(
          stream: FirestoreServices.getCart(currentUser!.uid),
          builder:
              (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: loadingIndicator(),
              );
            } else if (snapshot.data!.docs.isEmpty) {
              return Center(
                child: 'Cart is empty'.text.make(),
              );
            } else {
              var data = snapshot.data!.docs;
              controller.calculate(data);
              controller.productSnapshot = data;
              return Padding(
                padding: EdgeInsets.all(8),
                child: Column(
                  children: [
                    Expanded(
                        child: ListView.builder(
                            itemCount: data.length,
                            itemBuilder: (BuildContext context, int index) {
                              return ListTile(
                                leading: Image.network("${data[index]['img']}", width: 100, fit: BoxFit.cover),
                                title:
                                    '${data[index]['title']} x ${data[index]['qty']}'
                                        .text
                                        .size(16)
                                        .fontFamily(semibold)
                                        .make(),
                                subtitle:
                                    '${data[index]['tprice']}'.text.make(),
                                trailing: Icon(
                                  Icons.delete,
                                  color: redColor,
                                ).onTap(() {
                                  FirestoreServices.deleteDocument(
                                      data[index].id);
                                }),
                              );
                            })),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        'Total Price'
                            .text
                            .fontFamily(semibold)
                            .color(darkFontGrey)
                            .size(22)
                            .make(),
                        10.widthBox,
                        Obx(
                          () => '${controller.totalP.value}'
                              .numCurrency
                              .text
                              .fontFamily(bold)
                              .color(redColor)
                              .size(25)
                              .make(),
                        )
                      ],
                    )
                        .box
                        .padding(EdgeInsets.all(12))
                        .width(context.screenWidth - 60)
                        .color(Color.fromARGB(255, 247, 212, 108))
                        .roundedSM
                        .make(),
                  ],
                ),
              );
            }
          },
        ),
        bottomNavigationBar: SizedBox(
          width: context.screenWidth - 60,
          height: 60,
          child: ourButton(
              our_onPress: () {
                Get.to(() => ShippingScreen());
              },
              our_color: redColor,
              our_textColor: whiteColor,
              our_title: 'Proceed to shipping'),
        ));
  }
}
