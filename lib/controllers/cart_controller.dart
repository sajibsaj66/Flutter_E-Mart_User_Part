import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/controllers/home_controller.dart';
import 'package:get/get.dart';

class CartController extends GetxController {
  var totalP = 0.obs;

  var addressController = TextEditingController();
  var cityController = TextEditingController();
  var stateController = TextEditingController();
  var postalCodeController = TextEditingController();
  var phoneController = TextEditingController();
  var paymentIndex = 0.obs;

  calculate(data) {
    totalP.value = 0;
    //? if we don't take this variable, tha total value in cart will be increasing with the loop
    for (var i = 0; i < data.length; i++) {
      totalP.value = totalP.value + int.parse(data[i]['tprice'].toString());
    }
  }

  late dynamic productSnapshot;
  var products = [];
  var placingOrder = false.obs;

  changePaymentIndex(index) {
    paymentIndex.value = index;
  }

  placeMyOrder({required orderPaymentMethod, required total_amount}) async {
    placingOrder(false);
    await getProductDetails();
    await firestore.collection(ordersCollection).doc().set({
      "order_code": "34398343",
      "order_date": FieldValue.serverTimestamp(),
      "order_by": currentUser!.uid,
      "order_by_name": Get.find<HomeController>().username,
      "order_by_email": currentUser!.email,
      "order_by_address": addressController.text,
      "order_by_city": cityController.text,
      "order_by_state": stateController.text,
      "order_by_postalCode": postalCodeController.text,
      "order_by_phone": phoneController.text,
      "shipping_method": "Home Delivery",
      "payment_method": orderPaymentMethod,
      "order_placed": true,
      "order_delivered": false,
      "order_confirmed": false,
      "order_on_delivery": false,
      "total_amount": total_amount,
      "orders": FieldValue.arrayUnion(products)
    });
    placingOrder(true);
  }

  getProductDetails() {
    for (var i = 0; i < productSnapshot.length; i++) {
      products.add({
        'color': productSnapshot[i]['color'],
        'img': productSnapshot[i]['img'],
        'qty': productSnapshot[i]['qty'],
        'vendor_id': productSnapshot[i]['vendor_id'],
        'title': productSnapshot[i]['title'],
        'tprice': productSnapshot[i]['tprice']
      });
    }
  }

  clearCart() {
    for (var i = 0; i < productSnapshot.length; i++) {
      firestore.collection(cartCollection).doc(productSnapshot[i].id).delete();
    }
  }
}
