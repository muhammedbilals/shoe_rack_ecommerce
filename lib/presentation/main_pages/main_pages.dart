import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:shoe_rack_ecommerce/presentation/cart_page/cart_page.dart';
import 'package:shoe_rack_ecommerce/presentation/home_page/home_page.dart';
import 'package:shoe_rack_ecommerce/presentation/main_pages/bottomnavigation.dart';
import 'package:shoe_rack_ecommerce/presentation/orders_page/orders_page.dart';
import 'package:shoe_rack_ecommerce/presentation/profile_page/profile_page.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final pages = [HomePage(), CartPage(), OrdersPage(), ProfilePage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: indexChangeNotifier,
        builder: (context, int value, child) {
          return pages[value];
        },
      ),
      bottomNavigationBar: BottomNavigationBarWidget(),
    );
  }
}
