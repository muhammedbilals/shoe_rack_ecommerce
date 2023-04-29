import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce/core/constant/constant.dart';
import 'package:shoe_rack_ecommerce/core/icons/custom_icon_icons.dart';
import 'package:shoe_rack_ecommerce/presentation/cart_page/screens/payments_screen.dart';
import 'package:shoe_rack_ecommerce/presentation/cart_page/widgets/amountwidget.dart';
import 'package:shoe_rack_ecommerce/presentation/cart_page/widgets/cartdetailswidget_checkout_page.dart';
import 'package:shoe_rack_ecommerce/presentation/cart_page/widgets/shippingadresswidget.dart';
import 'package:shoe_rack_ecommerce/presentation/common_widget/AppBarWidget.dart';
import 'package:shoe_rack_ecommerce/presentation/common_widget/MainButton.dart';

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
          physics: const BouncingScrollPhysics(),
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
              const CartDetailsWidgetCheckoutPage(),
              sbox,
              sbox,

              const CartDetailsWidgetCheckoutPage(),
              sbox,
              sbox,

              const CartDetailsWidgetCheckoutPage(),
              sbox,
              sbox,

              const CartDetailsWidgetCheckoutPage(),
              sbox,

              const Padding(
                padding: EdgeInsets.only(left: 22.0),
                child: Text(
                  'Amount',
                  style: TextStyle(fontSize: 20),
                ),
              ),
              sbox,
              const AmountWidget(),
              sbox,
              const CustomButton(
                text: 'Continue to Payment',
                icon: CustomIcon.walleticonfluttter,
                widget: PaymentsScreen(),
              ),
              sbox
            ],
          ),
        ),
      ),
    );
  }
}
