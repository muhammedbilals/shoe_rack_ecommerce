import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce/core/colors/colors.dart';
import 'package:shoe_rack_ecommerce/core/constant/constant.dart';
import 'package:shoe_rack_ecommerce/core/icons/custom_icon_icons.dart';
import 'package:shoe_rack_ecommerce/presentation/cart_page/widgets/cartdetailswidget_bottomsheet.dart';

class CartDetailsWidgetCheckoutPage extends StatefulWidget {
  CartDetailsWidgetCheckoutPage({
    super.key,
  });

  @override
  State<CartDetailsWidgetCheckoutPage> createState() =>
      _CartDetailsWidgetCheckoutPageState();
}

class _CartDetailsWidgetCheckoutPageState
    extends State<CartDetailsWidgetCheckoutPage> {
  List<String> ids = [];

  getdocId() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final userID = user!.email;
    List<String> oderIds = [];
    CollectionReference ordersRef = await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('cart');

    ordersRef.get().then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        // var orderData = doc.data();
        ids.add(doc.get('productId'));
      }
      log(ids.toString());
      setState(() {});
    }).catchError((error) {
      // Handle any potential error
      log('Error getting subcollection documents: $error');
    });
  }

  @override
  void initState() {
    getdocId();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final userID = user!.email;
    return ids.isNotEmpty
        ? ListView(
            physics: NeverScrollableScrollPhysics(),
            padding: EdgeInsets.symmetric(horizontal: 20),
            shrinkWrap: true,
            children: [
              StreamBuilder<QuerySnapshot>(
                  stream: FirebaseFirestore.instance
                      .collection('product')
                      .where('id', whereIn: ids)
                      .snapshots(),
                  builder: (BuildContext context,
                      AsyncSnapshot<QuerySnapshot> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    if (snapshot.hasError) {
                      return const Text('Something went wrong');
                    }

                    return GridView.count(
                        shrinkWrap: true,
                        // crossAxisSpacing: 1,
                        // mainAxisSpacing: 2,
                        crossAxisCount: 1,
                        childAspectRatio: 1 / 0.5,
                        children: snapshot.data!.docs
                            .map((DocumentSnapshot document) {
                          Map<String, dynamic> data =
                              document.data()! as Map<String, dynamic>;
                          return GestureDetector(
                            child: Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Container(
                                  width: size.width * 0.9,
                                  height: size.width * 0.45,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: colorgray),
                                  child: Row(
                                    children: [
                                      SizedBox(
                                        width: 80,
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child:
                                                Image.network(data['imgurl'])),
                                      ),
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: size.width * 0.64,
                                            child: Row(
                                              // crossAxisAlignment: CrossAxisAlignment.stretch,
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 12.0,
                                                          top: 0,
                                                          bottom: 0),
                                                  child: Text(
                                                    data['name'],
                                                    style: const TextStyle(
                                                      fontSize: 15,
                                                    ),
                                                    textAlign: TextAlign.start,
                                                  ),
                                                ),
                                                Flex(
                                                    direction: Axis.horizontal),
                                              ],
                                            ),
                                          ),
                                          SizedBox(
                                            width: size.width * 0.6,
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 12.0,
                                                  bottom: 0,
                                                  top: 0),
                                              child: Text(
                                                data['subtitle'],
                                                style: TextStyle(
                                                    // overflow: TextOverflow.clip,
                                                    fontSize: 15,
                                                    color: colorblack
                                                        .withOpacity(0.5)),
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 12.0, top: 5),
                                            child: Row(
                                              children: [
                                                Text(
                                                  data['color'],
                                                  style: const TextStyle(
                                                      fontSize: 15),
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      left: 8.0),
                                                  child: Text(
                                                    '|',
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                ),
                                                Center(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 8.0),
                                                    child: Text(
                                                      'Size : ${data['size']}',
                                                      textAlign:
                                                          TextAlign.center,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          StreamBuilder(
                                            stream: FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(userID)
                                                .collection('cart')
                                                .doc(data['id'])
                                                .snapshots(),
                                            builder: (BuildContext context,
                                                AsyncSnapshot snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                return const Center(
                                                    child:
                                                        CircularProgressIndicator());
                                              }
                                              if (snapshot.hasError) {
                                                return const Text(
                                                    'Something went wrong');
                                              }
                                              return Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 10.0),
                                                child: Wrap(
                                                  alignment: WrapAlignment
                                                      .spaceBetween,
                                                  children: [
                                                    SizedBox(
                                                      width: size.width * 0.3,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 12.0,
                                                                top: 0,
                                                                bottom: 0),
                                                        child: Text(
                                                          '₹${data['price']}',
                                                          style:
                                                              const TextStyle(
                                                                  fontSize: 25),
                                                          textAlign:
                                                              TextAlign.start,
                                                        ),
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding: EdgeInsets.only(
                                                          left:
                                                              size.width * 0.12,
                                                          right: 10),
                                                      child: Container(
                                                        decoration: BoxDecoration(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            color: colorgreen),
                                                        width: size.width * 0.2,
                                                        height:
                                                            size.width * 0.09,
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Text(snapshot.data[
                                                                    'productCount']
                                                                .toString()),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList());
                  }),
            ],
          )
        : const Center(child: CircularProgressIndicator());
  }
}
