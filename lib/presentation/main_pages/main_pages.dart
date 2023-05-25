import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce/presentation/cart_page/screens/cart_page.dart';
import 'package:shoe_rack_ecommerce/presentation/home_page/screens/home_page.dart';
import 'package:shoe_rack_ecommerce/presentation/main_pages/bottomnavigation.dart';
import 'package:shoe_rack_ecommerce/presentation/orders_page/screens/orders_page.dart';
import 'package:shoe_rack_ecommerce/presentation/profile_page/screens/profile_page.dart';

class MainPage extends StatelessWidget {
  MainPage({super.key});

  final pages = [ HomePage(),   CartPage(), const OrdersPage(),  ProfilePage()];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ValueListenableBuilder(
        valueListenable: indexChangeNotifier,
        builder: (context, int value, child) {
          return pages[value];
        },
      ),
      bottomNavigationBar: const BottomNavigationBarWidget(),
    );
  }
}
