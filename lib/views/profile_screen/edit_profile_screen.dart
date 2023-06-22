import 'dart:io';

import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/profile_controller.dart';
import 'package:emart_app/views/profile_screen/profile_screen.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:emart_app/widgets_common/custom_textField.dart';
import 'package:emart_app/widgets_common/our_button.dart';
import 'package:get/get.dart';

class EditProfileScreen extends StatelessWidget {
  final dynamic data;
  const EditProfileScreen({this.data, super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    var controller2 = Get.put(ProfileController());

    return bgWidget(
        bgWidget_child: Scaffold(
      appBar: AppBar(
        leading: IconButton(
          color: whiteColor,
          onPressed: () {
            Get.to(() => ProfileScreen());
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Obx(
        () => ListView(
          scrollDirection: Axis.vertical,
          children: [
            Column(
              children: [
                data['imageUrl'] == '' && controller.profileImgPath.isEmpty
                    ? Image.asset(
                        imgProfile,
                        width: 70,
                        fit: BoxFit.cover,
                      ).box.roundedLg.clip(Clip.antiAlias).make()
                    : data['imageUrl'] != '' &&
                            controller.profileImgPath.isEmpty
                        ? Image.network(data['imageUrl'],
                                width: 100, fit: BoxFit.cover)
                            .box
                            .roundedLg
                            .clip(Clip.antiAlias)
                            .make()
                        : Image.file(File(controller.profileImgPath.value),
                                width: 100, fit: BoxFit.cover)
                            .box
                            .roundedLg
                            .clip(Clip.antiAlias)
                            .make(),
                10.heightBox,
                ourButton(
                    our_color: purple2,
                    our_onPress: () {
                      controller.changeImage(context);
                    },
                    our_textColor: whiteColor,
                    our_title: 'Change'),
                20.heightBox,
                customTextField(
                    controller: controller.nameController,
                    hint: NameHint,
                    title: Name,
                    isPass: false),
                10.heightBox,
                customTextField(
                    controller: controller.oldpassController,
                    hint: PassHint,
                    title: oldpass,
                    isPass: true),
                10.heightBox,
                customTextField(
                    controller: controller.newpassController,
                    hint: PassHint,
                    title: newpass,
                    isPass: true),
                10.heightBox,
                controller.isLoading.value
                    ? CircularProgressIndicator()
                    : ourButton(
                            our_color: purple2,
                            our_onPress: () async {
                              controller.isLoading(true);
                              //if image is not selected
                              if (controller.profileImgPath.value.isNotEmpty) {
                                await controller.uploadProfileImg();
                              } else {
                                controller.profileImgLink = data['imageUrl'];
                              }

                              //if old password matches database
                              if (data['password'] ==
                                  controller.oldpassController.text) {
                                await controller.changeAuthPassword(
                                    email: data['email'],
                                    password: controller.oldpassController.text,
                                    newpassword:
                                        controller.newpassController.text);

                                await controller.updateProfile(
                                    imgUrl: controller.profileImgLink,
                                    name: controller.nameController.text,
                                    password:
                                        controller.newpassController.text);
                                VxToast.show(context, msg: 'Updated');
                              } else {
                                VxToast.show(context,
                                    msg: 'Wrong Old Password');
                                controller.isLoading(false);
                              }
                            },
                            our_textColor: whiteColor,
                            our_title: 'Save')
                        .box
                        .width(context.screenWidth * 0.8)
                        .make(),
              ],
            )
                .box
                .padding(EdgeInsets.all(16))
                .margin(EdgeInsets.only(top: 100, left: 12, right: 12))
                .white
                .shadowSm
                .rounded
                .make(),
          ],
        ),
      ),
    ));
  }
}
