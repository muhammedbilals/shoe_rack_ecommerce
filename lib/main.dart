import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shoe_rack_ecommerce/presentation/login_or_signup/screens/login_or_signup_page.dart';
import 'package:shoe_rack_ecommerce/presentation/main_pages/main_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shoe_rack_ecommerce/presentation/main_pages/sudo_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ShoeRack',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        fontFamily:
            GoogleFonts.quicksand(fontWeight: FontWeight.w600).fontFamily,
        primarySwatch: Colors.blue,
      ),
      home: SudoPage(),
    );
  }
}
