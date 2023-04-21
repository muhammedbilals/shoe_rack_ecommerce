import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoe_rack_ecommerce/presentation/main_pages/main_pages.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        fontFamily:
            GoogleFonts.quicksand(fontWeight: FontWeight.w600).fontFamily,
        primarySwatch: Colors.blue,
      ),
      home: MainPage(),
    );
  }
}