import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce/core/colors.dart';
import 'package:shoe_rack_ecommerce/presentation/home_page/screens/mostpopular_page.dart';
import 'package:shoe_rack_ecommerce/presentation/home_page/widgets/ProductCardWidget.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return SafeArea(
      child: Scaffold(
        // appBar: PreferredSize(
        //   preferredSize: size,
        // child: Image.asset('asset/images/Group 14logo vertical 1.svg')),
        body: ListView(children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  // border: Border(
                  //   bottom: BorderSide(width: 3, color: colorgreen),
                  // ),
                  color: colorgray,
                  borderRadius: BorderRadius.circular(20)),
              child: Row(
                children: const [
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Icon(Icons.search),
                  ),
                  SizedBox(
                    width: 300,
                    child: TextField(
                      decoration: InputDecoration.collapsed(hintText: 'Search'),
                    ),
                  )
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              child: Image.asset(
                'asset/images/Group 21.png',
                fit: BoxFit.contain,
              ),
              // child: Image.network('https://www.google.com/url?sa=i&url=https%3A%2F%2Fes.vecteezy.com%2Farte-vectorial%2F8564775-banner-de-zapatos-deportivos-para-sitio-web-con-boton-ui-design-vector-ilustracion&psig=AOvVaw3bvoR6sdVGt_JOFa3Ifk-0&ust=1682194941338000&source=images&cd=vfe&ved=0CBEQjRxqFwoTCMC5jtHmu_4CFQAAAAAdAAAAABAE'),
              width: size.width,
              height: 200,
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(20)),
            ),
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
                          builder: (context) => MostPopularPage(),
                        ));
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
    );
  }
}
