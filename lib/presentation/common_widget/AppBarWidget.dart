import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce/core/icons/custom_icon_icons.dart';

class AppBarWidget extends StatelessWidget {
  final String title;
  const AppBarWidget({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          IconButton(
            icon: const Icon(
              CustomIcon.lefticonfluttter,
              size: 30,
            ),
            onPressed: () {},
          ),
          const Spacer(),
          Center(
            child: Text(
              title,
              style: const TextStyle(fontSize: 20),
            ),
          ),
          const Spacer(),
          IconButton(
            icon: const Icon(
              CustomIcon.search_2iconfluttter,
              size: 20,
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
