import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce/core/colors/colors.dart';
import 'package:shoe_rack_ecommerce/core/constant/constant.dart';
import 'package:shoe_rack_ecommerce/core/icons/custom_icon_icons.dart';
import 'package:shoe_rack_ecommerce/presentation/cart_page/widgets/cartdetailswidget_bottomsheet.dart';
import 'package:shoe_rack_ecommerce/presentation/cart_page/widgets/product_delete_bottomsheet.dart';

class CartDetailsWidget extends StatelessWidget {
  const CartDetailsWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.all(0.0),
      child: Center(
        child: Container(
          width: size.width * 0.95,
          height: size.width * 0.45,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20), color: colorgray),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: 90,
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
                        const Padding(
                          padding:
                              EdgeInsets.only(left: 12.0, top: 0, bottom: 0),
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
                          icon: const Icon(CustomIcon.delete_4iconfluttter),
                          onPressed: () {
                            productDeleteBottomsheet(context, size);
                          },
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
                        Padding(
                          padding: EdgeInsets.only(
                              left: size.width * 0.12, right: 10),
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: colorgreen),
                            width: size.width * 0.29,
                            height: size.width * 0.09,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: const Icon(
                                    CustomIcon.minusiconfluttter,
                                    size: 14,
                                  ),
                                  onPressed: () {},
                                ),
                                const Text('1'),
                                IconButton(
                                  icon: const Icon(
                                    CustomIcon.addiconfluttter,
                                    size: 14,
                                  ),
                                  onPressed: () {},
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
      ),
    );
  }


}
