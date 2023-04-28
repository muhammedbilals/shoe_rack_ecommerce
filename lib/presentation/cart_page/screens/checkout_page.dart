import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce/core/colors/colors.dart';
import 'package:shoe_rack_ecommerce/core/constant/constant.dart';
import 'package:shoe_rack_ecommerce/core/icons/custom_icon_icons.dart';
import 'package:shoe_rack_ecommerce/presentation/cart_page/widgets/amountwidget.dart';
import 'package:shoe_rack_ecommerce/presentation/cart_page/widgets/cartdetailswidget.dart';
import 'package:shoe_rack_ecommerce/presentation/cart_page/widgets/continuetopaymentbuttonWidget.dart';
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
        body: SingleChildScrollView(
          physics: BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // shipping address-----------
              const Padding(
                padding: EdgeInsets.only(left: 22.0),
                child: Text(
                  'Shipping Address',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              sbox,
              sbox,

              // ShippingAddressWidget--------------------
              const ShippingAddressWidget(),
              sbox,
              sbox,

              const Padding(
                padding: EdgeInsets.only(left: 22.0),
                child: Text(
                  'Order List',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              sbox,
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

              const Padding(
                padding: EdgeInsets.only(left: 22.0),
                child: Text(
                  'Amount',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              sbox,
              AmountWidget(),
              sbox,
              ContinueToPaymentButtonWidget(),
              sbox
            ],
          ),
        ),
      ),
    );
  }
}
