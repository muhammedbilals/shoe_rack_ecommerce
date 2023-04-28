import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce/core/colors/colors.dart';
import 'package:shoe_rack_ecommerce/core/icons/custom_icon_icons.dart';
import 'package:shoe_rack_ecommerce/presentation/cart_page/screens/checkout_page.dart';
import 'package:shoe_rack_ecommerce/presentation/cart_page/widgets/cartdetailswidget.dart';

import '../../common_widget/AppBarWidget.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: const PreferredSize(
            preferredSize: Size.fromHeight(70),
            child: AppBarWidget(title: 'My Cart')),
        body: Stack(children: [
          ListView(
            children: [
              CartDetailsWidget( ),
              CartDetailsWidget( ),
              CartDetailsWidget( ),
              CartDetailsWidget( ),
              CartDetailsWidget( ),
            ],
          ),
          Positioned(
            left: 0,
            bottom: 0,
            child: Container(
              color: colorwhite,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Price',
                          style: TextStyle(
                              fontSize: 15, color: colorblack.withOpacity(0.5)),
                        ),
                        Text(
                          '₹7,500',
                          style: TextStyle(fontSize: 30),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: size.width * 0.72,
                        height: 60,
                        child: ElevatedButton.icon(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll<Color>(colorgreen),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ))),
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CheckoutScreen(),
                                ));
                          },
                          icon: Icon(
                            CustomIcon.ticksquareiconfluttter,
                            size: 25,
                            color: colorwhite,
                          ),
                          label: Text(
                            'Checkout',
                            style: TextStyle(fontSize: 25, color: colorwhite),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}
