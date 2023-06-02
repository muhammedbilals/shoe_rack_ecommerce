import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce/core/colors/colors.dart';
import 'package:shoe_rack_ecommerce/core/constant/constant.dart';

class AmountWidget extends StatelessWidget {
  const AmountWidget({
    super.key, required this.totalPrice,
  });
  final int totalPrice;
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
                   Text('₹$totalPrice', style: const TextStyle(fontSize: 18)),
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
                  const Text('FREE', style: TextStyle(fontSize: 18)),
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
                   Text('₹$totalPrice', style: const TextStyle(fontSize: 20)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
