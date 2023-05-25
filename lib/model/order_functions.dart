import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shoe_rack_ecommerce/model/order_model.dart';
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  final userID = user!.displayName;
addtoOrders(
    {int? totalValue,
    String? addressId,
    List<String>? productId
    ,String? orderStatus
    }) {
  final String email = FirebaseAuth.instance.currentUser!.email!;
  final dataTime = DateTime.now();
  final orderRef = FirebaseFirestore.instance
      .collection('users')
      .doc(email)
      .collection('order');
  OrderModel orderModel = OrderModel(
      orderId:
          '$userID${dataTime.day}/${dataTime.month}/${dataTime.year}- ${dataTime.hour}:${dataTime.minute}',
      productId: productId,
      totalValue: totalValue,
      addressId: addressId,
      orderStatus: orderStatus,
      orderDate:  '${dataTime.day}/${dataTime.month}/${dataTime.year}- ${dataTime.hour}:${dataTime.minute}');
  orderRef.add(orderModel.toJason());
  log('added to Orders');
}

Future<QuerySnapshot> getProductIdActive() async {
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

Future<DocumentSnapshot> getAddressIdActive() async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  final userID = user!.email;
  final querySnapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(userID)
      .collection('address')
      .where('isDefault', isEqualTo: true).where('orderStatus',isEqualTo: 'placed')
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

Future<QuerySnapshot> getProductIdFromOrders() async {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final User? user = auth.currentUser;
  final userID = user!.email;
  final querySnapshot = await FirebaseFirestore.instance
      .collection('users')
      .doc(userID)
      .collection('order')
      .get();
  return querySnapshot;
}

Future<QuerySnapshot> getProducts() async {
  final querySnapshot =
      await FirebaseFirestore.instance.collection('product').get();
  return querySnapshot;
}
