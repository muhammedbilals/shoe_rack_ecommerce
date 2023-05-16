import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shoe_rack_ecommerce/core/colors/colors.dart';
import 'package:shoe_rack_ecommerce/core/constant/constant.dart';
import 'package:shoe_rack_ecommerce/core/icons/custom_icon_icons.dart';
import 'package:shoe_rack_ecommerce/presentation/cart_page/screens/cart_page.dart';

class ProductPage extends StatelessWidget {
  ProductPage({
    super.key,
    required this.id,
  });
  List<String> colorList = <String>['Black', 'Red', 'White', 'Blue'];
  List<String> sizeList = <String>['9', '10', '11', '12'];
  final String id;
  int choiceChipColorValue = 0;
  int choiceChipSizeValue = 0;

  addToCart(String id, String color, int size) async {
    int productCount = 1;
    final FirebaseAuth auth = FirebaseAuth.instance;
    final User? user = auth.currentUser;
    final userID = user!.email;
    final collectionReference = FirebaseFirestore.instance
        .collection('users')
        .doc(userID)
        .collection('cart')
        .doc(id);

    collectionReference.set({
      'productId': id,
      'productCount': productCount,
      'color': color,
      'size': size
    });
    log('added to cart');
  }

  Future<bool> checkIfAvailable(String color, int size, String docId) async {
    final DocumentReference docRef =
        FirebaseFirestore.instance.collection('product').doc(docId);
    final DocumentSnapshot docSnapshot = await docRef.get();

    if (docSnapshot.exists) {
      // document exists, check if field value is equal to the desired value
      final dynamic fieldValue = docSnapshot['color'];
      log(docSnapshot.toString());
      if (fieldValue == color) {
        // field value is equal to the desired value
        log('[data availbale]');
        log(fieldValue);
        addToCart(docId, color, size);
        return true;
      } else {
        // field value is not equal to the desired value
      }
    } else {
      log('data not found');
      return false;
      // document does not exist
    }
    log("no data");
    return false;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Positioned(
              bottom: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: size.width * 0.2,
                      height: 60,
                      //add to wishlist button
                      child: ElevatedButton(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll<Color>(colorwhite),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              side: BorderSide(color: colorgreen, width: 2),
                              borderRadius: BorderRadius.circular(18.0),
                            ))),
                        onPressed: () {},
                        child: Icon(
                          CustomIcon.hearticonfluttter,
                          size: 25,
                          color: colorblack,
                        ),
                      ),
                    ),
                  ),
                  //add to cart Button

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: SizedBox(
                      width: size.width * 0.7,
                      height: 60,
                      child: ElevatedButton.icon(
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll<Color>(colorgreen),
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18.0),
                            ))),
                        onPressed: () {
                          // addToCart(id);
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //       builder: (context) => CartPage(),
                          //     ));
                          showModalBottomSheet(
                            context: context,
                            builder: (context) {
                              return Container(
                                decoration: BoxDecoration(
                                    color: colorwhite,
                                    borderRadius: BorderRadius.circular(20)),
                                height: size.height * 0.45,
                                child: Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    // mainAxisSize: MainAxisSize.min,
                                    children: [
                                      sbox,
                                      const Padding(
                                        padding: EdgeInsets.all(10.0),
                                        child: Text(
                                          'Add to Cart',
                                          style: TextStyle(fontSize: 22),
                                        ),
                                      ),
                                      const Divider(
                                        endIndent: 30,
                                        indent: 30,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(left: 12.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: [
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.all(10.0),
                                                  child: Text(
                                                    'Select Color',
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                ),
                                                //color choice chip
                                                StatefulBuilder(
                                                  builder:
                                                      (BuildContext context,
                                                          setState) {
                                                    return Wrap(
                                                      spacing: 5.0,
                                                      children:
                                                          List<Widget>.generate(
                                                        3,
                                                        (int index) {
                                                          return ChoiceChip(
                                                            disabledColor:
                                                                colorgray,
                                                            selectedColor:
                                                                colorgreen,
                                                            label: Text(
                                                                colorList[
                                                                    index]),
                                                            selected:
                                                                choiceChipColorValue ==
                                                                    index,
                                                            onSelected: (bool
                                                                selected) {
                                                              setState(() {
                                                                choiceChipColorValue =
                                                                    (selected
                                                                        ? index
                                                                        : index);
                                                              });
                                                            },
                                                          );
                                                        },
                                                      ).toList(),
                                                    );
                                                  },
                                                ),
                                                const Padding(
                                                  padding: EdgeInsets.all(12.0),
                                                  child: Text(
                                                    'Select size',
                                                    style:
                                                        TextStyle(fontSize: 18),
                                                  ),
                                                ),
                                                StatefulBuilder(
                                                  builder:
                                                      (BuildContext context,
                                                          setState) {
                                                    return Wrap(
                                                      spacing: 5.0,
                                                      children:
                                                          List<Widget>.generate(
                                                        3,
                                                        (int index) {
                                                          return ChoiceChip(
                                                            disabledColor:
                                                                colorgray,
                                                            selectedColor:
                                                                colorgreen,
                                                            label: Text(
                                                                sizeList[
                                                                    index]),
                                                            selected:
                                                                choiceChipSizeValue ==
                                                                    index,
                                                            onSelected: (bool
                                                                selected) {
                                                              setState(() {
                                                                choiceChipSizeValue =
                                                                    (selected
                                                                        ? index
                                                                        : index);
                                                              });
                                                            },
                                                          );
                                                        },
                                                      ).toList(),
                                                    );
                                                  },
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      sbox,
                                      Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: SizedBox(
                                                width: size.width * 0.43,
                                                height: 50,
                                                child: ElevatedButton(
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStatePropertyAll<
                                                            Color>(colorgray),
                                                    shape: MaterialStateProperty
                                                        .all<
                                                            RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(18.0),
                                                      ),
                                                    ),
                                                  ),
                                                  onPressed: () {
                                                    Navigator.pop(context);
                                                  },
                                                  child: Text(
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
                                                  const EdgeInsets.all(8.0),
                                              child: SizedBox(
                                                width: size.width * 0.43,
                                                height: 50,
                                                child: ElevatedButton(
                                                  style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStatePropertyAll<
                                                            Color>(colorgreen),
                                                    shape: MaterialStateProperty
                                                        .all<
                                                            RoundedRectangleBorder>(
                                                      RoundedRectangleBorder(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(18.0),
                                                      ),
                                                    ),
                                                  ),
                                                  onPressed: () async {
                                                    await checkIfAvailable(
                                                        colorList[
                                                            choiceChipColorValue],
                                                        10,
                                                        id);
                                                    Navigator.pop(context);
                                                    // addToCart(
                                                    //     id,
                                                    //     choiceChipColorValue
                                                    //         .toString(),
                                                    //     choiceChipSizeValue);
                                                    Text('not found');
                                                  },
                                                  child: Text(
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
                        icon: Icon(
                          CustomIcon.bagiconfluttter,
                          size: 25,
                          color: colorwhite,
                        ),
                        label: Text(
                          'Add to Cart',
                          style: TextStyle(fontSize: 25, color: colorwhite),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("product")
                  .doc(id)
                  .snapshots(),
              // initialData: initialData,
              builder: (BuildContext context, AsyncSnapshot snapshot) {
                List<String> img = [];

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }
                img.add(snapshot.data['imgurl']);
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CarouselSlider(
                      options: CarouselOptions(
                          aspectRatio: 1 / 1, viewportFraction: 1),
                      items: img.map((i) {
                        return Builder(
                          builder: (BuildContext context) {
                            return CarouselSlider.builder(
                              options: CarouselOptions(
                                  viewportFraction: 1, aspectRatio: 1 / 1),
                              itemCount: img.length,
                              itemBuilder: (context, index, realIndex) {
                                return SizedBox(
                                  width: size.width,
                                  height: size.width,
                                  child: Image.network(
                                    img[index],
                                    fit: BoxFit.cover,
                                  ),
                                );
                              },
                            );
                          },
                        );
                      }).toList(),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Text(
                        snapshot.data['name'],
                        style: const TextStyle(fontSize: 25),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text(
                        snapshot.data['subtitle'],
                        style: TextStyle(
                            // overflow: TextOverflow.clip,
                            fontSize: 20,
                            color: colorblack.withOpacity(0.5)),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.only(left: 12.0, top: 5),
                    //   child: Row(
                    //     children: [
                    //       const Text(
                    //         '4.5',
                    //         style: TextStyle(fontSize: 20),
                    //       ),
                    //       const Icon(
                    //         CustomIcon.stariconfluttter,
                    //         size: 17,
                    //       ),
                    //       const Padding(
                    //         padding: EdgeInsets.symmetric(horizontal: 8.0),
                    //         child: Text(
                    //           '|',
                    //           style: TextStyle(fontSize: 20),
                    //         ),
                    //       ),
                    //       Padding(
                    //         padding: const EdgeInsets.only(left: 8.0),
                    //         child: Container(
                    //           width: size.width * 0.25,
                    //           height: size.width * 0.07,
                    //           decoration: BoxDecoration(
                    //               borderRadius: BorderRadius.circular(20),
                    //               color: colorgray),
                    //           child: const Center(
                    //             child: Text(
                    //               '4300 SOLD',
                    //               textAlign: TextAlign.center,
                    //             ),
                    //           ),
                    //         ),
                    //       ),
                    //     ],
                    //   ),
                    // ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text(
                        '₹${snapshot.data['price']}',
                        style: const TextStyle(fontSize: 35),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text(
                        snapshot.data['description'],
                        style: TextStyle(
                            // overflow: TextOverflow.clip,
                            fontSize: 15,
                            color: colorblack.withOpacity(0.5)),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    sbox,
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text(
                        'Available Colors',
                        style: TextStyle(
                            // overflow: TextOverflow.clip,
                            fontSize: 20,
                            color: colorblack),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.red,
                                border: Border.all(
                                    width: 2, style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(50)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.green,
                                border: Border.all(
                                    width: 2, style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(50)),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            width: 40,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.black,
                                border: Border.all(
                                    width: 2, style: BorderStyle.solid),
                                borderRadius: BorderRadius.circular(50)),
                          ),
                        ),
                      ],
                    ),
                    sbox,
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0),
                      child: Text(
                        'Available Size',
                        style: TextStyle(
                            // overflow: TextOverflow.clip,
                            fontSize: 20,
                            color: colorblack),
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
