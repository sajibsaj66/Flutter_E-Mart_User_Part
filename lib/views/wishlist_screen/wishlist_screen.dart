import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/services/firestore_services.dart';
import 'package:emart_app/widgets_common/loading_indication.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
          title: 'My wishlists'
              .text
              .color(darkFontGrey)
              .fontFamily(semibold)
              .make()),
      body: StreamBuilder(
        stream: FirestoreServices.getWishlists(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(child: loadingIndicator());
          } else if (snapshot.data!.docs.isEmpty) {
            return Center(
                child: 'No orders yet'.text.color(darkFontGrey).makeCentered());
          } else {
            var data = snapshot.data!.docs;
            return ListView.builder(
                shrinkWrap: true,
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return ListTile(
                    leading: Image.network("${data[index]['p_imgs'][0]}",
                        width: 100, fit: BoxFit.cover),
                    title: '${data[index]['p_name']}'
                        .text
                        .size(16)
                        .fontFamily(semibold)
                        .make(),
                    subtitle: '${data[index]['p_price']}'.text.make(),
                    trailing: Icon(
                      Icons.favorite,
                      color: redColor,
                    ).onTap(() async {
                      await firestore
                          .collection(productsCollection)
                          .doc(data[index].id)
                          .set({
                        'p_wishlist': FieldValue.arrayRemove([currentUser!.uid])
                      }, SetOptions(merge: true));
                    }),
                  );
                });
          }
        },
      ),
    );
  }
}
