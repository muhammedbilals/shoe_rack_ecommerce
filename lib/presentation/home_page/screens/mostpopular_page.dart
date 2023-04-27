import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shoe_rack_ecommerce/core/colors/colors.dart';
import 'package:shoe_rack_ecommerce/presentation/common_widget/AppBarWidget.dart';
import 'package:shoe_rack_ecommerce/presentation/home_page/widgets/ProductCardWidget.dart';

class MostPopularPage extends StatefulWidget {
  const MostPopularPage({super.key});

  @override
  State<MostPopularPage> createState() => _MostPopularPageState();
}

class _MostPopularPageState extends State<MostPopularPage> {
  @override
  Widget build(BuildContext context) {
    int? value = 0; 
    return SafeArea(
        child: Scaffold(
      appBar: const PreferredSize(
          preferredSize: Size.fromHeight(60),
          child: AppBarWidget(title: 'Most Popular')),
      body: ListView(
        children: [
          Wrap(
            children: List<Widget>.generate(
              3,
              (int index) {
                return ChoiceChip(
                  selectedColor: colorgreen,
                  disabledColor: colorgray,
                  label: Text('Item $index'),
                 selected: value == index,
                    onSelected: (bool selected) {
                      setState(() {
                        value = index;
                      });
                    },
                );
              },
            ).toList(),
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
        ],
      ),
    ));
  }
}
