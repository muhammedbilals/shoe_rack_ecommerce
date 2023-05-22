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

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

List<Product> products = [];

class _CartPageState extends State<CartPage> {
  ValueNotifier<int> totalPriceNotifier = ValueNotifier(0);
  // List<dynamic> dataList = [];

  @override
  void initState() {
    getdocId();
    super.initState();
  }

  List<String> ids = [];
  int totalPrice = 0;
  int arshadprice = 0;
  getdocId() async {
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final userID = user!.email;
    CollectionReference ordersRef = await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('cart');
    //GETTING THE COLLECTION ID FROM CART
    await ordersRef.get().then((QuerySnapshot querySnapshot) {
      for (var doc in querySnapshot.docs) {
        // var orderData = doc.data();
        ids.add(doc.get('productId'));
      }

      log('${ids.toString()}----from getdocId');
    }).catchError((error) {
      // Handle any potential error
      log('Error getting subcollection documents: $error');
    });
    //
    final product = await FirebaseFirestore.instance
        .collection('product')
        .where('id', whereIn: ids)
        .get();
    List<DocumentSnapshot> documentList = product.docs;

    for (var document in documentList) {
      Map<String, dynamic> data = document.data() as Map<String, dynamic>;
      Product product = Product.fromJason(data);
      products.add(product);
    }
    setState(() {
      products = products;
    });
    // getTotalPrice2();
    getTotalPrice2();
    log(products[0].name.toString());
  }

  // getTotalPrice() async {
  //   final String email = FirebaseAuth.instance.currentUser!.email!;
  //   QuerySnapshot querySnapshot = await FirebaseFirestore.instance
  //       .collection('users')
  //       .doc(email)
  //       .collection('cart')
  //       .get();
  //   List<DocumentSnapshot> documents = querySnapshot.docs;
  //   List<dynamic> cartList = documents.map((doc) => doc.data()).toList();
  //   if (mounted) {
  //     setState(() {
  //       this.cartList = cartList;
  //     });
  //   }
  //   if (querySnapshot.docs.isNotEmpty) {
  //     for (var doc in querySnapshot.docs) {
  //       totalPrice = doc.get('totalPrice') + totalPrice;
  //     }
  //     if (mounted) {
  //       setState(() {
  //         totalPrice;
  //       });
  //     }
  //     totalPriceNotifier.value = totalPrice;
  //   }
  // }

  addOrRemoveFromcart(String id, bool? incriment) async {
    // int? productCount;
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
    final dynamic _productCount = docSnapshot['productCount'];

    if (incriment == true) {
      collectionReference.update({
        'productCount': _productCount + 1,
      });
      log('added again cart');
    } else {
      collectionReference.update({
        'productCount': _productCount - 1,
      });
      log('removed again cart');
    }
  }

  getTotalPrice2() async {
    List<Map<dynamic, dynamic>> list = [];
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final userID = user!.email;
    List<String> productId = [];
    List<int> productCount = [];

    CollectionReference ordersRef = await FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('cart');

    // get product id from cart as list for calculation
    try {
      await ordersRef.get().then((QuerySnapshot querySnapshot) {
        for (var doc in querySnapshot.docs) {
          // var orderData = doc.data();
          productId.add(doc.get('productId'));
          productCount.add(doc.get('productCount'));
        }

        setState(() {});
      }).catchError((error) {
        // Handle any potential error
        log('Error getting subcollection documents: $error');
      });
    } catch (e) {
      log(e.toString());
    }

    // GETTING PRICE FROM PRODUCT DATABASE WITH PRODUCT ID
    var snapshot = await FirebaseFirestore.instance
        .collection('product')
        .where('id', whereIn: ids)
        .get();
    final templista = snapshot.docs;
    list = templista.map((DocumentSnapshot documentSnapshot) {
      return documentSnapshot.data() as Map<String, dynamic>;
    }).toList();

    for (int i = 0; i < productId.length; i++) {
      totalPrice = list[i]['price'] * productCount[i] + totalPrice;
      List<int> pricelist = [];

      pricelist.add(list[i]['price']);

      await ordersRef
          .doc(productId[i])
          .update({'totalPrice': (list[i]['price'] * productCount[i])});
      log('total price is ,${list[i]['price'] * productCount[i]}');
    }
    // get product count from cart to do multiplication

    //updating value with new value
    setState(() {
      totalPrice = totalPrice;
    });
    log(totalPrice.toString());
  }
  // checkIfCartIsEmpty(List ids){
  //   if(ids.isEmpty){
  //     return
  //   }
  // }

  int cartcount = 1;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final userID = user!.email;

    return SafeArea(
      child: Stack(children: [
        Scaffold(
            appBar: const PreferredSize(
                preferredSize: Size.fromHeight(70),
                child: AppBarWidget(title: 'My Cart')),
            body: SingleChildScrollView(
              physics: const NeverScrollableScrollPhysics(),
              child: Column(children: [
              
                   ListView.builder(
                    
                    shrinkWrap: true,
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      if (ids.isNotEmpty || products.isNotEmpty) {
                        return GestureDetector(
                          child: Padding(
                            padding: const EdgeInsets.all(0.0),
                            child: Center(
                              child: Container(
                                width: size.width * 0.95,
                                height: size.width * 0.45,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    color: colorgray),
                                child: Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: SizedBox(
                                        width: 80,
                                        child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(20),
                                            child: Image.network(
                                                products[index].imgurl!)),
                                      ),
                                    ),
                                    Column(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: size.width * 0.64,
                                          child: Row(
                                            // crossAxisAlignment: CrossAxisAlignment.stretch,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 12.0,
                                                    top: 0,
                                                    bottom: 0),
                                                child: Text(
                                                  products[index].name.toString(),
                                                  style: const TextStyle(
                                                    fontSize: 15,
                                                  ),
                                                  textAlign: TextAlign.start,
                                                ),
                                              ),
                                              Flex(direction: Axis.horizontal),
                                              IconButton(
                                                icon: const Icon(CustomIcon
                                                    .delete_4iconfluttter),
                                                onPressed: () {
                                                  showModalBottomSheet(
                                                    context: context,
                                                    builder: (context) {
                                                      return Container(
                                                        decoration: BoxDecoration(
                                                            color: colorwhite,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                        height:
                                                            size.height * 0.42,
                                                        child: Center(
                                                          child: Column(
                                                            mainAxisAlignment:
                                                                MainAxisAlignment
                                                                    .center,
                                                            // mainAxisSize: MainAxisSize.min,
                                                            children: <Widget>[
                                                              sbox,
                                                              const Padding(
                                                                padding:
                                                                    EdgeInsets
                                                                        .all(
                                                                            12.0),
                                                                child: Text(
                                                                  'Remove From Cart?',
                                                                  style: TextStyle(
                                                                      fontSize:
                                                                          22),
                                                                ),
                                                              ),
                                                              const Divider(
                                                                endIndent: 30,
                                                                indent: 30,
                                                              ),
                                                              sbox,
                                                              CartDetailsWidgetBottomSheet(
                                                                  docId: products[
                                                                          index]
                                                                      .id
                                                                      .toString(),
                                                                  count: 1),
                                                              Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .all(8.0),
                                                                child: Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .center,
                                                                  children: [
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          SizedBox(
                                                                        width: size
                                                                                .width *
                                                                            0.43,
                                                                        height:
                                                                            50,
                                                                        child:
                                                                            ElevatedButton(
                                                                          style: ButtonStyle(
                                                                              backgroundColor: MaterialStatePropertyAll<Color>(colorgray),
                                                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.circular(18.0),
                                                                              ))),
                                                                          onPressed:
                                                                              () {
                                                                            Navigator.pop(
                                                                                context);
                                                                          },
                                                                          child:
                                                                              Text(
                                                                            'Cancel',
                                                                            style: TextStyle(
                                                                                fontSize: 18,
                                                                                color: colorblack),
                                                                          ),
                                                                        ),
                                                                      ),
                                                                    ),
                                                                    Padding(
                                                                      padding:
                                                                          const EdgeInsets.all(
                                                                              8.0),
                                                                      child:
                                                                          SizedBox(
                                                                        width: size
                                                                                .width *
                                                                            0.43,
                                                                        height:
                                                                            50,
                                                                        child:
                                                                            ElevatedButton(
                                                                          style: ButtonStyle(
                                                                              backgroundColor: MaterialStatePropertyAll<Color>(colorgreen),
                                                                              shape: MaterialStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
                                                                                borderRadius: BorderRadius.circular(18.0),
                                                                              ))),
                                                                          onPressed:
                                                                              () async {
                                                                            final FirebaseAuth
                                                                                auth =
                                                                                await FirebaseAuth.instance;
                                                                            final User?
                                                                                user =
                                                                                auth.currentUser;
                                                                            final userID =
                                                                                user!.email;
                                                                            removeFromCart(
                                                                                products[index].id.toString(),
                                                                                userID!);
                                                                            Navigator.pop(
                                                                                context);
                                                                          },
                                                                          child:
                                                                              Text(
                                                                            'Confirm',
                                                                            style: TextStyle(
                                                                                fontSize: 18,
                                                                                color: colorwhite),
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
                                          width: size.width * 0.6,
                                          child: Padding(
                                            padding: const EdgeInsets.only(
                                                left: 12.0, bottom: 0, top: 0),
                                            child: Text(
                                              products[index].subtitle.toString(),
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
                                                products[index].color.toString(),
                                                style:
                                                    const TextStyle(fontSize: 15),
                                              ),
                                              const Padding(
                                                padding:
                                                    EdgeInsets.only(left: 8.0),
                                                child: Text(
                                                  '|',
                                                  style: TextStyle(fontSize: 18),
                                                ),
                                              ),
                                              Center(
                                                child: Padding(
                                                  padding: const EdgeInsets.only(
                                                      left: 8.0),
                                                  child: Text(
                                                    'Size : ${products[index].size.toString()}',
                                                    textAlign: TextAlign.center,
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
                                              .doc(
                                                products[index].id.toString(),
                                              )
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
                                              padding: const EdgeInsets.symmetric(
                                                  vertical: 10.0),
                                              child: Wrap(
                                                alignment:
                                                    WrapAlignment.spaceBetween,
                                                // crossAxisAlignment:
                                                //     CrossAxisAlignment
                                                //         .stretch,
                                                // mainAxisAlignment:
                                                //     MainAxisAlignment
                                                //         .spaceBetween,
                                                children: [
                                                  SizedBox(
                                                    width: size.width * 0.245,
                                                    child: Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 12.0,
                                                              top: 0,
                                                              bottom: 0),
                                                      child: Row(
                                                        children: [
                                                          Text(
                                                            '₹${products[index].price.toString()}',
                                                            style: const TextStyle(
                                                                overflow:
                                                                    TextOverflow
                                                                        .fade,
                                                                fontSize: 25),
                                                            textAlign:
                                                                TextAlign.start,
                                                          ),
                                                          Text(
                                                            '×${snapshot.data['productCount']}',
                                                            style: TextStyle(
                                                                color: colorblack
                                                                    .withOpacity(
                                                                        0.5),
                                                                fontSize: 15),
                                                            textAlign:
                                                                TextAlign.start,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding: EdgeInsets.only(
                                                        left: size.width * 0.12,
                                                        right: 10),
                                                    child: Container(
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(20),
                                                          color: colorgreen),
                                                      width: size.width * 0.287,
                                                      height: size.width * 0.09,
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .center,
                                                        children: [
                                                          ValueListenableBuilder(
                                                            valueListenable:
                                                                totalPriceNotifier,
                                                            builder: (context,
                                                                    priceValue,
                                                                    child) =>
                                                                IconButton(
                                                              icon: const Icon(
                                                                CustomIcon
                                                                    .minusiconfluttter,
                                                                size: 14,
                                                              ),
                                                              onPressed: () {
                                                                if (snapshot.data[
                                                                        'productCount'] !=
                                                                    1) {
                                                                  totalPriceNotifier
                                                                          .value =
                                                                      priceValue -
                                                                          products[index]
                                                                              .price!;
                                                                  addOrRemoveFromcart(
                                                                      products[
                                                                              index]
                                                                          .id
                                                                          .toString(),
                                                                      false);
                                                                  // getTotalPrice();
                                                                  // setState(
                                                                  //     () {
                                                                  //   cartcount =
                                                                  //       data['id'];
                                                                  // });
                                                                }
                                                              },
                                                            ),
                                                          ),
                                                          Text(
                                                              '${snapshot.data['productCount']}'
                                                                  .toString()),
                                                          ValueListenableBuilder(
                                                            valueListenable:
                                                                totalPriceNotifier,
                                                            builder: (context,
                                                                    priceValue,
                                                                    child) =>
                                                                IconButton(
                                                                    icon:
                                                                        const Icon(
                                                                      CustomIcon
                                                                          .addiconfluttter,
                                                                      size: 14,
                                                                    ),
                                                                    onPressed:
                                                                        () {
                                                                      totalPriceNotifier
                                                                              .value =
                                                                          priceValue +
                                                                              products[index].price!;
                                                                      addOrRemoveFromcart(
                                                                          products[index]
                                                                              .id!,
                                                                          true);
                                                                      // getTotalPrice();
                                                                    }),
                                                          ),
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
                      } else {
                        Center(
                          child: CircularProgressIndicator(),
                        );
                      }
                    },
                  ),
                
              ]),
            )),
        Positioned(
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
                              fontSize: 15, color: colorblack.withOpacity(0.5)),
                        ),
                        totalPrice != 0
                            ? ValueListenableBuilder(
                                valueListenable: totalPriceNotifier,
                                builder: (context, priceValue, child) => Text(
                                  '₹$priceValue',
                                  style: const TextStyle(fontSize: 28),
                                ),
                              )
                            : Center(
                                child: SizedBox(
                                width: size.width * 0.05,
                                height: size.width * 0.05,
                                child: const CircularProgressIndicator(),
                              ))
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: CustomButton(
                      text: 'Checkout',
                      icon: CustomIcon.ticksquareiconfluttter,
                      width: 0.69,
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

  // removes data from firestore
  void removeFromCart(String docId, String id) {
    CollectionReference collectionReference =
        FirebaseFirestore.instance.collection('users');
    collectionReference.doc(id).collection('cart').doc(docId).delete();
  }
}
