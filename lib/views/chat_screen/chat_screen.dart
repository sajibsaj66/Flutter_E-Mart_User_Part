import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/chats_controller.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/views/chat_screen/components/sender_bubble.dart';
import 'package:emart_app/widgets_common/loading_indication.dart';
import 'package:get/get.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ChatsController());

    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        title: '${controller.friendName}'
            .text
            .fontFamily(bold)
            .size(20)
            .color(darkFontGrey)
            .make(),
      ),
      body: Padding(
        padding: EdgeInsets.all(8),
        child: Column(
          children: [
            Container(
              child: Obx(
                () => controller.isLoading.value
                    ? Center(
                        child: loadingIndicator(),
                      )
                    : Expanded(
                        child: StreamBuilder(
                            stream: FirestoreServices.getChatMessages(
                                controller.chatDocId.toString()),
                            builder: (BuildContext context,
                                AsyncSnapshot<QuerySnapshot> snapshot) {
                              if (!snapshot.hasData) {
                                return Center(
                                  child: loadingIndicator(),
                                );
                              } else if (snapshot.data!.docs.isEmpty) {
                                return Center(
                                  child: 'Send a message...'
                                      .text
                                      .color(darkFontGrey)
                                      .make(),
                                );
                              } else {
                                return ListView(
                                  children: snapshot.data!.docs
                                      .mapIndexed((currentValue, index) {
                                    var data = snapshot.data!.docs[index];

                                    return Align(
                                        alignment:
                                            data['uid'] == currentUser!.uid
                                                ? Alignment.centerRight
                                                : Alignment.centerLeft,
                                        child: senderBubble(data));
                                  }).toList(),
                                );
                              }
                            }),
                      ),
              ),
            ),
            Row(
              children: [
                Expanded(
                    child: TextFormField(
                  controller: controller.msgController,
                  decoration: InputDecoration(
                      hintText: 'Type a message...',
                      fillColor: purple1,
                      border: OutlineInputBorder(
                          borderSide: BorderSide(color: textfieldGrey))),
                )),
                IconButton(
                    onPressed: () {
                      controller.sendMsg(controller.msgController.text);
                      controller.msgController.clear();
                    },
                    icon: Icon(
                      Icons.send,
                      color: purple2,
                    ))
              ],
            ).box.height(80).margin(EdgeInsets.only(bottom: 2)).make(),
          ],
        ),
      ),
    );
  }
}
