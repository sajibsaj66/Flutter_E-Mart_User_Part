import 'package:emart_app/consts/consts.dart';

Widget detailsCard({String? title, String? count, width}) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    children: [
      count!.text.fontFamily(bold).make(),
      5.heightBox,
      title!.text.make()
    ],
  )
      .box
      .white
      .height(70)
      .rounded
      .width(width)
      .margin(EdgeInsets.symmetric(horizontal: 2.5))
      .make();
}
