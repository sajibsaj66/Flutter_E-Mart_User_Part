import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/controllers/auth_controller.dart';
import 'package:emart_app/views/auth_screen/signup_screen.dart';
import 'package:emart_app/views/home_screen/home.dart';
import 'package:emart_app/widgets_common/applogo_widget.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:emart_app/widgets_common/custom_textField.dart';
import 'package:emart_app/widgets_common/our_button.dart';
import 'package:get/get.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return bgWidget(
        bgWidget_child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Center(
              child: Column(
                children: [
                  (context.screenHeight * 0.1).heightBox,
                  applogoWidget(),
                  10.heightBox,
                  "log in to $appname"
                      .text
                      .white
                      .fontFamily(bold)
                      .size(18)
                      .make(),
                  40.heightBox,
                  Obx(
                    () => Column(
                      children: [
                        customTextField(
                            hint: EmailHint,
                            title: Email,
                            isPass: false,
                            controller: controller.emailController),
                        customTextField(
                            hint: PassHint,
                            title: Pass,
                            isPass: true,
                            controller: controller.passwordController),
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () {},
                              child: ForgetPass.text.blue600.make()),
                        ),
                        5.heightBox,
                        controller.isLoading.value
                            ? CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(purple2),
                              )
                            : ourButton(
                                    our_color: purple2,
                                    our_title: Login,
                                    our_textColor: whiteColor,
                                    our_onPress: () async {
                                      controller.isLoading(true);
                                      await controller
                                          .loginMethod(context: context)
                                          .then((value) {
                                        if (value != null) {
                                          VxToast.show(context, msg: loggedIn);
                                          Get.offAll(() => Home());
                                        } else {
                                          controller.isLoading(false);
                                        }
                                      });
                                    })
                                .box
                                .rounded
                                .width(context.screenWidth - 50)
                                .make(),
                        20.heightBox,
                        CreateNewAccount.text.make(),
                        10.heightBox,
                        ourButton(
                                our_color: redGolden,
                                our_title: SignUp,
                                our_textColor: purple2,
                                our_onPress: () {
                                  Get.to(SignupScreen());
                                })
                            .box
                            .rounded
                            .width(context.screenWidth - 50)
                            .make(),
                        5.heightBox,
                        15.heightBox,
                        LoginWith.text.make(),
                        5.heightBox,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                              3,
                              (index) => Padding(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 5),
                                    child: CircleAvatar(
                                      radius: 35,
                                      backgroundColor: lightGrey,
                                      child: Image.asset(
                                        socialIconLists[index],
                                        width: 35,
                                      ),
                                    ),
                                  )),
                        ),
                        10.heightBox
                      ],
                    )
                        .box
                        .white
                        .rounded
                        .padding(const EdgeInsets.all(16))
                        .width(context.screenWidth - 70)
                        .shadowSm
                        .make(),
                  ),
                ],
              ),
            )));
  }
}
