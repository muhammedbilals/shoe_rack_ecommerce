import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shoe_rack_ecommerce/core/colors.dart';

class ProductPage extends StatelessWidget {
  const ProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CarouselSlider(
              options:
                  CarouselOptions(height: MediaQuery.of(context).size.width),
              items: [1, 2, 3, 4, 5].map((i) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                        width: MediaQuery.of(context).size.width,
                        margin: const EdgeInsets.symmetric(horizontal: 5.0),
                        decoration: const BoxDecoration(color: Colors.amber),
                        child: Text(
                          'text $i',
                          style: const TextStyle(fontSize: 16.0),
                        ));
                  },
                );
              }).toList(),
            ),
            const Padding(
              padding: EdgeInsets.all(12.0),
              child: Text(
                'Puma',
                style: TextStyle(fontSize: 25),
                textAlign: TextAlign.start,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                'Men Black Solid Adivat Running Shoes',
                style: TextStyle(
                    // overflow: TextOverflow.clip,
                    fontSize: 20,
                    color: colorblack.withOpacity(0.5)),
                textAlign: TextAlign.start,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0, top: 5),
              child: Row(
                children: [
                  const Text(
                    '4.5',
                    style: TextStyle(fontSize: 20),
                  ),
                  const Icon(
                    Icons.star_border,
                    size: 22,
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(horizontal: 8.0),
                    child: Text(
                      '|',
                      style: TextStyle(fontSize: 20),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Container(
                      child: const Center(
                        child: Text(
                          '4300 SOLD',
                          textAlign: TextAlign.center,
                        ),
                      ),
                      width: size.width * 0.25,
                      height: size.width * 0.07,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: colorgray),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.only(left: 12.0),
              child: Text(
                '₹4,500',
                style: TextStyle(fontSize: 35),
                textAlign: TextAlign.start,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 12.0),
              child: Text(
                'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been theand typesetting industry Lorem Ipsum has been the  industrys standard dummy text ever',
                style: TextStyle(
                    // overflow: TextOverflow.clip,
                    fontSize: 18,
                    color: colorblack.withOpacity(0.5)),
                textAlign: TextAlign.start,
              ),
            ),
            // TextButton.icon(
            //   onPressed: () {},
            //   style: ButtonStyle(
            //     backgroundColor: MaterialStatePropertyAll<Color>(colorgreen),
            //   ),
            //   icon: Icon(
            //     Icons.badge,
            //     size: 20,
            //     color: colorwhite,
            //   ),
            //   label: Text(
            //     'Add to Cart',
            //     style: TextStyle(fontSize: 20, color: colorwhite),
            //   ),
            // ),
            Row(
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
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            side: BorderSide(color: colorgreen, width: 2),
                            borderRadius: BorderRadius.circular(18.0),
                          ))),
                      onPressed: () {},
                      child: Icon(
                        Icons.favorite_border_outlined,
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
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18.0),
                          ))),
                      onPressed: () {},
                      icon: Icon(
                        Icons.badge,
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
            )
          ],
        ),
      ),
    );
  }
}
