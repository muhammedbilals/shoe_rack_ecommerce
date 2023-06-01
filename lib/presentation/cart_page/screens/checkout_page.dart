import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shoe_rack_ecommerce/core/colors/colors.dart';
import 'package:shoe_rack_ecommerce/core/constant/constant.dart';
import 'package:shoe_rack_ecommerce/core/icons/custom_icon_icons.dart';
import 'package:shoe_rack_ecommerce/core/utils/utils.dart';
import 'package:shoe_rack_ecommerce/model/cart_functions.dart';
import 'package:shoe_rack_ecommerce/model/order_functions.dart';
import 'package:shoe_rack_ecommerce/presentation/cart_page/screens/payment_successfull_screen.dart';
import 'package:shoe_rack_ecommerce/presentation/cart_page/widgets/amountwidget.dart';
import 'package:shoe_rack_ecommerce/presentation/cart_page/widgets/cartdetailswidget_checkout_page.dart';
import 'package:shoe_rack_ecommerce/presentation/cart_page/widgets/shippingadresswidget.dart';
import 'package:shoe_rack_ecommerce/presentation/common_widget/AppBarWidget.dart';

class CheckoutScreen extends StatefulWidget {
  const CheckoutScreen({super.key});

  @override
  State<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends State<CheckoutScreen> {
  final _razorpay = Razorpay();

  @override
  void initState() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
        (PaymentSuccessResponse response) {
      _handlePaymentSuccess(response, context, productId, cartRef);
    });
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR,
        (PaymentFailureResponse response) {
      _handlePaymentError(response, context);
    });
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

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
              //future builder to get selceted address where contains a field set to true
              FutureBuilder<QuerySnapshot>(
                future: getAddressId(),
                builder: (ccontext, addressSnapshot) {
                  String addressId = '';
                  if (addressSnapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (addressSnapshot.hasError) {
                    return Text('Error: ${addressSnapshot.error}');
                  }
                  if (addressSnapshot.hasData) {
                    final docs = addressSnapshot.data!.docs;

                    if (docs.isNotEmpty) {
                      final addressData =
                          docs.first.data() as Map<String, dynamic>;
                      addressId = addressData['addressId'] ?? '';
                    }
                  }
                  //to get product id stored in cart collection
                  return FutureBuilder<QuerySnapshot>(
                    future: getProductId(),
                    builder: (ccontext, cartSnapshot) {
                      if (cartSnapshot.connectionState ==
                          ConnectionState.waiting) {
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      } else if (cartSnapshot.hasError) {
                        return Text('Error: ${cartSnapshot.error}');
                      }
                      if (cartSnapshot.hasData) {
                        // List<String> productList = [];
                        List<String> productId = cartSnapshot.data!.docs
                            .map((doc) => doc.get('productId') as String)
                            .toList();
                        // for (String productId in productId) {
                        //   // Map<String, dynamic> productMap = {'id': productId};
                        //   productList.add(productId);
                        // }
                        //to get total value from cart and calculating total cart value
                        List<dynamic> productPrice = cartSnapshot.data!.docs
                            .map((doc) => doc.get('totalPrice'))
                            .toList();
                        final totalvalue = getTotalCarttValue(productPrice);
                        return Center(
                          child: SizedBox(
                            width: size.width * 0.9,
                            height: 60,
                            child: ElevatedButton.icon(
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(colorgreen),
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18.0),
                                  ),
                                ),
                              ),
                              onPressed: () {
                                if (addressId !="") {
                                  var options = {
                                    'key': 'rzp_test_EgXUcvHZRGYEZU',
                                    'amount': totalvalue,
                                    'name': 'ShoeRack',
                                    'description': '$productId',
                                    'prefill': {
                                      'contact': '',
                                      'email': '$userid'
                                    }
                                  };

                                  _razorpay.open(options);

                                  addtoOrders(
                                      context: ccontext,
                                      productId: productId,
                                      addressId: addressId,
                                      totalValue: totalvalue,
                                      orderStatus: 'Placed');
                                } else {
                                  utils.showSnackbar('Please add an address');
                                }
                              },
                              icon: Icon(
                                CustomIcon.walleticonfluttter,
                                size: 22,
                                color: colorwhite,
                              ),
                              label: Text(
                                'Continue to Payment',
                                style:
                                    TextStyle(fontSize: 20, color: colorwhite),
                              ),
                            ),
                          ),
                        );
                      }
                      return const Text('loading');
                    },
                  );
                },
              ),
              sbox
            ],
          ),
        ),
      ),
    );
  }

  _handlePaymentSuccess(PaymentSuccessResponse response, BuildContext context,
      List<String>? productId, cartRef) {
    for (var cartId in productId!) {
      cartRef
          .doc(cartId)
          .delete()
          .then((_) => log('Deleted cart: $cartId'))
          .catchError((error) => log('Error deleting cart $cartId: $error'));
    }
    log('deleted from cart');
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const PaymentSuccessfullScreen(),
        ));
    //  navigatorKey.currentState!.push(MaterialPageRoute(builder: (context) => PaymentSuccessfullScreen(),));
  }

  _handlePaymentError(PaymentFailureResponse response, BuildContext context) {
    utils.showSnackbar('Payment was Unsuccessful');
    // Navigator.push(
    //     context,
    //     MaterialPageRoute(
    //       builder: (context) => SudoPage(),
    //     ));
  }

  _handleExternalWallet() {}
}
