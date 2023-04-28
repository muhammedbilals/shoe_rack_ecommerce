import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:order_tracker/order_tracker.dart';

import '../../common_widget/AppBarWidget.dart';

class TextDtoa {
  final String? text;
  final String? text2;

  TextDtoa(this.text, this.text2);
}

class TrackOrderScreen extends StatelessWidget {
  const TrackOrderScreen({super.key});

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
        body: Column(
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
                status: Status.delivered,
                activeColor: Colors.green,
                inActiveColor: Colors.grey[300],
                orderTitleAndDateList: orderList,
                shippedTitleAndDateList: shippedList,
                outOfDeliveryTitleAndDateList: outOfDeliveryList,
                deliveredTitleAndDateList: deliveredList,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
