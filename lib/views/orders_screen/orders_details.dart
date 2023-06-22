import 'package:emart_app/consts/consts.dart';
import 'package:emart_app/views/orders_screen/components/order_place_details.dart';
import 'package:emart_app/views/orders_screen/components/order_status.dart';
import 'package:intl/intl.dart' as intl;

class OrdersDetails extends StatelessWidget {
  final dynamic data;
  const OrdersDetails({this.data, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(title: 'Order Details'.text.fontFamily(semibold).make()),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          children: [
            orderStatus(
                color: redColor,
                icon: Icons.done,
                title: 'Order placed',
                showDone: data['order_placed']),
            orderStatus(
                color: Colors.blue,
                icon: Icons.thumb_up,
                title: 'Confirmed',
                showDone: data['order_confirmed']),
            orderStatus(
                color: Colors.black,
                icon: Icons.emoji_transportation,
                title: 'On Delivery',
                showDone: data['order_on_delivery']),
            orderStatus(
                color: Colors.purple,
                icon: Icons.done_all_rounded,
                title: 'Delivered',
                showDone: data['order_delivered']),
            Divider(),
            Column(
              children: [
                10.heightBox,
                orderPlaceDetails(
                    title1: 'Order code',
                    title2: 'Shipping Method',
                    detail1: data['order_code'],
                    detail2: data['shipping_method']),
                10.heightBox,
                orderPlaceDetails(
                    title1: 'Order date',
                    title2: 'Payment Method',
                    detail1: intl.DateFormat("dd-mm-yyyy  h:mma")
                        .format((data['order_date'].toDate())),
                    detail2: data['payment_method']),
                10.heightBox,
                orderPlaceDetails(
                    title1: 'Payment Status',
                    title2: 'Delivery Status',
                    detail1: 'Unpaid',
                    detail2: 'Order placed'),
                15.heightBox,
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Row(
                    children: [
                      Container(
                        width: 170,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            'Shipping Address'
                                .text
                                .fontFamily(bold)
                                .color(purple2)
                                .size(18)
                                .make(),
                            5.heightBox,
                            'Name: '.text.fontFamily(bold).make(),
                            '${data['order_by_name']}'.text.make(),
                            'Email: '.text.fontFamily(bold).make(),
                            '${data['order_by_email']}'.text.make(),
                            'Phone: '.text.fontFamily(bold).make(),
                            '${data['order_by_phone']}'.text.make(),
                            'Address: '.text.fontFamily(bold).make(),
                            '${data['order_by_address']}'.text.make(),
                            'City: '.text.fontFamily(bold).make(),
                            '${data['order_by_city']}'.text.make(),
                            'State: '.text.fontFamily(bold).make(),
                            '${data['order_by_state']}'.text.make(),
                            'Postal Code: '.text.fontFamily(bold).make(),
                            '${data['order_by_postalCode']}'.text.make(),
                            10.heightBox
                          ],
                        ),
                      ),
                      Container(
                        width: 160,
                        child: Column(
                          children: [
                            'Total Amount'
                                .text
                                .fontFamily(bold)
                                .color(purple2)
                                .size(20)
                                .make(),
                            10.heightBox,
                            '${data['total_amount']}'
                                .text
                                .color(redColor)
                                .fontFamily(bold)
                                .size(25)
                                .make()
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ).box.outerShadowMd.white.make(),
            Divider(),
            10.heightBox,
            'Ordered product'
                .text
                .fontFamily(semibold)
                .color(darkFontGrey)
                .size(20)
                .make(),
            ListView(
              physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              children: List.generate(data['orders'].length, (index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    orderPlaceDetails(
                        title1: data['orders'][index]['title'],
                        title2: data['orders'][index]['tprice'],
                        detail1: '${data['orders'][index]['qty']} x', detail2: 'Refundable'),
                  Container(
                    width: 30,
                    height: 15,
                    color: Color(data['orders'][index]['color'])
                  ),
                    Divider(),
                  ],
                ).box.outerShadowMd.white.make();

              }).toList(),
            ).box.outerShadowMd.margin(EdgeInsets.only(bottom: 4)).make(),
            
            20.heightBox,

          ],
        ),
      ),
    );
  }
}
