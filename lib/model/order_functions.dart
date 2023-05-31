import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shoe_rack_ecommerce/core/utils/utils.dart';
import 'package:shoe_rack_ecommerce/model/order_model.dart';
import 'package:shoe_rack_ecommerce/presentation/cart_page/screens/payment_successfull_screen.dart';

final FirebaseAuth auth = FirebaseAuth.instance;
final User? user = auth.currentUser;
final userID = user!.displayName;
final userid = user!.email;
final number = user!.phoneNumber;
final _razorpay = Razorpay();



addtoOrders(
    {int? totalValue,
    String? addressId,
    List<String>? productId,
    String? orderStatus,
    String? cartId,
    BuildContext? context}) {
  final String email = FirebaseAuth.instance.currentUser!.email!;
  final dataTime = DateTime.now();
  final orderRef = FirebaseFirestore.instance
      .collection('users')
      .doc(email)
      .collection('order');
  final cartRef = FirebaseFirestore.instance
      .collection('users')
      .doc(userid)
      .collection('cart');
  var options = {
    'key': 'rzp_test_EgXUcvHZRGYEZU',
    'amount': totalValue! * 100,
    'name': 'ShoeRack',
    'description': '$productId',
    'prefill': {'contact': '', 'email': '$userid'}
  };

  OrderModel orderModel = OrderModel(
      orderId:
          '$userID${dataTime.day}/${dataTime.month}/${dataTime.year} - ${dataTime.hour}:${dataTime.minute}',
      productId: productId,
      totalValue: totalValue,
      addressId: addressId,
      orderStatus: orderStatus,
      orderDate:
          '${dataTime.day}/${dataTime.month}/${dataTime.year} - ${dataTime.hour}:${dataTime.minute}');
  orderRef.add(orderModel.toJason());
  log('added to Orders');

  // productId!.forEach((cartId) {
  //   cartRef
  //       .doc(cartId)
  //       .delete()
  //       .then((_) => log('Deleted cart: $cartId'))
  //       .catchError((error) => log('Error deleting cart $cartId: $error'));
  // });
  // log('deleted from cart');
  _razorpay.open(options);

  _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
      (PaymentSuccessResponse response) {
    _handlePaymentSuccess(context!, productId, cartRef);
  });
  _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, (PaymentFailureResponse response) {
    _handlePaymentError(response, context!);
  });
  _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
}

_handlePaymentSuccess(BuildContext context, List<String>? productId, cartRef) {
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
  Navigator.pop(context);
}

_handleExternalWallet() {}

Future<QuerySnapshot> getProductId() async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  final userID = user!.email;
  final querySnapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(userID)
      .collection('cart')
      .get();
  return querySnapshot;
}

Future<DocumentSnapshot> getAddressId() async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  final userID = user!.email;
  final querySnapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(userID)
      .collection('address')
      .where('isDefault', isEqualTo: true)
      .get();
  return querySnapshot.docs.first;
}

int getTotalCarttValue(List<dynamic> totalPrice) {
  dynamic totalValue = 0;
  for (int i = 0; i < totalPrice.length; i++) {
    totalValue = totalValue + totalPrice[i];
  }
  return totalValue;
}

Future<QuerySnapshot> getProductIdFromOrdersActive() async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  final userID = user!.email;
  final querySnapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(userID)
      .collection('order')
      .where('orderStatus', isEqualTo: 'placed')
      .get();
  return querySnapshot;
}

Future<QuerySnapshot> getProductIdFromOrdersCompleted() async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  final userID = user!.email;
  final querySnapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(userID)
      .collection('order')
      // .where('orderStatus',isEqualTo: 'delivered')
      .get();
  return querySnapshot;
}

Future<QuerySnapshot> getProducts() async {
  final querySnapshot =
      await FirebaseFirestore.instance.collection('product').get();
  return querySnapshot;
}
