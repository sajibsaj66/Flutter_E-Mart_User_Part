import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/widgets_common/our_button.dart';
import 'package:flutter/services.dart';

Widget exitDialog(context) {
  return Dialog(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        10.heightBox,
        'Confirm'.text.fontFamily(bold).size(20).make(),
        25.heightBox,
        'Are you sure to exit?'.text.size(15).make(),
        22.heightBox,
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ourButton(
                our_title: 'No',
                our_color: Colors.orange,
                our_onPress: () {
                  Navigator.pop(context);
                }),
            ourButton(
                our_title: 'Yes',
                our_color: Colors.orange,
                our_onPress: () {
                  SystemNavigator.pop();
                })
          ],
        ),
        20.heightBox
      ],
    ).box.make(),
  );
}
