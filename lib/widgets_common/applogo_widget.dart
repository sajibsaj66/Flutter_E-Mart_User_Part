import 'package:emart_app/consts/consts.dart';

Widget applogoWidget() {
  //using velocity X
  return Image.asset(icAppLogo)
      .box
      .white
      .size(87, 87)
      .padding(EdgeInsets.all(8))
      .rounded
      .make();
}
