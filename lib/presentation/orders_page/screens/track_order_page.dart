import 'package:flutter/material.dart';
import 'package:order_tracker/order_tracker.dart';
import 'package:shoe_rack_ecommerce/model/order_functions.dart';

import '../../common_widget/AppBarWidget.dart';

class TextDtoa {
  final String? text;
  final String? text2;

  TextDtoa(this.text, this.text2);
}

// ignore: must_be_immutable
class TrackOrderScreen extends StatelessWidget {
  TrackOrderScreen({super.key, required this.orderId});
  final String orderId;
  ValueNotifier statusIndexNotifier = ValueNotifier(0);
  final orderStatus = [
    Status.order,
    Status.shipped,
    Status.outOfDelivery,
    Status.delivered
  ];
  @override
  Widget build(BuildContext context) {
    // List<TextDtoa>? orderList = [
    //   TextDtoa("Your order has been placed", "Fri, 25th Mar '22 - 10:47pm"),
    //   TextDtoa("Seller ha processed your order", "Sun, 27th Mar '22 - 10:19am"),
    //   TextDtoa("Your item has been picked up by courier partner.",
    //       "Tue, 29th Mar '22 - 5:00pm"),
    // ];

    List<TextDto>? shippedList = [
      TextDto("Your order has been shipped", "Tue, 29th Mar '22 - 5:04pm"),
      TextDto("Your item has been received in the nearest hub to you.", null),
    ];
    List<TextDto>? orderList = [
      TextDto("Your order has been shipped", "Tue, 29th Mar '22 - 5:04pm"),
      TextDto("Your item has been received in the nearest hub to you.", null),
    ];

    List<TextDto> outOfDeliveryList = [
      TextDto("Your order is out for delivery", "Thu, 31th Mar '22 - 2:27pm"),
    ];

    List<TextDto> deliveredList = [
      TextDto("Your order has been delivered", "Thu, 31th Mar '22 - 3:58pm"),
    ];
    return SafeArea(
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBarWidget(title: 'Track Order'),
        ),
        body: FutureBuilder(
            future: getOrderStatus(orderId),
            builder: (context, orderSnapshot) {
              if (orderSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (orderSnapshot.hasError) {
                return Text('Error: ${orderSnapshot.error}');
              }
              if (orderSnapshot.hasData) {
                final status = orderSnapshot.data!['orderStatus'];
                if (status == 'Placed') {
                  statusIndexNotifier.value = 0;
                } else if (status == 'Shipped') {
                  statusIndexNotifier.value = 1;
                } else if (status == 'Out of Delivery') {
                  statusIndexNotifier.value = 2;
                } else if (status == 'Delivered') {
                  statusIndexNotifier.value = 3;
                }
              }
              return ValueListenableBuilder(
                valueListenable: statusIndexNotifier,
                builder: (context, value, child) {
                  return Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.only(left: 22.0),
                        child: Text(
                          'Your Order',
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: OrderTracker(
                          status: orderStatus[value],
                          activeColor: Colors.green,
                          inActiveColor: Colors.grey[300],
                          orderTitleAndDateList: orderList,
                          shippedTitleAndDateList: shippedList,
                          outOfDeliveryTitleAndDateList: outOfDeliveryList,
                          deliveredTitleAndDateList: deliveredList,
                        ),
                      ),
                    ],
                  );
                },
              );
            }),
      ),
    );
  }
}
