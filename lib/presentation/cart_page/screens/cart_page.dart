import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shoe_rack_ecommerce/core/colors.dart';

import '../../common_widget/AppBarWidget.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        appBar: const PreferredSize(
            child: AppBarWidget(title: 'My Cart'),
            preferredSize: Size.fromHeight(60)),
        body: ListView(
          children: [
            Padding(
              padding: const EdgeInsets.all(15.0),
              child: Container(
                width: size.width * 0.9,
                height: size.width * 0.3,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20), color: colorgray),
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        width: 100,
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: Image.asset('asset/images/nikeimg.png')),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              color: Colors.amber,
                              child: const Padding(
                                padding: EdgeInsets.only(
                                    left: 12.0, top: 10, bottom: 8),
                                child: Text(
                                  'Puma',
                                  style: TextStyle(fontSize: 20),
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                            Icon(Icons.delete_outline)
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 12.0, bottom: 8, top: 5),
                          child: Text(
                            'Men Black Solid Adivat Running Shoes',
                            style: TextStyle(
                                // overflow: TextOverflow.clip,
                                fontSize: 15,
                                color: colorblack.withOpacity(0.5)),
                            textAlign: TextAlign.start,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 12.0, top: 4),
                          child: Row(
                            children: [
                              const Text(
                                'White',
                                style: TextStyle(fontSize: 15),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Text(
                                  '|',
                                  style: TextStyle(fontSize: 20),
                                ),
                              ),
                              const Center(
                                child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Text(
                                    'Size : 42',
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 25.0),
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(20),
                                      color: colorgreen),
                                  width: size.width * 0.25,
                                  height: size.width * 0.09,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceAround,
                                    children: [
                                      IconButton(
                                        icon: Icon(Icons.remove),
                                        onPressed: () {},
                                      ),
                                      Text('1'),
                                      Container(
                                        child: IconButton(
                                          icon: Icon(Icons.add),
                                          onPressed: () {},
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
