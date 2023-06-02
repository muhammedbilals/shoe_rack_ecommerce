import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce/core/colors/colors.dart';
import 'package:shoe_rack_ecommerce/core/constant/constant.dart';
import 'package:shoe_rack_ecommerce/core/model/product.dart';
import 'package:shoe_rack_ecommerce/model/order_functions.dart';
import 'package:shoe_rack_ecommerce/model/order_model.dart';
import 'package:shoe_rack_ecommerce/presentation/orders_page/screens/orders_list.dart';
import 'package:shoe_rack_ecommerce/presentation/orders_page/screens/orders_page.dart';
import 'package:shoe_rack_ecommerce/presentation/orders_page/screens/track_order_page.dart';

class OrderDetailsActive extends StatelessWidget {
  const OrderDetailsActive({
    super.key,
  });

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
                final orderAllList = orderSnapshot.data!.docs.toList();
                final order = orderSnapshot.data!.docs
                    .map(
                      (doc) => OrderModel.fromJason(
                          doc.data() as Map<String, dynamic>),
                    )
                    .toList();
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
                      return order.isNotEmpty
                          ? ListView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: order.length,
                              shrinkWrap: true,
                              itemBuilder: (context, index) {
                                List<Product> product = productSnapshot
                                    .data!.docs
                                    .map(
                                      (doc) => Product.fromJson(
                                          doc.data() as Map<String, dynamic>),
                                    )
                                    .where((product) => order[index]
                                        .productId!
                                        .contains(product.id))
                                    .toList();

                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(
                                          top: 10, left: size.width * 0.05),
                                      child: Text(
                                          'Order Placed on: ${order[index].orderDate}',
                                          style: const TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: 15)),
                                    ),
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  OrdersListScreen(
                                                      product: product),
                                            ));
                                      },
                                      child: Padding(
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
                                                        BorderRadius.circular(
                                                            20),
                                                    child: Image.network(
                                                        product[0].imgurl!),
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
                                                        order[index]
                                                            .orderStatus!,
                                                        style: const TextStyle(
                                                          fontSize: 18,
                                                        ),
                                                        textAlign:
                                                            TextAlign.start,
                                                      ),
                                                    ),
                                                  ),
                                                  sbox,
                                                  SizedBox(
                                                    width: size.width * 0.64,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 12.0,
                                                              top: 0,
                                                              bottom: 0),
                                                      child: Text(
                                                        '${order[index].productId!.length} Items',
                                                        style: const TextStyle(
                                                          fontSize: 15,
                                                        ),
                                                        textAlign:
                                                            TextAlign.start,
                                                      ),
                                                    ),
                                                  ),
                                                  sbox,
                                                  Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceAround,
                                                    children: [
                                                      InkWell(
                                                        onTap: () {
                                                          deleteFromOrders(
                                                              order[index]
                                                                  .orderId!);
                                                          Navigator.pushReplacement(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder:
                                                                    (context) =>
                                                                        const OrdersPage(),
                                                              ));
                                                        },
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(8.0),
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                                color:
                                                                    Colors.red),
                                                            width: size.width *
                                                                0.26,
                                                            height: size.width *
                                                                0.09,
                                                            child: const Center(
                                                              child: Text(
                                                                  'Cancel'),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      InkWell(
                                                        onTap: () {
                                                          Navigator.push(
                                                              context,
                                                              MaterialPageRoute(
                                                                builder: (context) =>
                                                                    TrackOrderScreen(
                                                                        orderId:
                                                                            order[index].orderId!),
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
                                                              size.width * 0.26,
                                                          height:
                                                              size.width * 0.09,
                                                          child: const Center(
                                                            child: Text(
                                                                'Track Order'),
                                                          ),
                                                        ),
                                                      )
                                                    ],
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
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
