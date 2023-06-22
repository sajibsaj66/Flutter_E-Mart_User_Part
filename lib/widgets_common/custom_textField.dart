import 'package:emart_app/consts/consts.dart';

Widget customTextField({String? title, String? hint, isPass, controller}) {
  return Column(
    children: [
      title!.text.orange600.fontFamily(semibold).size(16).make(),
      5.heightBox,
      TextFormField(
        controller: controller,
        obscureText: isPass,
        decoration: InputDecoration(
          hintText: hint,
          hintStyle: const TextStyle(
            fontFamily: semibold,
            color: textfieldGrey,
          ),
          isDense: true,
          fillColor: lightGrey,
          filled: true,
          border: InputBorder.none,
          focusedBorder:
              const OutlineInputBorder(borderSide: BorderSide(color: redColor)),
        ),
      ),
      15.heightBox,
    ],
  );
}
