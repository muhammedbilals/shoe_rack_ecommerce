import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

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
              BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.shopping_basket_outlined), label: "Cart"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.emoji_emotions), label: "Orders"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.search), label: "Profile"),
            ]);
      },
    );
  }
}
