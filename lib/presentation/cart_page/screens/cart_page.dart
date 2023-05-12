import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce/core/colors/colors.dart';
import 'package:shoe_rack_ecommerce/core/constant/constant.dart';
import 'package:shoe_rack_ecommerce/core/icons/custom_icon_icons.dart';
import 'package:shoe_rack_ecommerce/presentation/cart_page/screens/checkout_page.dart';
import 'package:shoe_rack_ecommerce/presentation/cart_page/widgets/cartdetailswidget.dart';
import 'package:shoe_rack_ecommerce/presentation/cart_page/widgets/cartdetailswidget_bottomsheet.dart';
import 'package:shoe_rack_ecommerce/presentation/cart_page/widgets/product_delete_bottomsheet.dart';
import 'package:shoe_rack_ecommerce/presentation/common_widget/MainButton.dart';

import '../../common_widget/AppBarWidget.dart';

class CartPage extends StatefulWidget {
  CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    getdocId();
    super.initState();
  }

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
      querySnapshot.docs.forEach((doc) {
        // var orderData = doc.data();
        ids.add(doc.get('productId'));
      });
      log(ids.toString());
      setState(() {});
    }).catchError((error) {
      // Handle any potential error
      print('Error getting subcollection documents: $error');
    });
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final userID = user!.email;
    if (ids.isEmpty) {
      return const CircularProgressIndicator();
    } else {
      log('data arrived');
      return SafeArea(
        child: Stack(children: [
          Scaffold(
            appBar: const PreferredSize(
                preferredSize: Size.fromHeight(70),
                child: AppBarWidget(title: 'My Cart')),
            body: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    StreamBuilder<QuerySnapshot>(
                        stream: FirebaseFirestore.instance
                            .collection('product')
                            .where('id', whereIn: ids)
                            .snapshots(),
                        builder: (BuildContext context,
                            AsyncSnapshot<QuerySnapshot> snapshot) {
                          if (snapshot.connectionState ==
                              ConnectionState.waiting) {
                            return const Center(
                                child: CircularProgressIndicator());
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
                                  child: Container(
                                    child: Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: Center(
                                        child: Container(
                                          width: size.width * 0.95,
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
                                                  width: 90,
                                                  child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                      child: Image.network(
                                                          data['imgurl'])),
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
                                                    child: Row(
                                                      // crossAxisAlignment: CrossAxisAlignment.stretch,
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 12.0,
                                                                  top: 0,
                                                                  bottom: 0),
                                                          child: Text(
                                                            data['name'],
                                                            style:
                                                                const TextStyle(
                                                              fontSize: 15,
                                                            ),
                                                            textAlign:
                                                                TextAlign.start,
                                                          ),
                                                        ),
                                                        Flex(
                                                            direction: Axis
                                                                .horizontal),
                                                        IconButton(
                                                            icon: const Icon(
                                                                CustomIcon
                                                                    .delete_4iconfluttter),
                                                            onPressed: () {
                                                              showModalBottomSheet(
                                                                context:
                                                                    context,
                                                                builder:
                                                                    (context) {
                                                                  return Container(
                                                                    decoration: BoxDecoration(
                                                                        color:
                                                                            colorwhite,
                                                                        borderRadius:
                                                                            BorderRadius.circular(20)),
                                                                    height: size
                                                                            .height *
                                                                        0.42,
                                                                    child:
                                                                        Center(
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        // mainAxisSize: MainAxisSize.min,
                                                                        children: <
                                                                            Widget>[
                                                                          sbox,
                                                                          const Padding(
                                                                            padding:
                                                                                EdgeInsets.all(12.0),
                                                                            child:
                                                                                Text(
                                                                              'Remove From Cart?',
                                                                              style: TextStyle(fontSize: 22),
                                                                            ),
                                                                          ),
                                                                          const Divider(
                                                                            endIndent:
                                                                                30,
                                                                            indent:
                                                                                30,
                                                                          ),
                                                                          sbox,
                                                                          CartDetailsWidgetBottomSheet(
                                                                              docId: data['id'],
                                                                              count: 1),
                                                                          Padding(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            child:
                                                                                Row(
                                                                              mainAxisAlignment: MainAxisAlignment.center,
                                                                              children: [
                                                                                Padding(
                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                  child: SizedBox(
                                                                                    width: size.width * 0.43,
                                                                                    height: 50,
                                                                                    child: ElevatedButton(
                                                                                      style: ButtonStyle(
                                                                                          backgroundColor: MaterialStatePropertyAll<Color>(colorgray),
                                                                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                                                            borderRadius: BorderRadius.circular(18.0),
                                                                                          ))),
                                                                                      onPressed: () {
                                                                                        Navigator.pop(context);
                                                                                      },
                                                                                      child: Text(
                                                                                        'Cancel',
                                                                                        style: TextStyle(fontSize: 18, color: colorblack),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                                Padding(
                                                                                  padding: const EdgeInsets.all(8.0),
                                                                                  child: SizedBox(
                                                                                    width: size.width * 0.43,
                                                                                    height: 50,
                                                                                    child: ElevatedButton(
                                                                                      style: ButtonStyle(
                                                                                          backgroundColor: MaterialStatePropertyAll<Color>(colorgreen),
                                                                                          shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                                                            borderRadius: BorderRadius.circular(18.0),
                                                                                          ))),
                                                                                      onPressed: () {
                                                                                        removeFromCart(data['id']);
                                                                                        Navigator.pop(context);
                                                                                      },
                                                                                      child: Text(
                                                                                        'Confirm',
                                                                                        style: TextStyle(fontSize: 18, color: colorwhite),
                                                                                      ),
                                                                                    ),
                                                                                  ),
                                                                                ),
                                                                              ],
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  );
                                                                },
                                                              );
                                                            }),
                                                      ],
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: size.width * 0.6,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 12.0,
                                                              bottom: 0,
                                                              top: 0),
                                                      child: Text(
                                                        data['subtitle'],
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
                                                          data['color'],
                                                          style:
                                                              const TextStyle(
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
                                                                EdgeInsets.only(
                                                                    left: 8.0),
                                                            child: Text(
                                                              'Size : ${data['size']}',
                                                              textAlign:
                                                                  TextAlign
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
                                                              EdgeInsets.only(
                                                                  left: 12.0,
                                                                  top: 0,
                                                                  bottom: 0),
                                                          child: Text(
                                                            '₹${data['price']}',
                                                            style: TextStyle(
                                                                fontSize: 25),
                                                            textAlign:
                                                                TextAlign.start,
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              EdgeInsets.only(
                                                                  left:
                                                                      size.width *
                                                                          0.12,
                                                                  right: 10),
                                                          child: Container(
                                                            decoration: BoxDecoration(
                                                                borderRadius:
                                                                    BorderRadius
                                                                        .circular(
                                                                            20),
                                                                color:
                                                                    colorgreen),
                                                            width: size.width *
                                                                0.29,
                                                            height: size.width *
                                                                0.09,
                                                            child: Row(
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .center,
                                                              children: [
                                                                IconButton(
                                                                  icon:
                                                                      const Icon(
                                                                    CustomIcon
                                                                        .minusiconfluttter,
                                                                    size: 14,
                                                                  ),
                                                                  onPressed:
                                                                      () {},
                                                                ),
                                                                const Text('1'),
                                                                IconButton(
                                                                  icon:
                                                                      const Icon(
                                                                    CustomIcon
                                                                        .addiconfluttter,
                                                                    size: 14,
                                                                  ),
                                                                  onPressed:
                                                                      () {},
                                                                ),
                                                              ],
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
                                    ),
                                  ),
                                );
                              }).toList());
                        }),
                    SizedBox(
                      height: 200,
                    )
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            left: 0,
            bottom: 0,
            child: Container(
              color: colorwhite,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Price',
                          style: TextStyle(
                              fontSize: 15, color: colorblack.withOpacity(0.5)),
                        ),
                        const Text(
                          '₹7,500',
                          style: TextStyle(fontSize: 30),
                        ),
                      ],
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: SizedBox(
                    //     width: size.width * 0.72,
                    //     height: 60,
                    //     child: ElevatedButton.icon(
                    //       style: ButtonStyle(
                    //           backgroundColor:
                    //               MaterialStatePropertyAll<Color>(colorgreen),
                    //           shape: MaterialStateProperty.all<
                    //                   RoundedRectangleBorder>(
                    //               RoundedRectangleBorder(
                    //             borderRadius: BorderRadius.circular(18.0),
                    //           ))),
                    //       onPressed: () {
                    //         Navigator.push(
                    //             context,
                    //             MaterialPageRoute(
                    //               builder: (context) => const CheckoutScreen(),
                    //             ));
                    //       },
                    //       icon: Icon(
                    //         CustomIcon.ticksquareiconfluttter,
                    //         size: 25,
                    //         color: colorwhite,
                    //       ),
                    //       label: Text(
                    //         'Checkout',
                    //         style: TextStyle(fontSize: 25, color: colorwhite),
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: CustomButton(
                        text: 'Checkout',
                        icon: CustomIcon.ticksquareiconfluttter,
                        width: 0.72,
                        widget: const CheckoutScreen(),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ]),
      );
    }
  }

  void removeFromCart(String docId) {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('product');
    collectionReference.doc(docId).delete();
  }
}
