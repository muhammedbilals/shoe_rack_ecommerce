import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce/core/colors/colors.dart';
import 'package:shoe_rack_ecommerce/core/constant/constant.dart';
import 'package:shoe_rack_ecommerce/core/icons/custom_icon_icons.dart';
import 'package:shoe_rack_ecommerce/presentation/cart_page/widgets/cartdetailswidget.dart';
import 'package:shoe_rack_ecommerce/presentation/cart_page/widgets/shippingadresswidget.dart';
import 'package:shoe_rack_ecommerce/presentation/common_widget/AppBarWidget.dart';

class CheckoutScreen extends StatelessWidget {
  const CheckoutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBarWidget(title: 'Checkout'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // shipping address-----------
                const Padding(
                  padding: EdgeInsets.only(left: 12.0),
                  child: Text(
                    'Shipping Address',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                sbox,
                // ShippingAddressWidget--------------------
                const ShippingAddressWidget(),
                const Padding(
                  padding: EdgeInsets.only(left: 12.0),
                  child: Text(
                    'Order List',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                sbox,
                // products in the cart----------
                const CartDetailsWidget(),
                sbox,
                sbox,

                const CartDetailsWidget(),
                sbox,
                sbox,

                const CartDetailsWidget(),
                sbox,
                sbox,

                const CartDetailsWidget(),
                sbox,
                sbox,

                const Padding(
                  padding: EdgeInsets.only(left: 12.0),
                  child: Text(
                    'Amount',
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                sbox,
                Center(
                  child: Container(
                    width: size.width * 0.9,
                    height: size.width * 0.37,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: colorgray),
                    child: Column(
                      children: [
                        sbox,
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Amount',
                                style: TextStyle(
                                    fontSize: 18,
                                    color: colorblack.withOpacity(0.5)),
                              ),
                              const Text('₹7,500',
                                  style: TextStyle(fontSize: 18)),
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Shipping',
                                  style: TextStyle(
                                      fontSize: 18,
                                      color: colorblack.withOpacity(0.5))),
                              const Text('₹7,500',
                                  style: TextStyle(fontSize: 18)),
                            ],
                          ),
                        ),
                        Divider(
                          endIndent: 10,
                          indent: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Total',
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                      color: colorblack.withOpacity(0.5))),
                              const Text('₹7,500',
                                  style: TextStyle(fontSize: 20)),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                sbox,
                Center(
                  child: SizedBox(
                    width: size.width * 0.9,
                    height: 60,
                    child: ElevatedButton.icon(
                      style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll<Color>(colorgreen),
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ))),
                      onPressed: () {
                        // Navigator.push(
                        //     context,
                        //     MaterialPageRoute(
                        //       builder: (context) => CheckoutScreen(),
                        //     ));
                      },
                      icon: Icon(
                        CustomIcon.walleticonfluttter,
                        size: 25,
                        color: colorwhite,
                      ),
                      label: Text(
                        'Continue to Payment',
                        style: TextStyle(fontSize: 22, color: colorwhite),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
