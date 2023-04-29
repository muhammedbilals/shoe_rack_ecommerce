import 'package:flutter/material.dart';

import 'package:shoe_rack_ecommerce/core/icons/custom_icon_icons.dart';

ValueNotifier<int> indexChangeNotifier = ValueNotifier(0);

class BottomNavigationBarWidget extends StatelessWidget {
  BottomNavigationBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: indexChangeNotifier,
      builder: (context, int value, _) {
        return BottomNavigationBar(
            type: BottomNavigationBarType.fixed,
            currentIndex: value,
            onTap: (index) {
              indexChangeNotifier.value = index;
            },
            elevation: 0,
            backgroundColor: Colors.white,
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.black.withOpacity(0.3),
            items: const [
              BottomNavigationBarItem(
                  tooltip: 'Home',
                  activeIcon: Icon(CustomIcon.home_1flutter),
                  icon: Icon(CustomIcon.home2iconfluttter),
                  label: 'Home'),
              BottomNavigationBarItem(
                  tooltip: 'Cart',
                  activeIcon: Icon(CustomIcon.bag_1flutter),
                  icon: Icon(CustomIcon.bagiconfluttter),
                  label: "Cart"),
              BottomNavigationBarItem(
                  tooltip: 'Orders',
                  activeIcon: Icon(CustomIcon.buy_2flutter),
                  icon: Icon(CustomIcon.buy_2iconfluttter),
                  label: "Orders"),
              BottomNavigationBarItem(
                  tooltip: 'Profile',
                  activeIcon: Icon(CustomIcon.profile_1flutter),
                  icon: Icon(CustomIcon.profile_1iconfluttter),
                  label: "Profile"),
            ]);
      },
    );
  }
}
