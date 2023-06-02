import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce/core/colors/colors.dart';
import 'package:shoe_rack_ecommerce/core/icons/custom_icon_icons.dart';
import 'package:shoe_rack_ecommerce/core/model/product.dart';
import 'package:shoe_rack_ecommerce/presentation/product_page/screens/product_page.dart';

class SearchScreen extends StatelessWidget {
  SearchScreen({super.key});
  static TextEditingController controller = TextEditingController();
  final ValueNotifier<String> _notifier = ValueNotifier('');

  Stream getProducts() async* {
    final QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('product').get();
    final List<DocumentSnapshot> docs = querySnapshot.docs.toList();
    yield docs;
  }

  List<Product> convertToProductsList(List<DocumentSnapshot> documents) {
    return documents.map((snapshot) {
      return Product.fromJson(snapshot.data() as Map<String, dynamic>);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        // appBar: const PreferredSize(
        //     preferredSize: Size.fromHeight(60),
        //     child: AppBarWidget(title: 'My Wishlist')),
        body: ListView(
          children: [
            Padding(
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
                child: StatefulBuilder(
                  builder: (context, setState) {
                    return Row(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(9.0),
                          child: Icon(
                            CustomIcon.search_2iconfluttter,
                            size: 20,
                          ),
                        ),
                        SizedBox(
                          height: 40,
                          width: 300,
                          child: Center(
                            child: TextField(
                                decoration: const InputDecoration.collapsed(
                                    hintText: 'Search',
                                    hintStyle: TextStyle(fontSize: 19)),
                                onChanged: (value) {
                                  _notifier.value = value;
                                }),
                          ),
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
            ValueListenableBuilder<String>(
              valueListenable: _notifier,
              builder: (BuildContext context, String value, Widget? child) {
                return StreamBuilder(
                    stream: getProducts(),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.hasError) {
                        return const Text('Something went wrong');
                      }
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Text("Loading");
                      }
                      if (snapshot.hasData) {
                        List<DocumentSnapshot> documents = snapshot.data!;
                        List<Product> productList =
                            convertToProductsList(documents);
                        List<Product> searchList = productList
                            .where((element) => element.name
                                .toString()
                                .toLowerCase()
                                .contains(value
                                    .toLowerCase()
                                    .replaceAll(RegExp(r"\s+"), "")))
                            .toList();
                        return GridView.count(
                            padding: const EdgeInsets.only(left: 15),
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            crossAxisCount: 2,
                            crossAxisSpacing: 1,
                            mainAxisSpacing: 20,
                            childAspectRatio: 1 / 1.42,
                            children: List.generate(
                                searchList.length,
                                (index) => GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) => ProductPage(
                                                  
                                                  id: searchList[index].id!),
                                            ));
                                        // valueNotifier.value = searchList[index].id'];
                                        print(
                                            'value notifirer value ${searchList[index].id}');
                                      },
                                      child: SizedBox(
                                        width: size.width * 0.6,
                                        height: size.width * 0.6,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Stack(
                                              children: [
                                                Container(
                                                    width: size.width * 0.45,
                                                    height: size.width * 0.45,
                                                    decoration: BoxDecoration(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              20),
                                                    ),
                                                    child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(10),
                                                        child: Image.network(
                                                          searchList[index]
                                                              .imgurl!,
                                                          fit: BoxFit.cover,
                                                        ))
                                                    // const Align(
                                                    //     alignment: Alignment.topRight,
                                                    //     child: Padding(
                                                    //       padding: EdgeInsets.all(10.0),
                                                    //       child: Icon(Icons.favorite_border_outlined),
                                                    //     )),
                                                    ),
                                                // FavouriteButton(
                                                //   productId: searchList[index].id'],
                                                // ),
                                              ],
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                left: 8.0,
                                                right: 8.0,
                                                top: 8.0,
                                              ),
                                              child: Text(
                                                searchList[index].name,
                                                style: const TextStyle(
                                                    fontSize: 20),
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(
                                                searchList[index].subtitle,
                                                overflow: TextOverflow.ellipsis,
                                                style: TextStyle(
                                                    // overflow: TextOverflow.clip,
                                                    fontSize: 14,
                                                    color: colorblack
                                                        .withOpacity(0.5)),
                                                textAlign: TextAlign.start,
                                              ),
                                            ),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Text(
                                                'Rs. ${searchList[index].price}',
                                                style: const TextStyle(
                                                    fontSize: 22),
                                              ),
                                            )
                                          ],
                                        ),
                                      ),
                                    )));
                      }
                      return const Text('data');
                    });
              },
            ),
          ],
        ),
      ),
    );
  }
}
