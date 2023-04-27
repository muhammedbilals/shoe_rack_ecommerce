import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce/core/colors/colors.dart';
import 'package:shoe_rack_ecommerce/core/icons/custom_icon_icons.dart';
import 'package:shoe_rack_ecommerce/core/images/images.dart';
import 'package:shoe_rack_ecommerce/presentation/home_page/screens/mostpopular_page.dart';
import 'package:shoe_rack_ecommerce/presentation/home_page/screens/my_wishlist_page.dart';
import 'package:shoe_rack_ecommerce/presentation/home_page/widgets/ProductCardWidget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: size,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 15.0, top: 5),
                child: SizedBox(
                  width: 170,
                  height: 50,
                  child: Image.asset('asset/images/shoeracklogovert.png'),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: IconButton(
                  icon: const Icon(CustomIcon.hearticonfluttter),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const WishListScreen(),
                        ));
                  },
                ),
              )
            ],
          ),
        ),
        body: SingleChildScrollView(
          child: Column(children: [
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
                child: Row(
                  children: const [
                    Padding(
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
                          decoration: InputDecoration.collapsed(
                              hintText: 'Search',
                              hintStyle: TextStyle(fontSize: 19)),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: size.width,
                height: 200,
                decoration:
                    BoxDecoration(borderRadius: BorderRadius.circular(20)),
                child: Image.asset(
                  'asset/images/Group23pumalogo.png',
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BrandTileWidget(image: logoimg[0]),
                BrandTileWidget(image: logoimg[1]),
                BrandTileWidget(image: logoimg[2]),
                BrandTileWidget(image: logoimg[3]),
              ],
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                BrandTileWidget(image: logoimg[4]),
                BrandTileWidget(image: logoimg[5]),
                BrandTileWidget(image: logoimg[6]),
                BrandTileWidget(image: logoimg[7]),
              ],
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Most Popular',
                    style: TextStyle(fontSize: 20),
                    textAlign: TextAlign.start,
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const MostPopularPage(),
                        ),
                      );
                    },
                    child: const Text(
                      'SEE ALL',
                      style: TextStyle(fontSize: 18),
                      textAlign: TextAlign.start,
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                ProductCardWidget(),
                ProductCardWidget(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                ProductCardWidget(),
                ProductCardWidget(),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: const [
                ProductCardWidget(),
                ProductCardWidget(),
              ],
            ),
          ]),
        ),
      ),
    );
  }
}

class BrandTileWidget extends StatelessWidget {
  final String image;
  const BrandTileWidget({
    required this.image,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: colorgray,
              // color: Colors.amber,
            ),
            height: 70,
            width: 70,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(40),
              child: Image.asset(
                image,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const Text(
            'Puma',
            style: TextStyle(fontSize: 18),
          )
        ],
      ),
    );
  }
}
