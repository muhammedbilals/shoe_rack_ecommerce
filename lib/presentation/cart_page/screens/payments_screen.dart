import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentsScreen extends StatelessWidget {
   PaymentsScreen({super.key});


  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        body: Center(
            child: Column(
      children: [
        const Text('order successfull'),
        IconButton(onPressed: () {
          
        }, icon: Icon(Icons.skip_next))
      ],
    )));
  }
}
