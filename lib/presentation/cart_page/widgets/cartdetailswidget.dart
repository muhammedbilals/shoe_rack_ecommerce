import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce/core/colors/colors.dart';
import 'package:shoe_rack_ecommerce/core/icons/custom_icon_icons.dart';

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
        height: size.width * 0.39,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20), color: colorgray),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width: 100,
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
                  child: Row(
                    // crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(left: 12.0, top: 0, bottom: 0),
                        child: Text(
                          'Puma',
                          style: TextStyle(
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Flex(direction: Axis.horizontal),
                      IconButton(
                        icon: Icon(CustomIcon.delete_4iconfluttter),
                        onPressed: () {},
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: size.width * 0.6,
                  child: Padding(
                    padding:
                        const EdgeInsets.only(left: 12.0, bottom: 0, top: 0),
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
                  padding: const EdgeInsets.only(left: 12.0),
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
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      const Center(
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
                        padding: EdgeInsets.only(left: 12.0, top: 0, bottom: 0),
                        child: Text(
                          '₹7,500',
                          style: TextStyle(fontSize: 25),
                          textAlign: TextAlign.start,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: size.width * 0.16),
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
                                icon: const Icon(CustomIcon.minusiconfluttter),
                                onPressed: () {},
                              ),
                              const Text('1'),
                              Container(
                                child: IconButton(
                                  icon: const Icon(CustomIcon.addiconfluttter),
                                  onPressed: () {},
                                ),
                              ),
                            ],
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
    );
  }
}
