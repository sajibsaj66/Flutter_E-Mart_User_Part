import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/widgets_common/loading_indication.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:get/get.dart';

import '../category_screen/item_details.dart';

class SearchScreen extends StatelessWidget {
  final String? title;
  const SearchScreen({super.key, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: title!.text.color(darkFontGrey).make(),
      ),
      body: FutureBuilder(
        future: FirestoreServices.searchProducts(title),
        builder:
            ((BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: loadingIndicator());
          } else if (snapshot.data!.docs.isEmpty) {
            return "No products available".text.makeCentered();
          } else {
            var data = snapshot.data!.docs;
            var filteredData = data
                .where(
                  (element) => element['p_name']
                      .toString()
                      .toLowerCase()
                      .contains(title!.toLowerCase()),
                )
                .toList();
            return Padding(
              padding: EdgeInsets.all(8),
              child: Container(
                child: GridView(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 8,
                      mainAxisSpacing: 8,
                      mainAxisExtent: 250),
                  children: filteredData
                      .mapIndexed((currentValue, index) => Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.network(filteredData[index]['p_imgs'][0],
                                  height: 150, width: 200, fit: BoxFit.cover),
                              5.heightBox,
                              '${filteredData[index]['p_name']}'
                                  .text
                                  .fontFamily(semibold)
                                  .color(fontGrey)
                                  .make(),
                              5.heightBox,
                              '${filteredData[index]['p_price']}'
                                  .text
                                  .color(redColor)
                                  .bold
                                  .size(16)
                                  .make(),
                            ],
                          )
                              .box
                              .white
                              .outerShadowMd
                              .margin(EdgeInsets.all(6))
                              .make()
                              .onTap(() {
                            Get.to(ItemDetails(
                                title: '${filteredData[index]['p_name']}',
                                data: filteredData[index]));
                          }))
                      .toList(),
                ),
              ),
            );
          }
        }),
      ),
    );
  }
}
