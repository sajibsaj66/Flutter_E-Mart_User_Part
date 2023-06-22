import 'package:emart_app/consts/consts.dart';

Widget orderPlaceDetails({title1, title2, detail1, detail2}) {
  return Padding(
    padding: EdgeInsets.symmetric(horizontal: 20),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                '$title1'.text.fontFamily(bold).size(17).make(),
                5.heightBox,
                '$detail1'.text.color(redColor).make(),
              ],
            ),
            SizedBox(
              width: 130,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  '$title2'.text.fontFamily(bold).size(17).make(),
                  5.heightBox,
                  '$detail2'.text.color(redColor).make(),
                ],
              ),
            ),
          ],
        ),
      ],
    ),
  );
}
