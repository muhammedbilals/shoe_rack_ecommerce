import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce/presentation/common_widget/AppBarWidget.dart';

import '../widgets/ProductCardWidget.dart';

class BrandProductPage extends StatelessWidget {
  const BrandProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBarWidget(title: 'Nike')),
          body: ListView(
        children: const [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ProductCardWidget(),
              ProductCardWidget(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ProductCardWidget(),
              ProductCardWidget(),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ProductCardWidget(),
              ProductCardWidget(),
            ],
          ),
        ],
      ),
    );
  }
}
