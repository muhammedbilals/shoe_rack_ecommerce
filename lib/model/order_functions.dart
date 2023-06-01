import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce/model/order_model.dart';

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
    BuildContext? context}) async{
  final String email = FirebaseAuth.instance.currentUser!.email!;
  final dataTime = DateTime.now();
  // final orderRef = FirebaseFirestore.instance
  //     .collection('users')
  //     .doc(email)
  //     .collection('order');
  final orderAdminRef = FirebaseFirestore.instance.collection('orders');

  // final cartRef = FirebaseFirestore.instance
  //     .collection('users')
  //     .doc(userid)
  //     .collection('cart');

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
  // orderRef.add(orderModel.toJason());
DocumentReference docRef = await orderAdminRef.add(orderModel.toJason());
String orderId = docRef.id;


orderModel.orderId = orderId;


await docRef.update({'orderId': orderId});

log('Added to Orders with ID: $orderId');
  // productId!.forEach((cartId) {
  //   cartRef
  //       .doc(cartId)
  //       .delete()
  //       .then((_) => log('Deleted cart: $cartId'))
  //       .catchError((error) => log('Error deleting cart $cartId: $error'));
  // });
  // log('deleted from cart');
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
      .collection('orders')
      .where('userId', isEqualTo: userID)
      .where('orderStatus', isEqualTo: 'placed')
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
      .where('orderStatus', isEqualTo: 'delivered')
      .get();
  return querySnapshot;
}

Future<QuerySnapshot> getProducts() async {
  final querySnapshot =
      await FirebaseFirestore.instance.collection('product').get();
  return querySnapshot;
}
