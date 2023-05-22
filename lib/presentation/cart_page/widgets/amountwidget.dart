import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce/core/colors/colors.dart';
import 'package:shoe_rack_ecommerce/core/constant/constant.dart';
import 'package:shoe_rack_ecommerce/model/cart_functions.dart';

class AmountWidget extends StatefulWidget {
  const AmountWidget({
    super.key,
  });

  @override
  State<AmountWidget> createState() => _AmountWidgetState();
}

class _AmountWidgetState extends State<AmountWidget> {
  @override
  void initState() {
    // getTotalValue();
    super.initState();
  }

  void getpice() {
    final cartRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('cart');
    cartRef.doc();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Center(
      child: Container(
        width: size.width * 0.9,
        height: size.width * 0.41,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: colorgray),
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
                        fontSize: 18, color: colorblack.withOpacity(0.5)),
                  ),
                  const Text('₹7,500', style: TextStyle(fontSize: 18)),
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
                          fontSize: 18, color: colorblack.withOpacity(0.5))),
                  const Text('₹7,500', style: TextStyle(fontSize: 18)),
                ],
              ),
            ),
            const Divider(
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
                  const Text('₹7,500', style: TextStyle(fontSize: 20)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
