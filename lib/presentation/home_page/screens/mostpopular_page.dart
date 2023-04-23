import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shoe_rack_ecommerce/presentation/common_widget/AppBarWidget.dart';
import 'package:shoe_rack_ecommerce/presentation/home_page/widgets/ProductCardWidget.dart';

class MostPopularPage extends StatelessWidget {
  const MostPopularPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      appBar: const PreferredSize(
          child: AppBarWidget(title: 'Most Popular'),
          preferredSize: Size.fromHeight(60)),
      body: ListView(
        children: [
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
        ],
      ),
    ));
  }
}
