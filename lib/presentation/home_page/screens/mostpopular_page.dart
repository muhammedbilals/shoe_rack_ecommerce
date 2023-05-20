import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce/core/colors/colors.dart';
import 'package:shoe_rack_ecommerce/presentation/common_widget/AppBarWidget.dart';
import 'package:shoe_rack_ecommerce/presentation/home_page/widgets/wishlistButton.dart';
import 'package:shoe_rack_ecommerce/presentation/product_page/screens/product_page.dart';

class MostPopularPage extends StatefulWidget {
  const MostPopularPage({super.key});

  @override
  State<MostPopularPage> createState() => _MostPopularPageState();
}
  List<String> brands = ['Adidas', 'puma', 'Fila'];
final Stream<QuerySnapshot> _usersStream =
    FirebaseFirestore.instance.collection('product').where('name' ,isEqualTo: brands[chipvalue]).snapshots();
 int chipvalue = 0;
class _MostPopularPageState extends State<MostPopularPage> {
 

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SafeArea(
        child: Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBarWidget(title: 'Most Popular')),
      body: ListView(
        children: [
          Wrap(
            children: List<Widget>.generate(
              3,
              (int index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5.0),
                  child: ChoiceChip(
                    disabledColor: colorgray,
                    selectedColor: colorgreen,
                    label: Text(brands[index]),
                    selected: chipvalue == index,
                    onSelected: (bool selected) {
                      setState(() {
                        chipvalue = (selected ? index : index);
                      });
                    },
                  ),
                );
              },
            ).toList(),
          ),
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
                              builder: (context) => ProductPage(id: data['id']),
                            ));
                        // valueNotifier.value = data['id'];
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
        ],
      ),
    ));
  }
}
