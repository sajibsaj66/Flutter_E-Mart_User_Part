import 'package:emart_app/consts/consts.dart';

Widget ourButton({
  our_onPress,
  our_color,
  our_textColor,
  String? our_title,
}) {
  return ElevatedButton(
    style: ElevatedButton.styleFrom(
        backgroundColor: our_color, padding: EdgeInsets.all(14)),
    onPressed: our_onPress,
    child:
        our_title!.text.color(our_textColor).fontFamily(bold).size(16).make(),
    //? We had to use String? in the parameter to use our_title! as text
  );
}
