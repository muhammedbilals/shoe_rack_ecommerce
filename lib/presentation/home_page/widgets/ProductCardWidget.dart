import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce/core/colors.dart';
import 'package:shoe_rack_ecommerce/presentation/product_page/screens/product_page.dart';

class ProductCardWidget extends StatelessWidget {
  const ProductCardWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductPage(),
            ));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
          width: size.width * 0.44,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: const Align(
                    alignment: Alignment.topRight,
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Icon(Icons.favorite_border_outlined),
                    )),
                width: size.width * 0.45,
                height: size.width * 0.45,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.amber),
              ),
              const Padding(
                padding: EdgeInsets.only(
                  left: 8.0,
                  right: 8.0,
                  top: 8.0,
                ),
                child: Text(
                  'Puma',
                  style: TextStyle(fontSize: 20),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Text(
                  'Men White & Black Colourblocked IDP Sneakers',
                  style: TextStyle(
                      // overflow: TextOverflow.clip,
                      fontSize: 14,
                      color: colorblack.withOpacity(0.5)),
                  textAlign: TextAlign.start,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 8.0, top: 5),
                child: Row(
                  children: [
                    const Text('4.5'),
                    const Icon(
                      Icons.star_border,
                      size: 17,
                    ),
                    const Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text('|'),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: Container(
                        child: const Padding(
                          padding: EdgeInsets.all(2.0),
                          child: Text(
                            '4300 SOLD',
                            textAlign: TextAlign.center,
                          ),
                        ),
                        width: size.width * 0.2,
                        height: size.width * 0.05,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: colorgray),
                      ),
                    )
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 8.0),
                child: Text(
                  'Rs .1619',
                  style: TextStyle(fontSize: 22),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}