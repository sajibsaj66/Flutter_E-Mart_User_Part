import 'package:emart_app/consts/consts.dart';

Widget orderStatus({icon, color, showDone, title}) {
  return ListTile(
    leading: Icon(
      icon,
      color: color,
      size: 35,
    ).box.border(color: color).padding(EdgeInsets.all(4)).rounded.make(),
    trailing: SizedBox(
      height: 100,
      width: 150,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          '$title'.text.color(color).fontFamily(bold).size(18).make(),
          showDone ? Icon(Icons.done, color: redColor) : Container()
        ],
      ),
    ),
  );
}
