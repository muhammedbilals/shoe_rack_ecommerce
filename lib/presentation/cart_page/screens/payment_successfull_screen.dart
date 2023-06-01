import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce/presentation/common_widget/MainButton.dart';
import 'package:shoe_rack_ecommerce/presentation/main_pages/main_pages.dart';
import 'package:shoe_rack_ecommerce/presentation/main_pages/sudo_page.dart';

class PaymentSuccessfullScreen extends StatelessWidget {
  const PaymentSuccessfullScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: size.height * 0.43),
              child: Text('Order Placed'),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(vertical: size.height * 0.005),
            child: CustomButton(text: 'Continue', widget: MainPage()),
          )
        ],
      ),
    );
  }
}
