import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce/core/images/images.dart';
import 'package:shoe_rack_ecommerce/presentation/home_page/screens/brand_product_page.dart';
import 'package:shoe_rack_ecommerce/presentation/home_page/screens/home_page.dart';

class BrandListTile extends StatelessWidget {
  const BrandListTile({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    // final Size size = MediaQuery.of(context).size;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          crossAxisCount: 4,
          crossAxisSpacing: 1,
          mainAxisSpacing: 0,
          childAspectRatio: 1 / 1.05,
          children: List.generate(
            logoimg.length,
            (index) => GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>
                            BrandProductScreen(brandName: logoName[index]),
                      ));
                },
                child: BrandTileWidget(
                    image: logoimg[index], logoname: logoName[index])),
          ),
        ),
      ],
    );
  }
}
