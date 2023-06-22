import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/auth_controller.dart';
import 'package:emart_app/views/home_screen/home.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import '../../widgets_common/applogo_widget.dart';
import '../../widgets_common/custom_textField.dart';
import '../../widgets_common/our_button.dart';
import 'package:get/get.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? ischeck = false;
  var controller = Get.put(AuthController());
  //? Using Get.put method to initialize GetX controller which was extended in AuthoController class

  // Text Controllers
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();

  get socialIconLists => null;

  @override
  Widget build(BuildContext context) {
    return bgWidget(
        bgWidget_child: Scaffold(
            resizeToAvoidBottomInset: false,
            body: Center(
              child: Column(
                children: [
                  (context.screenHeight * 0.1).heightBox,
                  applogoWidget(),
                  10.heightBox,
                  "Join the $appname"
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
                            hint: NameHint,
                            title: Name,
                            isPass: false,
                            controller: nameController),
                        customTextField(
                            hint: EmailHint,
                            title: Email,
                            isPass: false,
                            controller: emailController),
                        customTextField(
                            hint: PassHint,
                            title: Pass,
                            isPass: true,
                            controller: passwordController),
                        customTextField(
                            hint: PassHint,
                            title: RetypePass,
                            isPass: true,
                            controller: passwordRetypeController),
                        Row(children: [
                          Checkbox(
                            value: ischeck,
                            onChanged: (newValue) {
                              setState(() {
                                ischeck = newValue;
                              });
                            },
                            checkColor: whiteColor,
                            activeColor: redColor,
                          ),
                          10.widthBox,
                          Expanded(
                            child: RichText(
                                text: const TextSpan(children: [
                              TextSpan(
                                  text: 'I agree to the ',
                                  style: TextStyle(
                                      fontFamily: regular, color: fontGrey)),
                              TextSpan(
                                  text: TermANDCond,
                                  style: TextStyle(
                                      fontFamily: regular, color: redColor)),
                              TextSpan(
                                  text: ' & ',
                                  style: TextStyle(
                                      fontFamily: regular, color: fontGrey)),
                              TextSpan(
                                  text: PrivacyPolicy,
                                  style: TextStyle(
                                      fontFamily: regular, color: redColor)),
                            ])),
                          ),
                        ]),
                        15.heightBox,
                        controller.isLoading(true)
                            ? CircularProgressIndicator(
                                valueColor: AlwaysStoppedAnimation(redColor),
                              )
                            : ourButton(
                                    our_color:
                                        ischeck == true ? redColor : lightGrey,
                                    our_title: SignUp,
                                    our_textColor: whiteColor,
                                    our_onPress: () async {
                                      if (ischeck != false) {
                                        try {
                                          controller.isLoading(true);
                                          await controller
                                              .signupMethod(
                                                  context: context,
                                                  email: emailController.text,
                                                  password:
                                                      passwordController.text)
                                              .then((value) {
                                            return controller.storeUserData(
                                                name: nameController.text,
                                                password:
                                                    passwordController.text,
                                                email: emailController.text);
                                          }).then((value) {
                                            VxToast.show(context,
                                                msg: loggedIn);
                                            Get.offAll(() => Home());
                                          });
                                        } catch (e) {
                                          controller.isLoading(false);
                                          auth.signOut();
                                          VxToast.show(context,
                                              msg: e.toString());
                                        }
                                      }
                                    })
                                .box
                                .rounded
                                .width(context.screenWidth - 50)
                                .make(),
                        20.heightBox,
                        //? Wrapping into Gesture detector of Velocity X
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            AlreadyHaveAccount.text.color(fontGrey).make(),
                            Login.text.make().onTap(() {
                              Get.back();
                            })
                          ],
                        )
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
