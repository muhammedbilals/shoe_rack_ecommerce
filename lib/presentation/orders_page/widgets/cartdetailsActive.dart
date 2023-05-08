import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce/core/colors/colors.dart';
import 'package:shoe_rack_ecommerce/core/constant/constant.dart';
import 'package:shoe_rack_ecommerce/core/icons/custom_icon_icons.dart';
import 'package:shoe_rack_ecommerce/presentation/orders_page/screens/track_order_page.dart';

class OrderDetailsActive extends StatelessWidget {
  const OrderDetailsActive({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Container(
            width: size.width * 0.98,
            height: size.width * 0.45,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20), color: colorgray),
            child: Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: 80,
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.asset('asset/images/nikeimg.png')),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: size.width * 0.64,
                      child: const Padding(
                        padding: EdgeInsets.only(left: 12.0, top: 0, bottom: 0),
                        child: Text(
                          'Puma',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    sbox,
                    SizedBox(
                      width: size.width * 0.6,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 12.0, bottom: 0, top: 0),
                        child: Text(
                          'Men Black Solid Adivat Running Shoes',
                          style: TextStyle(
                              // overflow: TextOverflow.clip,
                              fontSize: 15,
                              color: colorblack.withOpacity(0.5)),
                          textAlign: TextAlign.start,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 12.0, top: 5),
                      child: Row(
                        children: const [
                          Text(
                            'White',
                            style: TextStyle(fontSize: 15),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 8.0),
                            child: Text(
                              '|',
                              style: TextStyle(fontSize: 18),
                            ),
                          ),
                          Center(
                            child: Padding(
                              padding: EdgeInsets.only(left: 8.0),
                              child: Text(
                                'Size : 42',
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Padding(
                            padding:
                                EdgeInsets.only(left: 12.0, top: 0, bottom: 0),
                            child: Text(
                              '₹7,500',
                              style: TextStyle(fontSize: 25),
                              textAlign: TextAlign.start,
                            ),
                          ),
                          InkWell(
                            onTap: () {},
                            child: Padding(
                              padding: EdgeInsets.only(left: size.width * 0.16),
                              child: InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            TrackOrderScreen(),
                                      ));
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(20),
                                        color: colorgreen),
                                    width: size.width * 0.26,
                                    height: size.width * 0.09,
                                    child: const Center(
                                        child: Text('Track Order'))),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
