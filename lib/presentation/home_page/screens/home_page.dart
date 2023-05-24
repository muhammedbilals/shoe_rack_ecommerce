import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce/core/colors/colors.dart';
import 'package:shoe_rack_ecommerce/core/constant/constant.dart';
import 'package:shoe_rack_ecommerce/core/icons/custom_icon_icons.dart';

import 'package:shoe_rack_ecommerce/presentation/home_page/screens/mostpopular_page.dart';
import 'package:shoe_rack_ecommerce/presentation/home_page/screens/my_wishlist_page.dart';
import 'package:shoe_rack_ecommerce/presentation/home_page/widgets/WishlistButton.dart';
import 'package:shoe_rack_ecommerce/presentation/home_page/widgets/brand_list_tile.dart';
import 'package:shoe_rack_ecommerce/presentation/product_page/screens/product_page.dart';
import 'package:shoe_rack_ecommerce/presentation/search_page/search_screen.dart';

// ignore: must_be_immutable
class HomePage extends StatelessWidget {
  HomePage({super.key});
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('product').snapshots();
  ValueNotifier<String> valueNotifier = ValueNotifier('');
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: size,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 5),
                child: SizedBox(
                  width: 170,
                  height: 50,
                  child: Image.asset('asset/images/shoeracklogovert.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: IconButton(
                  icon: const Icon(CustomIcon.hearticonfluttter),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const WishListScreen(),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(children: [
            // searchBar----------------------
            GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SearchScreen(),
                    ));
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: BoxDecoration(
                      // border: Border(
                      //   bottom: BorderSide(width: 3, color: colorgreen),
                      // ),
                      // boxShadow: [
                      //   BoxShadow(blurRadius: 25),
                      // ],
                      color: colorgray,
                      borderRadius: BorderRadius.circular(20)),
                  child: const Row(
                    children: [
                      Padding(
                        padding: EdgeInsets.all(9.0),
                        child: Icon(
                          CustomIcon.search_2iconfluttter,
                          size: 20,
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        width: 300,
                        // child: Center(
                        //   child: TextField(
                        //     decoration: InputDecoration.collapsed(
                        //         hintText: 'Search',
                        //         hintStyle: TextStyle(fontSize: 19)),
                        //   ),
                        // ),
                      )
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                width: size.width,
                height: 200,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: Image.asset(
                  'asset/images/Group23pumalogo.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            const BrandListTile(),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Most Popular',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.start,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MostPopularPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'SEE ALL',
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            ),
            sbox,
            StreamBuilder<QuerySnapshot>(
                stream: _usersStream,
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Text('Something went wrong');
                  }

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
                                builder: (context) =>
                                    ProductPage(id: data['id']),
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
                              Stack(children: [
                                Container(
                                    width: size.width * 0.45,
                                    height: size.width * 0.45,
                                    decoration: BoxDecoration(
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
                                FavouriteButton(
                                  productId: data['id'],
                                ),
                              ]),
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
                                      color: colorblack.withOpacity(0.5)),
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
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: const [

            //     ProductCardWidget(),
            //   ],
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: const [

            //     ProductCardWidget(),
            //   ],
            // ),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.center,
            //   children: const [
            //     ProductCardWidget(),
            //     ProductCardWidget(),
            //   ],
            // ),
          ]),
        ),
      ),
    );
  }
}

final FirebaseAuth auth = FirebaseAuth.instance;
final User? user = auth.currentUser;
final userID = user!.email;
final CollectionReference userCollection = FirebaseFirestore.instance
    .collection('users')
    .doc(userID)
    .collection('wishlist');

// DocumentReference usersRef = FirebaseFirestore.instance.collection('product').doc();

class BrandTileWidget extends StatelessWidget {
  final String image;
  final String logoname;
  const BrandTileWidget({
    required this.image,
    super.key,
    required this.logoname,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorgray,
              // color: Colors.amber,
            ),
            height: size.width * 0.15,
            width: size.width * 0.15,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          Text(
            overflow: TextOverflow.ellipsis,
            logoname,
            style: const TextStyle(fontSize: 16),
          )
        ],
      ),
    );
  }
}
