import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/models/category_model.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ProductController extends GetxController {
  var subcat = [];
  var quantity = 0.obs;
  var colorIndex = 0.obs;
  var totalPrice = 0.obs;

  var isFav = false.obs;

  getSubCategories(title) async {
    subcat.clear();
    var data = await rootBundle.loadString("lib/services/category_model.json");
    var decoded = categoryModelFromJson(data);
    //? here, data are passed to categoryModelFromJson, then all are returned to decoded

    //? categoryModelFromJson is the codes we got from the website quicktype
    var s =
        decoded.categories.where((element) => element.name == title).toList();

    for (var e in s[0].subcategories) {
      subcat.add(e); // adding e in subcat

    }
  }

  changeColorIndex(index) {
    colorIndex.value = index;
    //colorIndex.value, here .value is added to get int, because index is int, but colorIndex is RxInt.
  }

  increaseQuantity(totalQuantity) {
    if (quantity.value < totalQuantity) {
      quantity.value++;
    }
  }

  decreaseQuantity() {
    if (quantity.value > 0) {
      quantity.value--;
    }
  }

  totalPriceCalculation(price) {
    totalPrice.value = price * quantity.value;
  }

  addToCart({title, img, qty, sellername, color, tprice, vendorId, context}) async {
    await firestore.collection(cartCollection).doc().set({
      'title': title,
      'img': img,
      'qty': qty,
      'sellername': sellername,
      'color': color,
      'tprice': tprice,
      'vendor_id': vendorId,
      'added_by': currentUser!.uid
    }).catchError((error) {
      VxToast.show(context, msg: error.toString());
    });
  }

  resetValues() {
    quantity.value = 0;
    colorIndex.value = 0;
    totalPrice.value = 0;
  }

  addToWishlist(docId, context) async {
    await firestore.collection(productsCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayUnion([currentUser!.uid])
    }, SetOptions(merge: true));
    isFav(true);
    VxToast.show(context, msg: 'Added Favorite');
  }

  removeFromWishlist(docId, context) async {
    await firestore.collection(productsCollection).doc(docId).set({
      'p_wishlist': FieldValue.arrayRemove([currentUser!.uid])
    }, SetOptions(merge: true));
    isFav(false);
    VxToast.show(context, msg: 'Removed Favorite');
  }

  checkIfFav(data) async {
    if (data['p_wishlist'].contains(currentUser!.uid)) {
      isFav(true);
    } else {
      isFav(false);
    }
  }
}
