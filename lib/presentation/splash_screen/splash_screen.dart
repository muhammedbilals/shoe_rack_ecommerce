import 'package:flutter/material.dart';
import 'package:shoe_rack_ecommerce/core/colors/colors.dart';
import 'package:shoe_rack_ecommerce/presentation/main_pages/sudo_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;

    Future.delayed(const Duration(seconds: 1), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const SudoPage()),
      );
    });
    return SafeArea(
      child: Scaffold(
        backgroundColor: colorwhite,
        body: Center(
          child: SizedBox(
              height: size.width * 0.4,
              width: size.width * 0.4,
              child: Image.asset('asset/images/shoerackmainlogo.png')),
        ),
      ),
    );
  }
}
