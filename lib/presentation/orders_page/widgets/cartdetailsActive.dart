// ignore: file_names
// ignore: file_names
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce/core/colors/colors.dart';
import 'package:shoe_rack_ecommerce/core/constant/constant.dart';
import 'package:shoe_rack_ecommerce/core/model/product.dart';
import 'package:shoe_rack_ecommerce/model/order_functions.dart';
import 'package:shoe_rack_ecommerce/presentation/orders_page/screens/track_order_page.dart';

class OrderDetailsActive extends StatelessWidget {
  const OrderDetailsActive({
    super.key,
  });
  List<Product> filterProducts(
      List<Product> productList, List<dynamic> productIdList) {
    return productList
        .where(
          (product) => productIdList.contains(product.id),
        )
        .toList();
  }

  List<String> getListasString(List<dynamic> nestedList) {
    List<String> flattenedList = [];
    for (var sublist in nestedList) {
      if (sublist is List<dynamic>) {
        flattenedList.addAll(getListasString(sublist));
      } else {
        flattenedList.add(sublist.toString());
      }
    }
    return flattenedList;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: Column(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: getProductIdFromOrdersActive(),
            builder: (context, orderSnapshot) {
              if (orderSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (orderSnapshot.hasError) {
                return Text('Error: ${orderSnapshot.error}');
              }
              if (orderSnapshot.hasData) {
                //get product id from orders as nested list and convertting into a list of string
                List<String> productId = getListasString(orderSnapshot
                    .data!.docs
                    .map((doc) => doc.get('productId') as List<dynamic>)
                    .toList());
                    List<String> orderId = getListasString(orderSnapshot
                    .data!.docs
                    .map((doc) => doc.get('orderId') as String)
                    .toList());
                log(productId.toString());
                List<String> dateTime = getListasString(orderSnapshot.data!.docs
                    .map((doc) => doc.get('orderDate') as String)
                    .toList());
                return FutureBuilder<QuerySnapshot>(
                  future: getProducts(),
                  builder: (context, productSnapshot) {
                    if (productSnapshot.connectionState ==
                        ConnectionState.waiting) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (productSnapshot.hasError) {
                      return Text('Error: ${orderSnapshot.error}');
                    }
                    if (productSnapshot.hasData) {
                      List<Product> product = productSnapshot.data!.docs
                          .map((doc) => Product.fromJson(
                              doc.data() as Map<String, dynamic>))
                          // .where((product) => productIdList.contains(product.id))
                          .toList();
                      log(product[0].name);
                      List<Product> orderProduct =
                          filterProducts(product, productId);
                      if (orderProduct.isNotEmpty) {
                        log(orderProduct[0].name);
                      }
                      return orderProduct.isNotEmpty
                          ? ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: orderProduct.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 10, left: size.width * 0.05),
                                      child: Text(
                                          'Order Placed on: ${dateTime[0]}',
                                          style: const TextStyle(fontSize: 15)),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(15.0),
                                      child: Container(
                                        width: size.width * 0.98,
                                        height: size.width * 0.45,
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            color: colorgray),
                                        child: Row(
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: SizedBox(
                                                width: 80,
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  child: Image.network(
                                                      orderProduct[index]
                                                          .imgurl!),
                                                ),
                                              ),
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.center,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                SizedBox(
                                                  width: size.width * 0.64,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 12.0,
                                                            top: 0,
                                                            bottom: 0),
                                                    child: Text(
                                                      orderProduct[index].name,
                                                      style: const TextStyle(
                                                        fontSize: 15,
                                                      ),
                                                      textAlign:
                                                          TextAlign.start,
                                                    ),
                                                  ),
                                                ),
                                                sbox,
                                                SizedBox(
                                                  width: size.width * 0.6,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 12.0,
                                                            bottom: 0,
                                                            top: 0),
                                                    child: Text(
                                                      orderProduct[index]
                                                          .subtitle,
                                                      style: TextStyle(
                                                          // overflow: TextOverflow.clip,
                                                          fontSize: 15,
                                                          color: colorblack
                                                              .withOpacity(
                                                                  0.5)),
                                                      textAlign:
                                                          TextAlign.start,
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 12.0, top: 5),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        orderProduct[index]
                                                            .color!,
                                                        style: const TextStyle(
                                                            fontSize: 15),
                                                      ),
                                                      const Padding(
                                                        padding:
                                                            EdgeInsets.only(
                                                                left: 8.0),
                                                        child: Text(
                                                          '|',
                                                          style: TextStyle(
                                                              fontSize: 18),
                                                        ),
                                                      ),
                                                      Center(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 8.0),
                                                          child: Text(
                                                            'Size : ${orderProduct[index].size}',
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      vertical: 10.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 12.0,
                                                                top: 0,
                                                                bottom: 0),
                                                        child: Text(
                                                          '₹${orderProduct[index].price}',
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 25),
                                                          textAlign:
                                                              TextAlign.start,
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {},
                                                        child: Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left:
                                                                      size.width *
                                                                          0.16),
                                                          child: InkWell(
                                                            onTap: () {
                                                              Navigator.push(
                                                                  context,
                                                                  MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                             TrackOrderScreen(orderId: orderId[index]),
                                                                  ));
                                                            },
                                                            child: Container(
                                                              decoration: BoxDecoration(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              20),
                                                                  color:
                                                                      colorgreen),
                                                              width:
                                                                  size.width *
                                                                      0.26,
                                                              height:
                                                                  size.width *
                                                                      0.09,
                                                              child:
                                                                  const Center(
                                                                child: Text(
                                                                    'Track Order'),
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            )
                          : SizedBox(
                              height: size.height * 0.7,
                              child: const Center(
                                  child: Text("You haven't ordered anything")));
                    }
                    return SizedBox(
                        height: size.height * 0.7,
                        child: const Center(child: Text("Loading")));
                  },
                );
              }
              return SizedBox(
                  height: size.height * 0.7,
                  child: const Center(child: Text("Loading")));
            },
          )
        ],
      ),
    );
  }
}
