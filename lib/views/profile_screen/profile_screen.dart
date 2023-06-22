import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/lists.dart';
import 'package:emart_app/controllers/auth_controller.dart';
import 'package:emart_app/controllers/profile_controller.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/views/auth_screen/login_screen.dart';
import 'package:emart_app/views/chat_screen/messaging_screen.dart';
import 'package:emart_app/views/orders_screen/orders_screen.dart';
import 'package:emart_app/views/profile_screen/components/details_card.dart';
import 'package:emart_app/views/profile_screen/edit_profile_screen.dart';
import 'package:emart_app/views/wishlist_screen/wishlist_screen.dart';
import 'package:emart_app/widgets_common/bg_widget.dart';
import 'package:emart_app/widgets_common/loading_indication.dart';

import '../../consts/consts.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return bgWidget(
        bgWidget_child: Scaffold(
            body: StreamBuilder(
                stream: FirestoreServices.getUser(currentUser!.uid),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (!snapshot.hasData) {
                    return CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation(purple2),
                    );
                  } else {
                    var data = snapshot.data!.docs[0];

                    return SafeArea(
                        child: Container(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      child: Column(
                        children: [
                          //edit profile
                          Row(
                            children: [
                              Spacer(),
                              IconButton(
                                  onPressed: () {
                                    controller.nameController.text =
                                        data['name'];
                                    Get.to(() => EditProfileScreen(data: data));
                                  },
                                  icon: Icon(
                                    Icons.edit,
                                    color: whiteColor,
                                  ))
                            ],
                          ),

                          //user profile details
                          Row(
                            children: [
                              data['imageUrl'] == ''
                                  ? Image.asset(
                                      imgProfile,
                                      width: 70,
                                      fit: BoxFit.cover,
                                    ).box.roundedLg.clip(Clip.antiAlias).make()
                                  : Image.network(
                                      data['imageUrl'],
                                      width: 70,
                                      fit: BoxFit.cover,
                                    ).box.roundedLg.clip(Clip.antiAlias).make(),
                              20.widthBox,
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  "${data['name']}"
                                      .text
                                      .size(18)
                                      .white
                                      .fontFamily(semibold)
                                      .make(),
                                  5.heightBox,
                                  '${data['email']}'.text.size(15).white.make(),
                                ],
                              ),
                              Spacer(),
                              OutlinedButton(
                                  style: OutlinedButton.styleFrom(
                                      backgroundColor: purple2,
                                      side: BorderSide(
                                          color: redColor, width: 2)),
                                  onPressed: () async {
                                    await Get.put(
                                        AuthController().signOut(context));
                                    Get.offAll(() => LoginScreen());
                                  },
                                  child: 'Log out'
                                      .text
                                      .fontFamily(semibold)
                                      .size(16)
                                      .white
                                      .make())
                            ],
                          ),
                          20.heightBox,

                          FutureBuilder(
                              future: FirestoreServices.getCounts(),
                              builder: (BuildContext context,
                                  AsyncSnapshot snapshot) {
                                if (!snapshot.hasData) {
                                  return Center(
                                    child: loadingIndicator(),
                                  );
                                } else {
                                  var countData = snapshot.data;

                                  return Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      detailsCard(
                                        width: context.screenWidth / 3.4,
                                        count: countData[0].toString(),
                                        title: "In your cart",
                                      ),
                                      detailsCard(
                                        width: context.screenWidth / 3.4,
                                        count: countData[1].toString(),
                                        title: "In your wishlist",
                                      ),
                                      detailsCard(
                                        width: context.screenWidth / 3.4,
                                        count: countData[2].toString(),
                                        title: "Your orders",
                                      ),
                                    ],
                                  );
                                }
                              }),

                          // Row(
                          //   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          //   children: [
                          //     detailsCard(
                          //       width: context.screenWidth / 3.4,
                          //       count: '${data['cart_count']}',
                          //       title: "In your cart",
                          //     ),
                          //     detailsCard(
                          //       width: context.screenWidth / 3.4,
                          //       count: '${data['wishlist_count']}',
                          //       title: "In your wishlist",
                          //     ),
                          //     detailsCard(
                          //       width: context.screenWidth / 3.4,
                          //       count: "${data['order_count']}",
                          //       title: "Your orders",
                          //     ),
                          //   ],
                          // ),

                          // Buttons section

                          30.heightBox,
                          ListView.separated(
                                  shrinkWrap: true,
                                  itemBuilder:
                                      (BuildContext context, int index) =>
                                          ListTile(
                                            onTap: (() {
                                              switch (index) {
                                                case 0:
                                                  Get.to(OrdersScreen());
                                                  break;
                                                case 1:
                                                  Get.to(WishlistScreen());
                                                  break;
                                                case 2:
                                                  Get.to(MessagesScreen());
                                                  break;
                                                default:
                                              }
                                            }),
                                            leading: Image.asset(
                                              profileButtonIcon[index],
                                              width: 20,
                                            ),
                                            title: profileButtonList[index]
                                                .text
                                                .fontFamily(semibold)
                                                .color(darkFontGrey)
                                                .make(),
                                          ),
                                  separatorBuilder: (context, index) => Divider(
                                        color: lightGrey,
                                      ),
                                  itemCount: profileButtonList.length)
                              .box
                              .white
                              .rounded
                              .padding(EdgeInsets.symmetric(horizontal: 16))
                              .shadowSm
                              .make()
                        ],
                      ),
                    ));
                  }
                })));
  }
}
