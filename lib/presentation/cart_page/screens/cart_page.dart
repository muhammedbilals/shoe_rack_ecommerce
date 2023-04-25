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
        body: Stack(children: [
          ListView(
            children: [
              CartDetailsWidget(size: size),
              CartDetailsWidget(size: size),
              CartDetailsWidget(size: size),
              CartDetailsWidget(size: size),
              CartDetailsWidget(size: size),
            ],
          ),
          Positioned(
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
                        Text(
                          '₹7,500',
                          style: TextStyle(fontSize: 30),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: SizedBox(
                        width: size.width * 0.72,
                        height: 60,
                        child: ElevatedButton.icon(
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll<Color>(colorgreen),
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18.0),
                              ))),
                          onPressed: () {},
                          icon: Icon(
                            Icons.check_box_outlined,
                            size: 25,
                            color: colorwhite,
                          ),
                          label: Text(
                            'Checkout',
                            style: TextStyle(fontSize: 25, color: colorwhite),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }
}

class CartDetailsWidget extends StatelessWidget {
  const CartDetailsWidget({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Padding(
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
                  // crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 12.0, top: 10, bottom: 8),
                      child: Text(
                        'Puma',
                        style: TextStyle(fontSize: 20),
                        textAlign: TextAlign.start,
                      ),
                    ),
                    const Icon(Icons.delete_outline)
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 12.0, bottom: 8, top: 5),
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
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              IconButton(
                                icon: const Icon(Icons.remove),
                                onPressed: () {},
                              ),
                              const Text('1'),
                              Container(
                                child: IconButton(
                                  icon: const Icon(Icons.add),
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
    );
  }
}
