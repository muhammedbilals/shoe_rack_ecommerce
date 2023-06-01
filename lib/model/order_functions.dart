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

addtoOrders(
    {int? totalValue,
    String? addressId,
    List<String>? productId,
    String? orderStatus,
    String? cartId,
    BuildContext? context}) async {
  final dataTime = DateTime.now();
  final orderAdminRef = FirebaseFirestore.instance.collection('orders');
  OrderModel orderModel = OrderModel(
      userId: userid,
      orderId:
          '$userid${dataTime.day}/${dataTime.month}/${dataTime.year} - ${dataTime.hour}:${dataTime.minute}',
      productId: productId,
      totalValue: totalValue,
      addressId: addressId,
      orderStatus: orderStatus,
      orderDate:
          '${dataTime.day}/${dataTime.month}/${dataTime.year} - ${dataTime.hour}:${dataTime.minute}:${dataTime.millisecond}');
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
  final _razorpay = Razorpay();
  _handlePaymentSuccess(PaymentSuccessResponse response, BuildContext context,
      List<String>? productId, cartRef) async {
    DocumentReference docRef = await orderAdminRef.add(orderModel.toJason());
    String orderId = docRef.id;

    orderModel.orderId = orderId;

    await docRef.update({'orderId': orderId});

    log('Added to Orders with ID: $orderId');
    for (var cartId in productId!) {
      cartRef
          .doc(cartId)
          .delete()
          .then((_) => log('Deleted cart: $cartId'))
          .catchError((error) => log('Error deleting cart $cartId: $error'));
    }
    
    log('deleted from cart');
    // ignore: use_build_context_synchronously
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

  final String email = FirebaseAuth.instance.currentUser!.email!;

  // final orderRef = FirebaseFirestore.instance
  //     .collection('users')
  //     .doc(email)
  //     .collection('order');

  _razorpay.open(options);
  _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS,
      (PaymentSuccessResponse response) {
    _handlePaymentSuccess(response, context!, productId, cartRef);
  });
  _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, (PaymentFailureResponse response) {
    _handlePaymentError(response, context!);
  });
  _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

  // orderRef.add(orderModel.toJason());


}

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

Future<QuerySnapshot> getAddressId() async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  final userID = user!.email;

  final querySnapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(userID)
      .collection('address')
      .where('isDefault', isEqualTo: true)
      .get();

  return querySnapshot;
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
      .collection('orders')
      .where('userId', isEqualTo: userID)
      .where('orderStatus', isEqualTo: 'Placed')
      .get();
  return querySnapshot;
}

Future<QuerySnapshot> getProductIdFromOrdersCompleted() async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  final userID = user!.email;
  final querySnapshot = await FirebaseFirestore.instance
      .collection('orders')
      .where('userId', isEqualTo: userID)
      .where('orderStatus', isEqualTo: 'Delivered')
      .get();
  return querySnapshot;
}

Future<QuerySnapshot> getProducts() async {
  final querySnapshot =
      await FirebaseFirestore.instance.collection('product').get();
  return querySnapshot;
}
