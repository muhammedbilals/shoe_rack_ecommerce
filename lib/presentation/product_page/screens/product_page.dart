import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shoe_rack_ecommerce/core/colors/colors.dart';
import 'package:shoe_rack_ecommerce/core/icons/custom_icon_icons.dart';

class ProductPage extends StatelessWidget {
  ProductPage({
    super.key,
    required this.id,

    //  required this.id
  });
  // final String id;
  final String id;

  // final img = [
  //   'asset/images/Puma.png',
  //   'asset/images/puma22.png',
  //   'asset/images/puma33.png'
  // ];
  final Stream<QuerySnapshot> _usersStream =
      FirebaseFirestore.instance.collection('product').snapshots();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
        child: Scaffold(
            body: Stack(children: [
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
                child: ElevatedButton(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(colorwhite),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
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
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: size.width * 0.7,
                height: 60,
                child: ElevatedButton.icon(
                  style: ButtonStyle(
                      backgroundColor:
                          MaterialStatePropertyAll<Color>(colorgreen),
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18.0),
                      ))),
                  onPressed: () {},
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
            ),
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
                options:
                    CarouselOptions(aspectRatio: 1 / 1, viewportFraction: 1),
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
              //  StreamBuilder(
              //   stream: FirebaseFirestore.instance
              //       .collection("product")
              //       .doc(id)
              //       .snapshots(),
              //   // initialData: initialData,
              //   builder: (BuildContext context, AsyncSnapshot snapshot) {
              //     if (!snapshot.hasData) return LinearProgressIndicator();
              //     print('ashfulsahdgfliushadgfoiuahsdfhs${snapshot.data['name']}');

              Container(
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Text(
                    snapshot.data['name'],
                    style: const TextStyle(fontSize: 25),
                    textAlign: TextAlign.start,
                  ),
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
                  snapshot.data['price'],
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
                      fontSize: 18,
                      color: colorblack.withOpacity(0.5)),
                  textAlign: TextAlign.start,
                ),
              ),
            ],
          );
        },
      ),
    ])));
  }
}
