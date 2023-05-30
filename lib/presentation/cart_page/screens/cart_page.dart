import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce/core/colors/colors.dart';
import 'package:shoe_rack_ecommerce/core/constant/constant.dart';
import 'package:shoe_rack_ecommerce/core/icons/custom_icon_icons.dart';
import 'package:shoe_rack_ecommerce/core/model/product.dart';
import 'package:shoe_rack_ecommerce/presentation/cart_page/screens/checkout_page.dart';
import 'package:shoe_rack_ecommerce/presentation/cart_page/widgets/cartdetailswidget_bottomsheet.dart';
import 'package:shoe_rack_ecommerce/presentation/common_widget/MainButton.dart';

import '../../common_widget/AppBarWidget.dart';

// ignore: must_be_immutable
class CartPage extends StatelessWidget {
  CartPage({super.key});

  ValueNotifier<int> totalPriceNotifier = ValueNotifier(0);

  ValueNotifier<int> totalCartTotalNotifier = ValueNotifier(0);

  int totalPrice = 0;

  void updateTotalPrice(List<dynamic> productPrices) {
    totalPrice = getTotalCarttValue(productPrices);

    totalCartTotalNotifier.value = totalPrice;
  }

  addOrRemoveFromcart(String id, bool? incriment) async {
    //to update cart product count
    final FirebaseAuth auth = await FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final userID = user!.email;
    final collectionReference = FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('cart')
        .doc(id);

    //to get product count
    final DocumentSnapshot docSnapshot = await collectionReference.get();
    final dynamic productCount = docSnapshot['productCount'];
    if (incriment == true) {
      if (productCount < 5) {
        collectionReference.update({
          'productCount': productCount + 1,
        });
        log('added again cart');
      } else {
        return;
      }
    } else {
      if (productCount > 1) {
        collectionReference.update({
          'productCount': productCount - 1,
        });
        log('removed again cart');
      } else if (productCount <= 1) {
        collectionReference.delete();
      }
    }
  }

  getTotalProductValue(String id, int productPrice, int productCount) async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final userID = user!.email;
    final cartRef = FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('cart')
        .doc(id);
    // final doc = cartRef.get();
    await cartRef.update({'totalPrice': productPrice * productCount});
  }

  int getTotalCarttValue(List<dynamic> totalPrice) {
    dynamic totalValue = 0;
    for (int i = 0; i < totalPrice.length; i++) {
      totalValue = totalValue + totalPrice[i];
    }
    return totalValue;
  }

  Stream<QuerySnapshot> getProducts() {
    // final FirebaseAuth auth = FirebaseAuth.instance;

    final querySnapshot =
        FirebaseFirestore.instance.collection('product').snapshots();
    return querySnapshot;
  }

  Stream<QuerySnapshot> getProductIdfromCart() {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final userID = user!.email;
    final querySnapshot = FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('cart')
        .snapshots();
    return querySnapshot;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final userID = user!.email;

    return SafeArea(
      child: Stack(
        children: [
          Scaffold(
            appBar: const PreferredSize(
                preferredSize: Size.fromHeight(70),
                child: AppBarWidget(title: 'My Cart')),
            body: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(
                children: [
                  //streambuilder to get product id from cart
                  StreamBuilder<QuerySnapshot>(
                    stream: getProductIdfromCart(),
                    builder: (context, cartSnapshot) {
                      if (cartSnapshot.hasData) {
                        List<dynamic> productId = cartSnapshot.data!.docs
                            .map((doc) => doc.get('productId'))
                            .toList();
                        log('${productId.toString()}productId');
                        //streambuilder to get products using product id added in the cart
                        return StreamBuilder<QuerySnapshot>(
                          stream: getProducts(),
                          builder: (context, productSnapshot) {
                            if (productSnapshot.hasData) {
                              //to get product based on product id from cart
                              List<Product> product = productSnapshot.data!.docs
                                  .map((doc) => Product.fromJson(
                                      doc.data() as Map<String, dynamic>))
                                  .where((product) =>
                                      productId.contains(product.id))
                                  .toList();
                              //to get product price based on product id
                              List<dynamic> productPrice = productSnapshot
                                  .data!.docs
                                  .map((doc) => doc.get('price'))
                                  .toList();
                              if (totalPrice == 0.0) {
                                WidgetsBinding.instance
                                    .addPostFrameCallback((_) {
                                  updateTotalPrice(productPrice);
                                });
                              }
                              return product.isNotEmpty
                                  ? ListView.builder(
                                      itemCount: product.length,
                                      shrinkWrap: true,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          child: Padding(
                                            padding: const EdgeInsets.all(0.0),
                                            child: Center(
                                              child: Container(
                                                width: size.width * 0.95,
                                                height: size.width * 0.45,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    color: colorgray),
                                                child: Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              8.0),
                                                      child: SizedBox(
                                                        width: 80,
                                                        child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20),
                                                            child: Image.network(
                                                                product[index]
                                                                    .imgurl!)),
                                                      ),
                                                    ),
                                                    Column(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .center,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        SizedBox(
                                                          width:
                                                              size.width * 0.64,
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
                                                                        left:
                                                                            12.0,
                                                                        top: 0,
                                                                        bottom:
                                                                            0),
                                                                child: Text(
                                                                  product[index]
                                                                      .name
                                                                      .toString(),
                                                                  style:
                                                                      const TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .start,
                                                                ),
                                                              ),
                                                              const Flex(
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
                                                                        height: size.height *
                                                                            0.42,
                                                                        child:
                                                                            Center(
                                                                          child:
                                                                              Column(
                                                                            mainAxisAlignment:
                                                                                MainAxisAlignment.center,
                                                                            // mainAxisSize: MainAxisSize.min,
                                                                            children: <Widget>[
                                                                              sbox,
                                                                              const Padding(
                                                                                padding: EdgeInsets.all(12.0),
                                                                                child: Text(
                                                                                  'Remove From Cart?',
                                                                                  style: TextStyle(fontSize: 22),
                                                                                ),
                                                                              ),
                                                                              const Divider(
                                                                                endIndent: 30,
                                                                                indent: 30,
                                                                              ),
                                                                              sbox,
                                                                              CartDetailsWidgetBottomSheet(docId: product[index].id.toString(), count: 1),
                                                                              Padding(
                                                                                padding: const EdgeInsets.all(8.0),
                                                                                child: Row(
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
                                                                                          onPressed: () async {
                                                                                            final FirebaseAuth auth = await FirebaseAuth.instance;
                                                                                            final User? user = auth.currentUser;
                                                                                            final userID = user!.email;
                                                                                            removeFromCart(product[index].id.toString(), userID!);
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
                                                                },
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width:
                                                              size.width * 0.6,
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    left: 12.0,
                                                                    bottom: 0,
                                                                    top: 0),
                                                            child: Text(
                                                              product[index]
                                                                  .subtitle
                                                                  .toString(),
                                                              style: TextStyle(
                                                                  // overflow: TextOverflow.clip,
                                                                  fontSize: 15,
                                                                  color: colorblack
                                                                      .withOpacity(
                                                                          0.5)),
                                                              textAlign:
                                                                  TextAlign
                                                                      .start,
                                                            ),
                                                          ),
                                                        ),
                                                        Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 12.0,
                                                                  top: 5),
                                                          child: Row(
                                                            children: [
                                                              Text(
                                                                product[index]
                                                                    .color
                                                                    .toString(),
                                                                style:
                                                                    const TextStyle(
                                                                        fontSize:
                                                                            15),
                                                              ),
                                                              const Padding(
                                                                padding: EdgeInsets
                                                                    .only(
                                                                        left:
                                                                            8.0),
                                                                child: Text(
                                                                  '|',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          18),
                                                                ),
                                                              ),
                                                              Center(
                                                                child: Padding(
                                                                  padding: const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          8.0),
                                                                  child: Text(
                                                                    'Size : ${product[index].size.toString()}',
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  ),
                                                                ),
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                        StreamBuilder(
                                                          stream:
                                                              FirebaseFirestore
                                                                  .instance
                                                                  .collection(
                                                                      'users')
                                                                  .doc(userID)
                                                                  .collection(
                                                                      'cart')
                                                                  .doc(
                                                                    product[index]
                                                                        .id
                                                                        .toString(),
                                                                  )
                                                                  .snapshots(),
                                                          builder: (BuildContext
                                                                  context,
                                                              AsyncSnapshot
                                                                  snapshot) {
                                                            if (snapshot
                                                                .hasData) {
                                                              // //get the cart value of individual cartItem and saving it as a field
                                                              getTotalProductValue(
                                                                  productId[
                                                                      index],
                                                                  productPrice[
                                                                      index],
                                                                  snapshot.data[
                                                                          'productCount'] ??
                                                                      1);
                                                              //TODO
                                                            }
                                                            if (!snapshot
                                                                    .hasData ||
                                                                !snapshot.data!
                                                                    .exists) {
                                                              return const SizedBox
                                                                  .shrink(); // Handle case where document doesn't exist anymore
                                                            }
                                                            if (snapshot
                                                                    .connectionState ==
                                                                ConnectionState
                                                                    .waiting) {
                                                              return SizedBox(
                                                                height:
                                                                    size.width *
                                                                        0.135,
                                                                width:
                                                                    size.width *
                                                                        0.05,
                                                              );
                                                            }
                                                            if (snapshot
                                                                .hasError) {
                                                              return const Text(
                                                                  'Something went wrong');
                                                            }
                                                            return Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .symmetric(
                                                                      vertical:
                                                                          10.0),
                                                              child: Wrap(
                                                                alignment:
                                                                    WrapAlignment
                                                                        .spaceBetween,
                                                                // crossAxisAlignment:
                                                                //     CrossAxisAlignment
                                                                //         .stretch,
                                                                // mainAxisAlignment:
                                                                //     MainAxisAlignment
                                                                //         .spaceBetween,
                                                                children: [
                                                                  SizedBox(
                                                                    width: size
                                                                            .width *
                                                                        0.245,
                                                                    child:
                                                                        Padding(
                                                                      padding: const EdgeInsets
                                                                              .only(
                                                                          left:
                                                                              12.0,
                                                                          top:
                                                                              0,
                                                                          bottom:
                                                                              0),
                                                                      child:
                                                                          Row(
                                                                        children: [
                                                                          Text(
                                                                            '₹${product[index].price.toString()}',
                                                                            style:
                                                                                const TextStyle(overflow: TextOverflow.fade, fontSize: 25),
                                                                            textAlign:
                                                                                TextAlign.start,
                                                                          ),
                                                                          Text(
                                                                            '×${snapshot.data['productCount']}',
                                                                            style:
                                                                                TextStyle(color: colorblack.withOpacity(0.5), fontSize: 15),
                                                                            textAlign:
                                                                                TextAlign.start,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding: EdgeInsets.only(
                                                                        left: size.width *
                                                                            0.12,
                                                                        right:
                                                                            10),
                                                                    child:
                                                                        Container(
                                                                      decoration: BoxDecoration(
                                                                          borderRadius: BorderRadius.circular(
                                                                              20),
                                                                          color:
                                                                              colorgreen),
                                                                      width: size
                                                                              .width *
                                                                          0.287,
                                                                      height: size
                                                                              .width *
                                                                          0.09,
                                                                      child:
                                                                          Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.center,
                                                                        children: [
                                                                          ValueListenableBuilder(
                                                                            valueListenable:
                                                                                totalPriceNotifier,
                                                                            builder: (context, priceValue, child) =>
                                                                                IconButton(
                                                                              icon: const Icon(
                                                                                CustomIcon.minusiconfluttter,
                                                                                size: 14,
                                                                              ),
                                                                              onPressed: () {
                                                                                addOrRemoveFromcart(product[index].id.toString(), false);
                                                                                updateTotalPrice(productPrice);
                                                                              },
                                                                            ),
                                                                          ),
                                                                          Text('${snapshot.data['productCount']}'
                                                                              .toString()),
                                                                          IconButton(
                                                                              icon: const Icon(
                                                                                CustomIcon.addiconfluttter,
                                                                                size: 14,
                                                                              ),
                                                                              onPressed: () {
                                                                                addOrRemoveFromcart(product[index].id.toString(), true);
                                                                                updateTotalPrice(productPrice);
                                                                              }),
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
                                      },
                                    )
                                  : SizedBox(
                                      height: size.height * 0.7,
                                      child:
                                          const Center(child: Text('Cart is Empty')));
                            }
                            return const Text('loading');
                          },
                        );
                      }
                      return const Text('loaasd');
                    },
                  )
                ],
              ),
            ),
          ),
          ValueListenableBuilder(
            valueListenable: totalCartTotalNotifier,
            builder: (context, totalValue, child) {
              return Positioned(
                left: 0,
                bottom: 0,
                right: 0,
                child: Container(
                  color: colorwhite,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        SizedBox(
                          width: size.width * 0.22,
                          height: size.width * 0.14,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Total Price',
                                style: TextStyle(
                                    fontSize: 15,
                                    color: colorblack.withOpacity(0.5)),
                              ),
                              Text(totalValue.toString())
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: CustomButton(
                            text: 'Checkout',
                            icon: CustomIcon.ticksquareiconfluttter,
                            width: 0.69,
                            widget:  CheckoutScreen(),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          )
        ],
      ),
    );
  }

  // removes data from firestore
  void removeFromCart(String docId, String id) {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('users');
    collectionReference.doc(id).collection('cart').doc(docId).delete();
  }
}
