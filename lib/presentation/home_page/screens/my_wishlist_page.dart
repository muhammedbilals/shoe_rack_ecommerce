import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce/core/colors/colors.dart';
import 'package:shoe_rack_ecommerce/core/icons/custom_icon_icons.dart';
import 'package:shoe_rack_ecommerce/presentation/common_widget/AppBarWidget.dart';
import 'package:shoe_rack_ecommerce/presentation/product_page/screens/product_page.dart';

class WishListScreen extends StatefulWidget {
  WishListScreen({super.key});

  @override
  State<WishListScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<WishListScreen> {
  ValueNotifier<String> valueNotifier = ValueNotifier('');

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
        .collection('wishlist');

    ordersRef.get().then((QuerySnapshot querySnapshot) {
      querySnapshot.docs.forEach((doc) {
        // var orderData = doc.data();
        ids.add(doc.get('product'));
        log(doc.toString());
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
    log('buildmethode called');
    final Size size = MediaQuery.of(context).size;
    if (ids.isEmpty) {
      return Scaffold(
          backgroundColor: colorwhite,
          body: const Center(child: CircularProgressIndicator()));
    }
    return SafeArea(
        child: Scaffold(
      backgroundColor: colorwhite,
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBarWidget(title: 'My Wishlist')),
      body: SingleChildScrollView(
        child: Column(children: [
          StreamBuilder<QuerySnapshot>(
              stream: FirebaseFirestore.instance
                  .collection('product')
                  .where('id', whereIn: ids)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return const Text('Something went wrong');
                }
                // return const Text('Something went wrong');

                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Text("Loading");
                }
                return GridView.count(
                  padding: const EdgeInsets.only(left: 15),
                  clipBehavior: Clip.none,
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: 2,
                  crossAxisSpacing: 1,
                  mainAxisSpacing: 20,
                  childAspectRatio: 1 / 1.45,
                  children:
                      snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map<String, dynamic> data =
                        document.data()! as Map<String, dynamic>;
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProductPage(id: data['id']),
                            ));
                        valueNotifier.value = data['id'];
                        print('value notifirer value ${data['id']}');
                      },
                      child: SizedBox(
                        width: size.width * 0.6,
                        height: size.width * 0.6,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Stack(
                              children: [
                                Container(
                                    width: size.width * 0.45,
                                    height: size.width * 0.45,
                                    decoration: BoxDecoration(
                                      color: colorgray,
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Image.network(
                                          data['imgurl'],
                                          fit: BoxFit.cover,
                                        ))
                                    // const Align(
                                    //     alignment: Alignment.topRight,
                                    //     child: Padding(
                                    //       padding: EdgeInsets.all(10.0),
                                    //       child: Icon(Icons.favorite_border_outlined),
                                    //     )),
                                    ),
                                Positioned(
                                  top: 5,
                                  right: 5,
                                  child: IconButton(
                                    icon: Icon(
                                      CustomIcon.hearticonfluttter,
                                      color: colorgreen,
                                    ),
                                    onPressed: () async {
                                      QuerySnapshot querySnapshot =
                                          await FirebaseFirestore.instance
                                              .collection('users')
                                              .doc('$userID')
                                              .collection('wishlist')
                                              .where('product', whereIn: ids)
                                              .get();
                                      log('asdfasdfadsfdfa${querySnapshot.docs.first.id}');
                                      await userCollection
                                          .doc(querySnapshot.docs.first.id)
                                          .delete();
                                      debugPrint('produt deleteted $userID');
                                      setState(() {});
                                    },
                                  ),
                                )
                              ],
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                left: 8.0,
                                right: 8.0,
                                top: 8.0,
                              ),
                              child: Text(
                                data['name'],
                                style: const TextStyle(fontSize: 20),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                data['subtitle'],
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  // overflow: TextOverflow.clip,
                                  fontSize: 14,
                                  color: colorblack.withOpacity(0.5),
                                ),
                                textAlign: TextAlign.start,
                              ),
                            ),
                            // Padding(
                            //   padding: const EdgeInsets.only(
                            //       left: 8.0, top: 5),
                            //   child: Row(
                            //     children: [
                            //       const Text(
                            //         '4.5',
                            //         style: TextStyle(fontSize: 17),
                            //       ),
                            //       const Icon(
                            //         CustomIcon.stariconfluttter,
                            //         size: 14,
                            //       ),
                            //       const Padding(
                            //         padding: EdgeInsets.symmetric(
                            //             horizontal: 8.0),
                            //         child: Text('|'),
                            //       ),
                            //       Padding(
                            //         padding:
                            //             const EdgeInsets.only(left: 8.0),
                            //         child: Container(
                            //           width: size.width * 0.2,
                            //           height: size.width * 0.05,
                            //           decoration: BoxDecoration(
                            //               borderRadius:
                            //                   BorderRadius.circular(20),
                            //               color: colorgray),
                            //           child: const Padding(
                            //             padding: EdgeInsets.all(2.0),
                            //             child: Text(
                            //               '4300 SOLD',
                            //               textAlign: TextAlign.center,
                            //             ),
                            //           ),
                            //         ),
                            //       )
                            //     ],
                            //   ),
                            // ),
                            Padding(
                              padding: const EdgeInsets.only(left: 8.0),
                              child: Text(
                                'Rs. ${data['price']}',
                                style: const TextStyle(fontSize: 22),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                );
              }),
        ]),
      ),
    ));
  }
}

class FavouriteRemoveButton extends StatefulWidget {
  const FavouriteRemoveButton({
    super.key,
    required this.productId,
  });
  final String productId;

  @override
  State<FavouriteRemoveButton> createState() => _FavouriteRemoveButtonState();
}

final FirebaseAuth auth = FirebaseAuth.instance;
final User? user = auth.currentUser;
final userID = user!.email;
final CollectionReference userCollection = FirebaseFirestore.instance
    .collection('users')
    .doc(userID)
    .collection('wishlist');

// DocumentReference usersRef = FirebaseFirestore.instance.collection('product').doc();

class _FavouriteRemoveButtonState extends State<FavouriteRemoveButton> {
  @override
  Widget build(BuildContext context) {
    return Positioned(
        top: 5,
        right: 5,
        child: IconButton(
          icon: Icon(
            CustomIcon.hearticonfluttter,
            color: colorgreen,
          ),
          onPressed: () async {
            QuerySnapshot querySnapshot = await FirebaseFirestore.instance
                .collection('users')
                .doc('$userID')
                .collection('wishlist')
                .where('product', isEqualTo: widget.productId)
                .get();

            await userCollection.doc(querySnapshot.docs.first.id).delete();
            debugPrint('produt deleteted $userID');
            setState(() {});
          },
        ));
  }
}
