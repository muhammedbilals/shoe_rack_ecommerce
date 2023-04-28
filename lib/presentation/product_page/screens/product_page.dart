import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shoe_rack_ecommerce/core/colors/colors.dart';
import 'package:shoe_rack_ecommerce/core/icons/custom_icon_icons.dart';

class ProductPage extends StatelessWidget {
  ProductPage({super.key});
  final img = [
    'asset/images/Puma.png',
    'asset/images/puma22.png',
    'asset/images/puma33.png'
  ];
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Column(
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
                              child: Image.asset(
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
                        CustomIcon.stariconfluttter,
                        size: 17,
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
                          width: size.width * 0.25,
                          height: size.width * 0.07,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(20),
                              color: colorgray),
                          child: const Center(
                            child: Text(
                              '4300 SOLD',
                              textAlign: TextAlign.center,
                            ),
                          ),
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
              ],
            ),
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
          ],
        ),
      ),
    );
  }
}
