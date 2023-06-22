import 'package:emart_app/consts/consts.dart';

Widget bgWidget({Widget? bgWidget_child}) {
  return Container(
    decoration: BoxDecoration(
      image:
          DecorationImage(image: AssetImage(imgBackground), fit: BoxFit.fill),
    ),
    child: bgWidget_child,
    //! here the bgWidget_child is the child, which we will show on the login screen
  );
}
